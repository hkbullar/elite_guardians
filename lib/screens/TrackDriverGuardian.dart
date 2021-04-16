import 'package:elite_guardians/global/API.dart';
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/global/EliteAppBar.dart';
import 'package:elite_guardians/pojo/Booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TrackDriverGuardianScreen extends StatefulWidget
{
  Guardian guardian;
  Driver driver;
  TrackDriverGuardianScreen(this.driver,this.guardian);
  @override
  _TrackDriverGuardianScreenState createState() => _TrackDriverGuardianScreenState(driver,guardian);
}

class _TrackDriverGuardianScreenState extends State<TrackDriverGuardianScreen> {
  _TrackDriverGuardianScreenState(this.driver,this.guardian);

  Guardian guardian;
  Driver driver;
  bool isJourney=false;

  @override
  void initState() {
   if(guardian!=null){isJourney=false;}
   else if(driver!=null){isJourney=true;}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EliteAppBar(isJourney?"Tracking Driver":"Tracking Journey"),
      backgroundColor: AppColours.black,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(),
      )
    );
  }
}