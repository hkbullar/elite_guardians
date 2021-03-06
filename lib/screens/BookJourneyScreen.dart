
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/EliteAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookJourneyScreen extends StatefulWidget
{
  @override
  _BookJourneyScreenState createState() => _BookJourneyScreenState();
}

class _BookJourneyScreenState extends State<BookJourneyScreen> {
  DateTime selectedDate;
  int bookNowOrLater=0;
  int guardSelection=0;
  bool guardCheckedOrNot=false;
  TimeOfDay timeFrom;
  @override
  Widget build(BuildContext context) {
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
                child: Text("From",style: TextStyle(color: AppColours.white,fontSize: 16),),
              ),
              TextField(
                enabled: false,
                style: TextStyle(color: Colors.white),
                decoration: CommonWidgets.loginFormDecoration("Enter Your Location",Icons.location_on_outlined),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("To",style: TextStyle(color: AppColours.white,fontSize: 16),),
              ),
              TextField(
                enabled: false,
                style: TextStyle(color: Colors.white),
                decoration: CommonWidgets.loginFormDecoration("Enter Your Location",Icons.location_on_outlined),
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
//                     tileColor: AppColours.textFeildBG,
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
//                    tileColor: AppColours.textFeildBG,
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
//               tileColor: AppColours.textFeildBG,
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
                      value: 0,
                      toggleable: true,
                      groupValue: guardSelection,
//                      tileColor: AppColours.textFeildBG,
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
                      value: 1,
                      toggleable: true,
                      groupValue: guardSelection,
//                      tileColor: AppColours.textFeildBG,
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
              CommonWidgets.goldenFullWidthButton("Get Quote",onClick: (){})
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
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }
}