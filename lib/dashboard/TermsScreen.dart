
import 'dart:io';

import 'package:elite_guardians/global/AppColours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsScreen extends StatefulWidget
{

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(child: Text("Support will be visible very soon",style: TextStyle(fontSize: 20,color: AppColours.white),),),
    );
  }
}