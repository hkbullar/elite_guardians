import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_guardians/global/API.dart';
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/global/EliteAppBar.dart';
import 'package:elite_guardians/pojo/Booking.dart';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;


class TrackDriverGuardianScreen extends StatefulWidget
{
  Booking booking;
  TrackDriverGuardianScreen(this.booking);
  @override
  _TrackDriverGuardianScreenState createState() => _TrackDriverGuardianScreenState(booking);
}

class _TrackDriverGuardianScreenState extends State<TrackDriverGuardianScreen> {
  _TrackDriverGuardianScreenState(this.booking);
  Booking booking;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  LatLng SOURCE_LOCATION = LatLng(30.5882408,76.8438542);
  LatLng DEST_LOCATION = LatLng(30.7334421,76.7797143);
  LatLng currentLocation = LatLng(30.7334421,76.7797143);

  PolylinePoints polylinePoints;
  String googleAPIKey = "AIzaSyD3hJNvatQ8W1cPBS4ZeLS8U8T5x0YQqMY";
  Guardian guardian;
  Driver driver;
  bool isJourney=false;

  @override
  void initState() {
    if(booking.guardians!=null && booking.guardians.length>0){
      guardian=booking.guardians[0];
    }
    else if(booking.drivers!=null && booking.drivers.length>0){
      driver=booking.drivers[0];
    }

   if(guardian!=null)
   {isJourney=false;}

   else if(driver!=null)
   {
     isJourney=true;

     SOURCE_LOCATION=LatLng(double.tryParse(booking.destinationLat),double.tryParse(booking.destinationLong));
     DEST_LOCATION=LatLng(double.tryParse(booking.arrivalLat),double.tryParse(booking.arrivalLong));
   }

   polylinePoints = PolylinePoints();
    showPinsOnMapForJourney();
    getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION
    );
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude,
              currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING
      );
    }
    return Scaffold(
      appBar: EliteAppBar(isJourney?"Tracking Driver":"Tracking Journey"),
      backgroundColor: AppColours.black,
      body:  Stack(
        children: <Widget>[
          GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: false,
              markers: _markers,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
               // showPinsOnMap();
              })
        ],
      ),
    );
  }
  showPinsOnMapForJourney()async
  {
    if(currentLocation!=null){
      var currentPosition = LatLng(currentLocation.latitude,currentLocation.longitude);
      _markers.add(Marker(
          markerId: MarkerId('current'),
          position: currentPosition,
          icon: BitmapDescriptor.fromBytes(await getCurrentMarkerIcon())
      ));
    }
    if(isJourney){
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: SOURCE_LOCATION
      ));

      _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: DEST_LOCATION,
      ));
      setPolylines();
    }
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,PointLatLng(SOURCE_LOCATION.latitude,SOURCE_LOCATION.longitude),PointLatLng(
        DEST_LOCATION.latitude,DEST_LOCATION.longitude));
    if(result.points.isNotEmpty)
    {
      result.points.forEach((PointLatLng point)
      {
        polylineCoordinates.add(LatLng(point.latitude,point.longitude));
      });
      setState(()
      {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: AppColours.textFeildBG,
            points: polylineCoordinates
        ));
      });
    }
  }
  Future<Uint8List> getCurrentMarkerIcon() async
  {
    return  await getBytesFromAsset('assets/images/ic_car_black.png',120);
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async
  {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  getCurrentLocation(){
    FirebaseFirestore.instance
        .collection('users')
        .doc(isJourney?"${driver.driverId}":"${guardian.guardId}")
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
        if(documentSnapshot.exists){
          Map<String, dynamic> firestormInfo = documentSnapshot.data();
          setState(() {
           currentLocation=LatLng(double.tryParse("${firestormInfo["latitude"]}"), double.tryParse("${firestormInfo["longitude"]}"));
          });
        }
    })
        .onError((e) => print(e));
    Stream documentStream = FirebaseFirestore.instance.collection('users').doc(isJourney?"${driver.driverId}":"${guardian.guardId}").snapshots();
    documentStream.listen((event) {

    });
  }
}