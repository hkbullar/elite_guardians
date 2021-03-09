
import 'package:elite_guardians/global/API.dart';
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/Global.dart';
import 'package:elite_guardians/pojo/JobsListPojo.dart';
import 'package:elite_guardians/screens/JobDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobsScreen extends StatefulWidget
{
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  List<Booking> bookings=[];
  bool _loading=false;
String errorText;
  @override
  void initState() {
    getJobsList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _listOfData())
    );
  }
  _listOfData() {
    return SafeArea(
      child: _loading?Center(child: loader(context)):
      errorText!=null?Center(child: Text(errorText,style: TextStyle(fontSize: 22,color: AppColours.white),),):
      Container(
          child: ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return jobListItem(bookings[index]);
              })
      ),
    );
  }
 Widget jobListItem(Booking booking){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => JobDetailsScreen()));
      },
      child: Card(
          elevation: 5.0,
          color: AppColours.golden_button_bg,
          margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          child: Container(padding: EdgeInsets.fromLTRB(
              15.0, 10.0, 15.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CommonWidgets.selectedFontWidget("${generateDate(booking.date)} at ${formatTime(booking.time)}", AppColours.black, 15.0,
                          FontWeight.bold),
                    ),
                    CommonWidgets.selectedFontWidget(booking.price!=0?"${booking.price} Pounds":"", AppColours.white,
                        15.0,
                        FontWeight.bold),
                  ],
                ),

                SizedBox(height: 10.0),
                CommonWidgets.selectedFontWidget("From:",
                    AppColours.black, 15.0, FontWeight.bold),
                CommonWidgets.selectedFontWidget(booking.destinationLocation!=null?booking.destinationLocation:"",
                    AppColours.black, 13.0, FontWeight.w500),
                SizedBox(height: 10.0),
                CommonWidgets.selectedFontWidget("To:",
                    AppColours.black, 15.0, FontWeight.bold),
                CommonWidgets.selectedFontWidget(booking.arrivalLocation!=null?booking.arrivalLocation:"",
                    AppColours.black, 13.0, FontWeight.w500),
                SizedBox(height: 10.0),
                booking.price!=0?Row(mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly,
                  children: [
                    RaisedButton(
                      elevation: 5.0,
                      onPressed: () {}, color: Colors.red,
                      child: CommonWidgets.selectedFontWidget(
                          "Reject",
                          AppColours.white, 14.0,
                          FontWeight.w500),),
                    RaisedButton(
                      elevation: 5.0,
                      onPressed: () {}, color: Colors.green,
                      child: CommonWidgets.selectedFontWidget(
                          "Accept",
                          AppColours.white, 14.0,
                          FontWeight.w500),)
                  ],
                ):Row(
                  children: [Expanded(child: CommonWidgets.selectedFontWidget(
                      "Awaiting Quote",
                      AppColours.black, 18.0,
                      FontWeight.bold),)],),
              ],
            ),
          )),
    );
  }
  loader(BuildContext context){
    return  CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(AppColours.golden_button_bg),
    );
  }
 getJobsList(){
    errorText=null;
    _loading=true;
    API(context).jobsList(onSuccess: (value){setState(() {
      _loading=false;
      if(value.isNotEmpty){
        bookings=value;
      }
     else{
       errorText="No Bookings Found";
      }
    });},
    onError: (value){
      _loading=false;
    errorText=value;
    });
  }
  String formatTime(String time){

    return DateFormat.jm().format(DateFormat('HH:mm:ss').parse(time)).toString();
  }
 String generateDate(DateTime dt){
   var formatter = new DateFormat('MMM, EEEE');
    String date="${dt.day}${Global.getDayOfMonthSuffix(dt.day)} ${formatter.format(dt)}";
    return date;
  }
}