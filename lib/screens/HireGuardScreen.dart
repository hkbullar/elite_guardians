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
  List<CheckBoxListTileModel> checkBoxListTileModel =
  CheckBoxListTileModel.getUsers();
  int bookNowOrLater=0;
  int guardSelection=0;
  int weekDayOrFull=0;

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
                                });})
                  );
                },
                child: TextField(
                  enabled: false,
                  style: TextStyle(color: Colors.white),
                  decoration: CommonWidgets.loginFormDecoration("Enter Your Location",Icons.location_on_outlined),
                ),
              ),
              SizedBox(height: 20),
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
                SizedBox(width: 10),
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
              SizedBox(height: 20),
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
//                      tileColor: AppColours.textFeildBG,
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
                  SizedBox(width: 10),
                  Expanded(
                    child: RadioListTile(
                      value: 1,
                      toggleable: true,
                      groupValue: bookNowOrLater,
//                      tileColor: AppColours.textFeildBG,
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
              SizedBox(height: 20),
              bookNowOrLater==1?Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Select Date",style: TextStyle(color: AppColours.white,fontSize: 16),),
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
                SizedBox(width: 10),
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
              ]):SizedBox(),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 0,
                      toggleable: true,
                      groupValue: weekDayOrFull,
//                      tileColor: AppColours.textFeildBG,
                      title: Text("Full Week",style: TextStyle(color: AppColours.white,fontSize: 16)),
                      activeColor: AppColours.golden_button_bg,
                      onChanged: (val)
                      {
                        if(val!=null){
                          setState((){
                            weekDayOrFull=val;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: RadioListTile(
                      value: 1,
                      toggleable: true,
                      groupValue: weekDayOrFull,
//                      tileColor: AppColours.textFeildBG,
                      title: Text("Selected Days",style: TextStyle(color: AppColours.white,fontSize: 16)),
                      activeColor: AppColours.golden_button_bg,
                      onChanged: (val)
                      {
                        if(val!=null){
                          setState((){
                            weekDayOrFull=val;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              Container(height: 200,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 0.0,
                      childAspectRatio: 4.0,mainAxisSpacing: 3.0),
                  itemCount: checkBoxListTileModel.length,
                   scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return _checkBox(index);
                    },),
              ),
              /*Row(
                children: [
                  Expanded(child: _checkBox("Sun")),
                  Expanded(child: _checkBox("Mon")),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _checkBox("Tue")),
                  Expanded(child: _checkBox("Wed")),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _checkBox("Thu")),
                  Expanded(child: _checkBox("Fri")),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _checkBox("Sat")),
                  Expanded(child: Container()),
                ],
              ),*/
             /* Row(
                children: [
                  _checkBox("Sun"),
//                  Expanded(child: _checkBox("Mon")),

                ],
              ),*/
//              SizedBox(height: 20),
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
//                      tileColor: AppColours.textFeildBG,
                      title: Text("1 Guard",style: TextStyle(color: AppColours.white,fontSize: 16)),
                      activeColor: AppColours.golden_button_bg,
                      onChanged: (val) {
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
                      value: 1,
                      toggleable: true,
                      groupValue: guardSelection,
//                      tileColor: AppColours.textFeildBG,
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
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 2,
                      toggleable: true,
                      groupValue: guardSelection,
//                      tileColor: AppColours.textFeildBG,
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
                  SizedBox(width: 10),
                  Expanded(
                    child: RadioListTile(
                      value: 3,
                      toggleable: true,
                      groupValue: guardSelection,
//                      tileColor: AppColours.textFeildBG,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Comments",style: TextStyle(color: AppColours.white,fontSize: 16),),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: CommonWidgets.loginFormDecoration("Enter Your Comments",Icons.comment_bank_outlined),
              ),
              SizedBox(height: 20),
              CommonWidgets.goldenFullWidthButton("Get Quote",onClick: (){})
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
  Widget _checkBox(int index){
    return CheckboxListTile(
        value: checkBoxListTileModel[index].isCheck,
        title: Text(checkBoxListTileModel[index].title,style: TextStyle(fontSize: 16,color: AppColours.golden_button_bg),),
        activeColor: AppColours.golden_button_bg,
        dense: true,
        onChanged: (value){
          setState(() {
            checkBoxListTileModel[index].isCheck = value;
          });
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


class CheckBoxListTileModel {
  int dayId;
  String img;
  String title;
  bool isCheck;

  CheckBoxListTileModel({this.dayId, this.img, this.title, this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          dayId: 1,
          title: "Sun",
          isCheck: true),
      CheckBoxListTileModel(
          dayId: 2,
          title: "Mon",
          isCheck: false),
      CheckBoxListTileModel(
          dayId: 3,
          title: "Tue",
          isCheck: false),
      CheckBoxListTileModel(
          dayId: 4,
          title: "Wed",
          isCheck: false),
      CheckBoxListTileModel(
          dayId: 5,
          title: "Thu",
          isCheck: false),
      CheckBoxListTileModel(
          dayId: 6,
          title: "Fri",
          isCheck: false),
      CheckBoxListTileModel(
          dayId: 7,
          title: "Sat",
          isCheck: false),
    ];
  }
}
