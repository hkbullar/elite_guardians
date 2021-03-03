
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/EliteAppBar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatefulWidget
{
  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EliteAppBar("Job Details"),
      backgroundColor: AppColours.black,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonWidgets.requestTextContainer("From","Poplar St, Tyldesley, Manchester M29 8AX, United Kingdom",Icons.location_on_outlined),
              CommonWidgets.requestTextContainer("To","45 Elliott St, Tyldesley, Manchester M29 8AX, United Kingdom",Icons.location_on_outlined),
              CommonWidgets.requestTextContainer("Date","Sunday, 21st March",Icons.date_range_outlined),
              CommonWidgets.requestTextContainer("Time","4:15 PM",Icons.time_to_leave_outlined),
              CommonWidgets.requestTextContainer("Comments","Be on Time Please",Icons.comment_bank_outlined),
              CommonWidgets.requestTextContainer("Price","475",Icons.attach_money),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly,
                children: [
                  RaisedButton(
                    elevation: 5.0,
                    onPressed: () {

                    }, color: AppColours.white,
                    child: CommonWidgets.selectedFontWidget(
                        "Reject",
                        AppColours.golden_button_bg, 14.0,
                        FontWeight.w500),),
                  RaisedButton(
                    elevation: 5.0,
                    onPressed: () {

                    }, color: AppColours.golden_button_bg,
                    child: CommonWidgets.selectedFontWidget(
                        "Accept",
                        AppColours.white, 14.0,
                        FontWeight.w500),)
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}