
import 'dart:io';

import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/Size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget
{

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var _subjectController = TextEditingController();
  var _messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String platformResponse;
  @override
  Widget build(BuildContext context) {
    Size().init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) => value.isEmpty ? 'Subject cannot be blank': null,
                  textInputAction: TextInputAction.next,
                  controller: _subjectController,
                  style: TextStyle(color: Colors.white),
                  decoration: CommonWidgets.loginFormDecoration("Enter Subject",Icons.subject),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) => value.isEmpty ? 'Message cannot be blank': null,
                  textInputAction: TextInputAction.next,
                  controller: _messageController,
                  minLines: 3,
                  maxLines: 6,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: AppColours.textFeildBG,

                    hintStyle: TextStyle( color: AppColours.off_white,fontSize: Size.size(16)),
                    hintText: "Enter your message",
                  ),
                ),
                SizedBox(height: 20,),
                CommonWidgets.goldenFullWidthButton("Submit",onClick: () async {
                  if(CommonWidgets.isValidate(_formKey)) {
                    final Uri params = Uri(
                      scheme: 'mailto',
                      path: 'admin@eliteguardian.co.uk',
                      query: 'subject=${_subjectController.text}&body=${_messageController.text}', //add subject and body here
                    );

                    var url = params.toString();
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
                })
              ],
             ),
          ),
        ),
      )
    );
  }
}