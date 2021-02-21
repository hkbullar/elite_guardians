
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
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
      body: Center(child: Text("Screen yet Pending",style: TextStyle(color: AppColours.white,fontSize: 25),),)
    );
  }
}