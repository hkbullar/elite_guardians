
import 'package:elite_guardians/global/PLoader.dart';
import 'package:elite_guardians/global/StripeTransactionResponse.dart';
import 'package:elite_guardians/global/API.dart';
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/global/EliteAppBar.dart';
import 'package:elite_guardians/global/Global.dart';
import 'package:elite_guardians/global/Size.dart';
import 'package:elite_guardians/pojo/Booking.dart';
import 'package:elite_guardians/screens/TrackDriverGuardian.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatefulWidget
{
  Booking booking;
  JobDetailsScreen(this.booking);
  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState(booking);
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
_JobDetailsScreenState(this.booking);
  Booking booking;
  bool _isOpen=false;
  bool isJourney=true;
  bool listRefresh=false;

  @override
  void initState() {
    booking.location!=null?isJourney=false:isJourney=true;
    StripeService.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size().init(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: EliteAppBar("Job Details"),
        backgroundColor: AppColours.black,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonWidgets.requestTextContainer(isJourney?"From":"For",isJourney?"${booking.destinationLocation}":"${booking.location}",Icons.location_on_outlined),
                isJourney?CommonWidgets.requestTextContainer("To","${booking.arrivalLocation}",Icons.location_on_outlined):SizedBox(),
                CommonWidgets.requestTextContainer("Date",isJourney?"${Global.generateDate(booking.date)}":"${generateGuardianDate(booking)}",Icons.date_range_outlined),
                CommonWidgets.requestTextContainer(isJourney?"Time":"Timing",isJourney?"${Global.formatTime(booking.time)}":"From: ${booking.fromTime}\nTo: ${booking.toTime}",Icons.watch_outlined),
                isJourney && booking.securityGuard!=0?CommonWidgets.requestTextContainer("Guardians Required",booking.securityGuard==1?"One":booking.securityGuard==2?"Two":"",Icons.security_outlined):SizedBox(),
                booking.comment!=null && booking.comment.isNotEmpty?CommonWidgets.requestTextContainer("Comments",booking.comment,Icons.comment_bank_outlined):SizedBox(),
                booking.price!=null && booking.price!=0 && booking.status==0?CommonWidgets.requestTextContainer("Price","${booking.price}",Icons.attach_money):
                CommonWidgets.requestTextContainer("Status",booking.status==0?"Awaiting Confirmation":"Accepted",booking.status==0?Icons.timelapse_outlined:Icons.check_circle_outline),
                SizedBox(height: 10),

                booking.price!=null && booking.price!=0 && booking.status==0?Row(mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly,
                  children: [
                    RaisedButton(
                      elevation: 5.0,
                      onPressed: ()
                      {
                        rejectDialogue(context, booking);
                      }, color: Colors.red,
                      child: CommonWidgets.selectedFontWidget("Reject",AppColours.white, 14.0,FontWeight.w500)),
                    RaisedButton(
                      elevation: 5.0,
                      onPressed: ()
                      {
                        if(isJourney){
                          if(booking.bookNowOrLater==1){
                            payViaNewCard(context,"${booking.price*100}",booking.id);
                          }
                          else{
                            acceptRejectClick(booking.id, false);
                          }
                        }
                        else{
                          acceptRejectClick(booking.id, false);
                        }

                      }, color: Colors.green,
                      child: CommonWidgets.selectedFontWidget(booking.bookNowOrLater==1?"Accept &\ Pay":"Accept",AppColours.white, 14.0,FontWeight.w500))
                  ],
                ): SizedBox(),
                trackingButton(),
              ],
            ),
          ),
        )
      ),
    );
  }
Widget trackingButton(){
    if(isJourney){
      if(booking.drivers!=null && booking.drivers.isNotEmpty){
       return CommonWidgets.goldenFullWidthButton(generateText(driver: booking.drivers[0]),onClick: ()
        {

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TrackDriverGuardianScreen(booking)));

        });
      }
      else{
        return   CommonWidgets.selectedFontWidget("No Drivers assigned Yet",AppColours.white, 14.0,FontWeight.w500);
      }

    }
    else{
      if(booking.guardians!=null && booking.guardians.isNotEmpty){
        return   CommonWidgets.goldenFullWidthButton(generateText(guardian: booking.guardians[0]),onClick: ()
        {

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TrackDriverGuardianScreen(booking)));

        });
      }
      else{
        return  CommonWidgets.selectedFontWidget("No Guardian Assigned Yet",AppColours.white, 14.0,FontWeight.w500);
      }

    }
}
String generateGuardianDate(Booking booking){

  String date;

  if(booking.fromDate.day==booking.toDate.day){
    date="For: ${Global.generateDate(booking.fromDate)}";

  }else{
    date="From: ${Global.generateDate(booking.fromDate)}\nTo:       ${Global.generateDate(booking.toDate)}";
  }
  return date;
}
 String generateText({Driver driver,Guardian guardian}){
    if(isJourney){
      if(driver.startJob==0){
        return "Journey Not Started Yet";
      }
      else if(driver.startJob==1){
        return "Track Driver";
      }
      else{
        return "Job Completed";
      }
    }
    else{
      if(guardian.startJob==0){
        return "Job not started yet";
      }
      else if(guardian.startJob==1){
        return "Track Guardian";
      }
      else{
        return "Job Completed";
      }
    }
  }


rejectDialogue(BuildContext context,Booking booking) {
  _isOpen=true;
  Dialog rejectPopup = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.black,
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return Container(
              child: rejectDialogueUI(setState,booking),
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

Widget rejectDialogueUI(StateSetter setState,Booking booking){
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
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                      acceptRejectClick(booking.id, true,comment: _commentController.text);

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

acceptRejectClick(int id,bool ifRejected,{String comment}){
  if(ifRejected){
    Map jsonPost =
    {
      Constants.REQUEST_AR_COMMENT: comment,
      Constants.REQUEST_AR_ID: "$id",
      Constants.REQUEST_AR_TYPE: isJourney?"customer":"guardian",
      Constants.REQUEST_AR_ACCEPT_OR_REJECT: 1,
    };
    API(context).acceptReject(jsonPost,onResponse: (value){
      listRefresh=true;

      Navigator.pop(context, listRefresh);
    },rejected: true);
  }
  else{
    Map jsonPost = {
      Constants.REQUEST_AR_ID: "$id",
      Constants.REQUEST_AR_TYPE: isJourney?"customer":"guardian",
      Constants.REQUEST_AR_ACCEPT_OR_REJECT: 2,
    };
    API(context).acceptReject(jsonPost,onResponse: (value){
      if(value!=null){
        listRefresh=true;
        if(isJourney){
          if(!ifRejected){
            Map jsonPost1 = {
              "booking_id": "$id",
              "status": 1,
            };
            API(context).paymentDone(jsonPost1);
          }
        }
        setState(() {
          booking=value;
        });
      }
    });
  }
}

Future<bool> _onWillPop() async {
  Navigator.pop(context, listRefresh);
  return  false;
}

payViaNewCard(BuildContext context,String amount,int id) async {
  PLoader loader=PLoader(context);
  loader.show();
  var response = await StripeService.payWithNewCard(amount: amount, currency: 'INR');//GB for UK  and INR for India
  loader.hide();
  if(response.success){
    Global().toast(context,"Amount $amount received Successfully");
    acceptRejectClick(id, false);
  }
  print(response.message);
  Global().toast(context, response.message);
}
}