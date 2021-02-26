
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/global/EliteAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:intl/intl.dart';

class HireGuardScreen extends StatefulWidget
{
  @override
  _HireGuardScreenState createState() => _HireGuardScreenState();
}

class _HireGuardScreenState extends State<HireGuardScreen> {
  DateTime selectedDateFrom,selectedDateTo;

  int bookNowOrLater=0;
  int guardSelection=0;

  bool guardCheckedOrNot=false;

  TimeOfDay timeFrom,timeTo;

  PickResult selectedPlace;

  LatLng kInitialPosition = LatLng(51.507351,-0.127758);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EliteAppBar("Hire Guards"),
      backgroundColor: AppColours.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("For",style: TextStyle(color: AppColours.white,fontSize: 16),),
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
                                    selectedPlace = result;
                                  });
                                });}));
                },
                child: TextField(
                  enabled: false,
                  style: TextStyle(color: Colors.white),
                  decoration: CommonWidgets.loginFormDecoration("Enter Your Location",Icons.location_on_outlined),
                ),
              ),
              SizedBox(height: 20,),
              Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Timing",style: TextStyle(color: AppColours.white,fontSize: 16),),
                      ),
                      InkWell(
                        onTap: (){
                          _pickFromTime();
                        },
                        child: TextField(
                          enabled: false,
                          style: TextStyle(color: Colors.white),
                          decoration: CommonWidgets.loginFormDecoration(timeFrom==null?"From":formatTimeOfDay(timeFrom),Icons.access_time_outlined),
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
                        child: Text("",style: TextStyle(color: AppColours.white,fontSize: 16),),
                      ),
                      InkWell(
                        onTap: (){
                          _pickToTime();
                        },
                        child: TextField(
                          enabled: false,
                          style: TextStyle(color: Colors.white),
                          decoration: CommonWidgets.loginFormDecoration(timeTo==null?"To":formatTimeOfDay(timeTo),Icons.access_time_outlined),
                        ),
                      ),
                    ],
                  ),
                )
              ],),
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
                      title: Text("Once",style: TextStyle(color: AppColours.white,fontSize: 16)),
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
                      title: Text("Multiple Days",style: TextStyle(color: AppColours.white,fontSize: 16)),
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
              SizedBox(height: 20,),
              bookNowOrLater==1?Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Select Days",style: TextStyle(color: AppColours.white,fontSize: 16),),
                      ),
                      InkWell(
                        onTap: (){
                          _selectFromDate(context);
                        },
                        child: TextField(
                          enabled: false,
                          style: TextStyle(color: Colors.white),
                          decoration: CommonWidgets.loginFormDecoration(selectedDateFrom==null?"From":DateFormat("dd MMM").format(selectedDateFrom),Icons.calendar_today),
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
                        child: Text("",style: TextStyle(color: AppColours.white,fontSize: 16),),
                      ),
                      InkWell(
                        onTap: (){
                          _selectToDate(context);
                        },
                        child: TextField(
                          enabled: false,
                          style: TextStyle(color: Colors.white),
                          decoration: CommonWidgets.loginFormDecoration(selectedDateTo==null?"To":DateFormat("dd MMM").format(selectedDateTo),Icons.access_time_outlined),
                        ),
                      ),
                    ],
                  ),
                )
              ],):SizedBox(),
              SizedBox(height: 20),
              TextField(
                enabled: false,
                style: TextStyle(color: Colors.white),
                decoration: CommonWidgets.loginFormDecoration("Number of Guards Needed ?",Icons.person_outline),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 0,
                      toggleable: true,
                      groupValue: guardSelection,
                      tileColor: AppColours.textFeildBG,
                      title: Text("1 Guard",style: TextStyle(color: AppColours.white,fontSize: 16)),
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
                  SizedBox(width: 10,),
                  Expanded(
                    child: RadioListTile(
                      value: 1,
                      toggleable: true,
                      groupValue: guardSelection,
                      tileColor: AppColours.textFeildBG,
                      title: Text("2 Guards",style: TextStyle(color: AppColours.white,fontSize: 16)),
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
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 2,
                      toggleable: true,
                      groupValue: guardSelection,
                      tileColor: AppColours.textFeildBG,
                      title: Text("3 Guard",style: TextStyle(color: AppColours.white,fontSize: 16)),
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
                  SizedBox(width: 10,),
                  Expanded(
                    child: RadioListTile(
                      value: 3,
                      toggleable: true,
                      groupValue: guardSelection,
                      tileColor: AppColours.textFeildBG,
                      title: Text("4 Guards",style: TextStyle(color: AppColours.white,fontSize: 16)),
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
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                        padding: EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        color: AppColours.golden_button_bg,
                        child: Text("Get Quote",style: TextStyle(color: AppColours.black,fontWeight: FontWeight.bold,fontSize: 18),),
                        onPressed: (){
                          setState(() {

                          });
                        }),
                  ),
                ],
              ),
            ],
          )
        ),
      )
    );
  }
  _selectFromDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    var tomorrow = DateTime(currentDate.year, currentDate.month+2, currentDate.day);
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: currentDate, // Refer step 1
      firstDate: currentDate,
      lastDate: tomorrow,
    );
    if (picked != null && picked != selectedDateFrom)
      setState(() {
        selectedDateFrom = picked;
      });
  }
  _selectToDate(BuildContext context) async {
    DateTime currentDate = selectedDateFrom==null?DateTime.now():selectedDateFrom;
    var tomorrow = DateTime(currentDate.year, currentDate.month+2, currentDate.day);
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: currentDate, // Refer step 1
      firstDate: currentDate,
      lastDate: tomorrow,
    );
    if (picked != null && picked != selectedDateFrom)
      setState(() {
        selectedDateTo = picked;
      });
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
      });
  }
  _pickToTime() async {
    TimeOfDay currentTime=timeFrom==null?TimeOfDay.now():timeFrom;
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: currentTime
    );
    if(t != null)
      setState(() {
        timeTo = t;
      });
  }
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }
}