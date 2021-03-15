
import 'package:elite_guardians/global/API.dart';
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/global/EliteAppBar.dart';
import 'package:elite_guardians/global/Size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:intl/intl.dart';

class BookJourneyScreen extends StatefulWidget
{
  @override
  _BookJourneyScreenState createState() => _BookJourneyScreenState();
}

class _BookJourneyScreenState extends State<BookJourneyScreen> {
  DateTime selectedDate=DateTime.now();
  int bookNowOrLater=0;
  int guardSelection=1;
  bool guardCheckedOrNot=false;
  TimeOfDay timeFrom;
  String fromLocation;
  String toLocation;
  LatLng kInitialPosition = LatLng(51.507351,-0.127758);
  var _fromLocController = TextEditingController();
  var _toLocController = TextEditingController();
  @override
  void initState() {
    timeFrom=TimeOfDay.fromDateTime(selectedDate);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size().init(context);
    return Scaffold(
      appBar: EliteAppBar("Book a Journey"),
      backgroundColor: AppColours.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Source",style: TextStyle(color: AppColours.white,fontSize: 16),),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return PlacePicker(
                                apiKey: Constants.API_KEY,
                                initialPosition: kInitialPosition,
                                useCurrentLocation: true,
                                selectInitialPosition: true,
                                //usePlaceDetailSearch: true,
                                onPlacePicked: (result) {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    //selectedPlace = result;
                                    _fromLocController.text=result.formattedAddress;
                                  });
                                });})
                  );
                },
                child: TextField(
                  enabled: false,
                  controller: _fromLocController,
                  style: TextStyle(color: Colors.white),
                  decoration: CommonWidgets.loginFormDecoration("Enter Your Location",Icons.location_on_outlined),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Destination",style: TextStyle(color: AppColours.white,fontSize: 16),),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return PlacePicker(
                                apiKey: Constants.API_KEY,
                                initialPosition: kInitialPosition,
                                useCurrentLocation: true,
                                selectInitialPosition: true,
                                //usePlaceDetailSearch: true,
                                onPlacePicked: (result) {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    //selectedPlace = result;
                                    _toLocController.text=result.formattedAddress;
                                  });
                                });})
                  );
                },
                child: TextField(
                  enabled: false,
                  controller: _toLocController,
                  style: TextStyle(color: Colors.white),
                  decoration: CommonWidgets.loginFormDecoration("Enter Your Location",Icons.location_on_outlined),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Book For",style: TextStyle(color: AppColours.white,fontSize: 16),),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 0,
                      toggleable: true,
                      groupValue: bookNowOrLater,
                    tileColor: AppColours.textFeildBG,
                      title: Text("Now",style: TextStyle(color: AppColours.white,fontSize: 16)),
                      activeColor: AppColours.golden_button_bg,
                      onChanged: (val)
                      {
                        if(val!=null){
                          setState((){
                            bookNowOrLater=val;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: RadioListTile(
                      value: 1,
                      toggleable: true,
                      groupValue: bookNowOrLater,
                    tileColor: AppColours.textFeildBG,
                      title: Text("Later",style: TextStyle(color: AppColours.white,fontSize: 16)),
                      activeColor: AppColours.golden_button_bg,
                      onChanged: (val)
                      {
                        if(val!=null){
                          setState((){
                            bookNowOrLater=val;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: bookNowOrLater==1?20:0,),
              bookNowOrLater==1?Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Date",style: TextStyle(color: AppColours.white,fontSize: 16),),
                      ),
                      InkWell(
                        onTap: (){
                          _selectDate(context);
                        },
                        child: TextField(
                          enabled: false,
                          style: TextStyle(color: Colors.white),
                          decoration: CommonWidgets.loginFormDecoration(selectedDate==null?"Select Date":DateFormat("dd MMM").format(selectedDate),Icons.calendar_today),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Time",style: TextStyle(color: AppColours.white,fontSize: 16),),
                      ),
                      InkWell(
                        onTap: (){
                          _pickFromTime();
                        },
                        child: TextField(
                          enabled: false,
                          style: TextStyle(color: Colors.white),
                          decoration: CommonWidgets.loginFormDecoration(timeFrom==null?"Select Time":formatTimeOfDay(timeFrom),Icons.access_time_outlined),
                        ),
                      ),
                    ],
                  ),
                )
              ],):SizedBox(),
              SizedBox(height: 20),
              CheckboxListTile(
            tileColor: AppColours.textFeildBG,
                  activeColor: AppColours.golden_button_bg,
                  title: Text("Need Guardian?",style: TextStyle(color: AppColours.white,fontSize: 16)),
                  value: guardCheckedOrNot,
                  onChanged: (value){
                setState(() {
                  guardCheckedOrNot=value;
                });
              }),
              SizedBox(height: guardCheckedOrNot?20:0),
              guardCheckedOrNot?Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 1,
                      toggleable: true,
                      groupValue: guardSelection,
                      tileColor: AppColours.textFeildBG,
                      title: Text("1",style: TextStyle(color: AppColours.white,fontSize: 16)),
                      activeColor: AppColours.golden_button_bg,
                      onChanged: (val)
                      {
                        if(val!=null){
                          setState((){
                            guardSelection=val;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: RadioListTile(
                      value: 2,
                      toggleable: true,
                      groupValue: guardSelection,
                      tileColor: AppColours.textFeildBG,
                      title: Text("2",style: TextStyle(color: AppColours.white,fontSize: 16)),
                      activeColor: AppColours.golden_button_bg,
                      onChanged: (val)
                      {
                        if(val!=null){
                          setState((){
                            guardSelection=val;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ):SizedBox(),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Comments",style: TextStyle(color: AppColours.white,fontSize: 16),),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: CommonWidgets.loginFormDecoration("Enter Your Comments",Icons.comment_bank_outlined),
              ),
              SizedBox(height: 20,),
              CommonWidgets.goldenFullWidthButton("Get Quote",onClick: (){_createRequestClick(context);})
            ],
          )
        ),
      )
    );
  }
  _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
   var tomorrow = DateTime(currentDate.year, currentDate.month, currentDate.day + 14);
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: currentDate, // Refer step 1
      firstDate: currentDate,
      lastDate: tomorrow,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  _createRequestClick(BuildContext con)
  {
if(_vaildate()){
  DateTime currentDate = DateTime.now();
  int guardsCount=0;
  if(guardCheckedOrNot){
    guardsCount=guardSelection;
  }
  if(bookNowOrLater!=0){
    currentDate=selectedDate;
  }
  Map jsonPost = {
    Constants.REQUEST_DESTINATION: _fromLocController.text,
    Constants.REQUEST_ARRIVAL: _toLocController.text,
    Constants.REQUEST_DATE: DateFormat("yyyy-MM-dd").format(currentDate),
    Constants.REQUEST_TIME: DateFormat.Hm().format(currentDate),
    Constants.REQUEST_SECURITY: "$guardsCount",
    Constants.REQUEST_IS_ADMIN: "0",
  };
  FocusScope.of(context).unfocus();
  API(context).createRequest(jsonPost);
  }
  }
  bool _vaildate(){
    if(_fromLocController.text==null || _fromLocController.text.isEmpty){
      CommonWidgets.showMessage(context,"Please Enter Source Location");
      return false;
    }
    else if(_toLocController.text==null || _toLocController.text.isEmpty){
      CommonWidgets.showMessage(context,"Please Enter Destination Location");
      return false;
    }
    else if(bookNowOrLater==1 && selectedDate==null){
      CommonWidgets.showMessage(context,"Please Enter Date for Journey");
      return false;
    }
    else if(bookNowOrLater==1 && timeFrom==null){
      CommonWidgets.showMessage(context,"Please Enter Time of Journey");
      return false;
    }
    return true;
  }
  _pickFromTime() async {
    TimeOfDay currentTime=TimeOfDay.now();
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: currentTime
    );
    if(t != null)
      setState(() {
        timeFrom = t;
        selectedDate=DateTime(selectedDate.year, selectedDate.month, selectedDate.day,timeFrom.hour,timeFrom.minute,0);
      });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }
}