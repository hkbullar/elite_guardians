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

class HireGuardScreen extends StatefulWidget
{
  HireGuardScreen({this.title});
  String title;
  @override
  _HireGuardScreenState createState() => _HireGuardScreenState(title);
}

class _HireGuardScreenState extends State<HireGuardScreen> {
  _HireGuardScreenState(this.title);
  DateTime selectedDateFrom,selectedDateTo;
  List<CheckBoxListTileModel> checkBoxListTileModel =
  CheckBoxListTileModel.getUsers();
  int bookNowOrLater=0;
  int guardSelection=0;
  int weekDayOrFull=0;
  String title;
  bool guardCheckedOrNot=false;

  TimeOfDay timeFrom,timeTo;

  PickResult selectedPlace;

  LatLng kInitialPosition = LatLng(51.507351,-0.127758);

  @override
  Widget build(BuildContext context) {
    Size().init(context);
    return Scaffold(
      appBar: EliteAppBar(title==null?"Hire Guards":"Hire ${title}"),
      backgroundColor: AppColours.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: Size.size(25),right: Size.size(25),top: Size.size(5),bottom: Size.size(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(Size.size(8)),
                child: Text("For",style: TextStyle(color: AppColours.white,fontSize: Size.size(16)),),
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
              SizedBox(height: Size.size(20)),
              Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(Size.size(8)),
                        child: Text("Timing",style: TextStyle(color: AppColours.white,fontSize: Size.size(16)),),
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
                SizedBox(width: Size.size(10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Size.size(8)),
                        child: Text("",style: TextStyle(color: AppColours.white,fontSize: Size.size(16)),),
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
              SizedBox(height: Size.size(20)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Book For",style: TextStyle(color: AppColours.white,fontSize: Size.size(16)),),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 0,
                      toggleable: true,
                      groupValue: bookNowOrLater,
                     tileColor: AppColours.textFeildBG,
                      title: Text("Once",style: TextStyle(color: AppColours.white,fontSize: Size.size(16))),
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
                  SizedBox(width: Size.size(10)),
                  Expanded(
                    child: RadioListTile(
                      value: 1,
                      toggleable: true,
                      groupValue: bookNowOrLater,
                      tileColor: AppColours.textFeildBG,
                      title: Text("Multiple Days",style: TextStyle(color: AppColours.white,fontSize: Size.size(16))),
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
              SizedBox(height: Size.size(20)),
              bookNowOrLater==1?Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Size.size(8)),
                        child: Text("Select Date",style: TextStyle(color: AppColours.white,fontSize: Size.size(16)),),
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
                SizedBox(width: Size.size(10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Size.size(8)),
                        child: Text("",style: TextStyle(color: AppColours.white,fontSize: Size.size(16)),),
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
              SizedBox(height: bookNowOrLater==1?Size.size(20):0),
              bookNowOrLater==1?Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 0,
                      toggleable: true,
                      groupValue: weekDayOrFull,
                      tileColor: AppColours.textFeildBG,
                      title: Text("Full Week",style: TextStyle(color: AppColours.white,fontSize: Size.size(16))),
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
                  SizedBox(width: Size.size(10)),
                  Expanded(
                    child: RadioListTile(
                      value: 1,
                      toggleable: true,
                      groupValue: weekDayOrFull,
                     tileColor: AppColours.textFeildBG,
                      title: Text("Selected Days",style: TextStyle(color: AppColours.white,fontSize: Size.size(16))),
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
              ):SizedBox(),
              SizedBox(height: weekDayOrFull==1 && bookNowOrLater==1?Size.size(15):0),
              weekDayOrFull==1 && bookNowOrLater==1?GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                childAspectRatio: Size.size(10)/10,
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                  children: List.generate(7,(index){
                    return _checkBox(index);
                  })
                  ):SizedBox(),

              title==null?Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Size.size(15)),
                  TextField(
                    enabled: false,
                    style: TextStyle(color: Colors.white),
                    decoration: CommonWidgets.loginFormDecoration("Number of Guardians Needed ?",Icons.person_outline),
                  ),
                  SizedBox(height: Size.size(20)),
                  Row(
                    children: [
                      guardListTile(1),
                      SizedBox(width: Size.size(10)),
                      guardListTile(2),
                    ],
                  ),
                  SizedBox(height: Size.size(10)),
                  Row(
                    children: [
                      guardListTile(3),
                      SizedBox(width: Size.size(10)),
                      guardListTile(4),
                    ],
                  ),
                ],
              ):SizedBox(),

              SizedBox(height: Size.size(20)),
              Padding(
                padding: EdgeInsets.all(Size.size(8)),
                child: Text("Comments",style: TextStyle(color: AppColours.white,fontSize: Size.size(16)),),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: CommonWidgets.loginFormDecoration("Enter Your Comments",Icons.comment_bank_outlined),
              ),
              SizedBox(height: Size.size(20)),
              CommonWidgets.goldenFullWidthButton("Get Quote",onClick: (){})
            ],
          )
        ),
      )
    );
  }
 Widget guardListTile(int value){
   return Expanded(
      child: RadioListTile(
        value: value,
        toggleable: true,
        groupValue: guardSelection,
        tileColor: AppColours.textFeildBG,
        title: Text("$value",style: TextStyle(color: AppColours.white,fontSize: Size.size(16))),
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
    return Padding(
      padding: EdgeInsets.all(Size.size(5)),
      child: InkWell(
        onTap: (){
          setState(() {
            checkBoxListTileModel[index].isCheck = !checkBoxListTileModel[index].isCheck;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColours.textFeildBG,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                  value: checkBoxListTileModel[index].isCheck,
                  activeColor: AppColours.golden_button_bg,
                  onChanged: (value){}),
              Text(checkBoxListTileModel[index].title,style: TextStyle(fontSize: Size.size(16),color: AppColours.white),),
              SizedBox(height: Size.size(5))
            ],
          ),
        ),
      ),
    );
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
