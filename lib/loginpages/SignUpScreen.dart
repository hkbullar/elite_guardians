import 'dart:async';

import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/global/Size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _useremailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _conPasswordFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  var checkBoxValue=false;
  int maleBoxVal=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text("SignUp",style: TextStyle(color: AppColours.white),),
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: Size.width(25),right: Size.width(25)),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Constants.LOCAL_IMAGE+"logo.png",height: MediaQuery.of(context).size.height/7,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/15),
                  TextFormField(
                    validator: (value) => value.isEmpty ? 'Name cannot be blank': null,
                    textInputAction: TextInputAction.next,
                    controller: _nameController,
                    style: TextStyle(color: Colors.white),
                    focusNode: _usernameFocus,
                    onFieldSubmitted: (term)
                    {
                      _fieldFocusChange(context, _usernameFocus, _useremailFocus);
                    },
                    decoration: CommonWidgets.loginFormDecoration("Name",Icons.person_outline),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) => value.isEmpty ? 'Email cannot be blank': null,
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    style: TextStyle(color: Colors.white),
                    focusNode: _useremailFocus,
                    onFieldSubmitted: (term)
                    {
                      _fieldFocusChange(context, _useremailFocus, _passwordFocus);
                    },
                    decoration: CommonWidgets.loginFormDecoration("Email",Icons.mail_outline),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      maleFemaleButton(0, "MALE", "man_black.png"),
                      maleFemaleButton(1, "FEMALE", "woman_black.png"),
                      maleFemaleButton(2, "I'M ME", "intersex_black.png")
                    ],
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
                      _fieldFocusChange(context, _passwordFocus, _conPasswordFocus);
                    },
                    decoration: CommonWidgets.loginFormDecoration("Password",Icons.lock_outline),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    validator: (value) => value.isEmpty ? 'Password cannot be blank': null,
                    textInputAction: TextInputAction.next,
                    controller: _confirmPasswordController,
                    style: TextStyle(color: Colors.white),
                    focusNode: _conPasswordFocus,
                    onFieldSubmitted: (term)
                    {
                      _fieldFocusChange(context, _passwordFocus, _conPasswordFocus);
                    },
                    decoration: CommonWidgets.loginFormDecoration("Confirm Password",Icons.lock_outline),
                  ),
                  SizedBox(height: 20,),

                  SizedBox(height: MediaQuery.of(context).size.width/99),
                  CommonWidgets.goldenFullWidthButton("SIGNUP",onClick: ()=>_signUpClick()),
                  SizedBox(height: MediaQuery.of(context).size.height/15),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? ',style: TextStyle(color: AppColours.off_white,fontSize: 16)),
                          Text('SignIn Here',style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget maleFemaleButton(int defButtonValue,String text,String image){
    return Expanded(
      child: InkWell(
        onTap: (){
          setState(() {
            maleBoxVal=defButtonValue;
          });
        },
        child: Card(
          color: maleBoxVal==defButtonValue?AppColours.golden_button_bg:AppColours.textFeildBG,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Image.asset(Constants.LOCAL_IMAGE+image,height: 30,color: maleBoxVal==defButtonValue?AppColours.black:AppColours.white,),
                SizedBox(height: 10),
                Text(text,style: TextStyle(color: maleBoxVal==defButtonValue?AppColours.black:AppColours.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
  _signUpClick(){
    if(CommonWidgets.isValidate(_formKey)){
    Map jsonPost = {
      Constants.FIRST_NAME: _nameController.text,
      Constants.EMAIL: _emailController.text,
      Constants.PASSWORD: _passwordController.text,
      Constants.PASSWORD_CONFIRMATION: _confirmPasswordController.text
    };
    print(jsonPost);
    // ServiceHttp().registerUser(jsonPost,context);
  }}
  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}