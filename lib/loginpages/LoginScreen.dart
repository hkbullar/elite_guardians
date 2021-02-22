import 'dart:async';

import 'package:elite_guardians/dashboard/DashBoardScreen.dart';
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/loginpages/SignUpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  var checkBoxValue=false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Constants.LOCAL_IMAGE+"logo.png",height: MediaQuery.of(context).size.height/6,
              ),
              SizedBox(height: MediaQuery.of(context).size.height/15),
              TextFormField(
                validator: (value) => value.isEmpty ? 'Email cannot be blank': null,
                textInputAction: TextInputAction.next,
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                focusNode: _usernameFocus,
                onFieldSubmitted: (term)
                {
                  _fieldFocusChange(context, _usernameFocus, _passwordFocus);
                },
                decoration: CommonWidgets.loginFormDecoration("Email",Icons.mail_outline),
              ),
              SizedBox(height: 20),
              TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                validator: (value) => value.isEmpty ? 'Password cannot be blank': null,
                textInputAction: TextInputAction.next,
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                focusNode: _passwordFocus,
                onFieldSubmitted: (term)
                {
                  _fieldFocusChange(context, _usernameFocus, _passwordFocus);
                },
                decoration: CommonWidgets.loginFormDecoration("Password",Icons.lock_outline),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color: AppColours.golden_button_bg,),
                            SizedBox(width: 5,),
                            Text('Remember me',style: TextStyle(color: AppColours.off_white,fontSize: 14),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text("Forgot Password ?",textAlign: TextAlign.end,style: TextStyle(color: AppColours.off_white,fontSize: 14),),
                  )),
                ],
              ),
              SizedBox(height: 25,),
              SizedBox(height: MediaQuery.of(context).size.width/99),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            ),
                      color: AppColours.golden_button_bg,
                        child: Text("LOGIN",style: TextStyle(color: AppColours.black,fontWeight: FontWeight.bold,fontSize: 18),),
                        onPressed: (){
                      _loginClick();
                    }),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/15),
              InkWell(
                onTap: (){
                  navigationToSignUp();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account? ',style: TextStyle(color: AppColours.off_white,fontSize: 16)),
                      Text('Signup Here',style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigationToSignUp()
  {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignUpScreen()));
  }

  _loginClick()
  {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()));
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus)
  {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}