
import 'package:elite_guardians/global/API.dart';
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/global/Global.dart';
import 'package:elite_guardians/global/Size.dart';
import 'package:elite_guardians/pojo/Booking.dart';
import 'package:elite_guardians/screens/JobDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobsScreen extends StatefulWidget
{
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  List<Booking> bookings=[];
  bool _loading=false;
  bool _isOpen = false;
String errorText;
  @override
  void initState() {
    getJobsList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size().init(context);
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
                return bookings[index].location!=null?guardianJobListItem(bookings[index]):journeyListItem(bookings[index]);
              })
      ),
    );
  }
 Widget journeyListItem(Booking booking){
    return InkWell(
      onTap: (){
        requestListItemClick(booking);
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
                CommonWidgets.selectedFontWidget("Purpose: Journey Booking",AppColours.black, 15.0, FontWeight.bold),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: CommonWidgets.selectedFontWidget("${Global.generateDate(booking.date)} at ${Global.formatTime(booking.time)}", AppColours.black, 15.0,FontWeight.bold),
                    ),
                    booking.price!=null?CommonWidgets.selectedFontWidget(booking.price!=0?"${booking.price} Pounds":"", AppColours.white,15.0,FontWeight.bold):SizedBox(),
                  ],
                ),

                SizedBox(height: 10.0),
                CommonWidgets.selectedFontWidget("From:",AppColours.black, 15.0, FontWeight.bold),
                CommonWidgets.selectedFontWidget(booking.destinationLocation!=null?booking.destinationLocation:"",AppColours.black, 13.0, FontWeight.w500),
                SizedBox(height: 10.0),
                CommonWidgets.selectedFontWidget("To:",AppColours.black, 15.0, FontWeight.bold),
                CommonWidgets.selectedFontWidget(booking.arrivalLocation!=null?booking.arrivalLocation:"",AppColours.black, 13.0, FontWeight.w500),
                SizedBox(height: 10.0),
                booking.price!=null && booking.price!=0 && booking.status==0?Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      elevation: 5.0,
                      onPressed: () {rejectDialogue(context,false,booking);}, color: Colors.red,
                      child: CommonWidgets.selectedFontWidget(
                          "Reject",
                          AppColours.white, 14.0,
                          FontWeight.w500),),
                    RaisedButton(
                      elevation: 5.0,
                      onPressed: () {acceptRejectClick(booking.id,false, false);}, color: Colors.green,
                      child: CommonWidgets.selectedFontWidget(
                          "Accept",
                          AppColours.white, 14.0,
                          FontWeight.w500),)
                  ],
                ):booking.status==0?Row(
                  children: [Expanded(child: CommonWidgets.selectedFontWidget(
                      "Awaiting Quote",
                      AppColours.black, 18.0,
                      FontWeight.bold),)],):SizedBox(),
              ],
            ),
          )),
    );
  }
  Widget guardianJobListItem(Booking booking){
    return InkWell(
      onTap: (){
        requestListItemClick(booking);
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CommonWidgets.selectedFontWidget(booking.userType!=null?"Purpose: To Hire ${booking.userType}":"Purpose: To Hire Guardian",
                              AppColours.black, 15.0, FontWeight.bold),
                        ),
                        booking.price!=null&& booking.price!=0?CommonWidgets.selectedFontWidget(booking.price!=0?"${booking.price} Pounds":"", AppColours.white,
                            15.0,
                            FontWeight.bold):SizedBox(),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    CommonWidgets.selectedFontWidget("${generateGuardianDate(booking)}", AppColours.black, 15.0,
                        FontWeight.bold),
                    SizedBox(height: 5.0),
                    CommonWidgets.selectedFontWidget(generateGuardianTime(booking),
                        AppColours.black, 15.0, FontWeight.bold),
                    SizedBox(height: 10.0),
                    CommonWidgets.selectedFontWidget("Location:",
                        AppColours.black, 15.0, FontWeight.bold),
                    CommonWidgets.selectedFontWidget(booking.location!=null?booking.location:"",
                        AppColours.black, 13.0, FontWeight.w500),
                    SizedBox(height: 10.0),
                    booking.price!=null && booking.price!=0 && booking.status==0?Row(mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly,
                      children: [
                        RaisedButton(
                          elevation: 5.0,
                          onPressed: () {rejectDialogue(context,true,booking);}, color: Colors.red,
                          child: CommonWidgets.selectedFontWidget(
                              "Reject",
                              AppColours.white, 14.0,
                              FontWeight.w500),),
                        RaisedButton(
                          elevation: 5.0,
                          onPressed: () {acceptRejectClick(booking.id,true, false);}, color: Colors.green,
                          child: CommonWidgets.selectedFontWidget(
                              "Accept",
                              AppColours.white, 14.0,
                              FontWeight.w500),)
                      ],
                    ):booking.status==0?Row(
                      children: [Expanded(child: CommonWidgets.selectedFontWidget(
                          "Awaiting Quote",
                          AppColours.black, 18.0,
                          FontWeight.bold),)],):SizedBox(),
                  ],
                ),
              ],
            ),
          )),
    );
  }
  requestListItemClick(Booking booking) async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => JobDetailsScreen(booking)));
  if(result!=null){
   if(result==true){
     _loading=true;
     getJobsList();
   }
  }
  }
 String generateGuardianDate(Booking booking){
    String date;
    if(booking.fromDate==booking.toDate){
      date="For: ${Global.generateDate(booking.fromDate)}";

    }else{
      date="From: ${Global.generateDate(booking.fromDate)}\nTo:       ${Global.generateDate(booking.toDate)}";
    }
    return date;
  }
  String generateGuardianTime(Booking booking){
    String time;
    time="Timing: ${Global.formatTime(booking.fromTime)} To ${Global.formatTime(booking.toTime)}";
    return time;
  }

  acceptRejectClick(int id,bool isGuardian,bool ifRejected,{String comment}){
    String type="customer";
    if(isGuardian)
      type="guardian";
    if(ifRejected){
      Map jsonPost = {
        Constants.REQUEST_AR_COMMENT: comment,
        Constants.REQUEST_AR_ID: "$id",
        Constants.REQUEST_AR_TYPE: type,
        Constants.REQUEST_AR_ACCEPT_OR_REJECT: 1,
      };
      API(context).acceptReject(jsonPost,onResponse: (value){
        getJobsList();
      },rejected: true);
    }
    else{
      Map jsonPost = {
        Constants.REQUEST_AR_ID: "$id",
        Constants.REQUEST_AR_TYPE: type,
        Constants.REQUEST_AR_ACCEPT_OR_REJECT: 2,
      };
      API(context).acceptReject(jsonPost,onResponse: (value){
        getJobsList();
      });
    }
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
     if(_isOpen){Navigator.of(context).pop();}
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

  rejectDialogue(BuildContext context,bool isGuardian,Booking booking) {
    _isOpen=true;
    Dialog rejectPopup = Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 0.0,
        backgroundColor: Colors.black,
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Container(
                child: rejectDialogueUI(setState,isGuardian,booking),
              );
            }
        ));

   showDialog(
      context: context,
      routeSettings: RouteSettings(name: "reject"),
      builder: (BuildContext context) {
        return rejectPopup;
      },
    ).then((value) =>_isOpen = false);
  }
  Widget rejectDialogueUI(StateSetter setState,bool isGuardian,Booking booking){
    var _commentController = TextEditingController();
    return   Container(
      decoration: BoxDecoration(
          color: AppColours.golden_button_bg,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      padding: EdgeInsets.all(Size.size(15)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: Text("Please add your comments:",style: TextStyle(color: AppColours.black,fontWeight: FontWeight.bold,fontSize: Size.size(18)),)),
              InkWell(
                onTap: (){Navigator.of(context).pop();},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.close, color: Colors.black),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: [
              TextField(
                textInputAction: TextInputAction.go,
                style: TextStyle(color: Colors.white),
                controller: _commentController,
                decoration: CommonWidgets.loginFormDecoration("Optional",Icons.comment_bank_outlined),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: ()
                      {
                        Navigator.of(context).pop();
                        acceptRejectClick(booking.id, isGuardian,true,comment: _commentController.text);

                        }, color: Colors.red,
                      child: CommonWidgets.selectedFontWidget(
                          "Reject",
                          AppColours.white, 14.0,
                          FontWeight.w500),),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}