
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/screens/JobDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobsScreen extends StatefulWidget
{
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {

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
      child: Container(
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
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
                                  child: CommonWidgets.selectedFontWidget(
                                      "02-03-2021" + " at " +
                                          "12:25 PM", AppColours.black, 15.0,
                                      FontWeight.bold),
                                ),
                                CommonWidgets.selectedFontWidget(
                                    "220" + " Punds", AppColours.white,
                                    15.0,
                                    FontWeight.bold),
                              ],
                            ),

                            SizedBox(height: 10.0),
                            CommonWidgets.selectedFontWidget("From:",
                                AppColours.black, 15.0, FontWeight.bold),
                            CommonWidgets.selectedFontWidget("127, 129 Kilburn High Rd, North Maida Vale, London NW6 6JJ, UK",
                                AppColours.black, 13.0, FontWeight.w500),
                            SizedBox(height: 10.0),
                            CommonWidgets.selectedFontWidget("To:",
                                AppColours.black, 15.0, FontWeight.bold),
                            CommonWidgets.selectedFontWidget("280 Harrow Rd, London W2 5ES, UK",
                                AppColours.black, 13.0, FontWeight.w500),
                            SizedBox(height: 10.0),
                            Row(mainAxisAlignment: MainAxisAlignment
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
                            ),
                          ],
                        ),
                      )),
                );
              })
      ),
    );
  }
}