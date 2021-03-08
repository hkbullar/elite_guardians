
import 'package:elite_guardians/global/API.dart';
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/global/CommonWidgets.dart';
import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/global/Size.dart';
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
    Size().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(Size.size(25)),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Constants.LOCAL_IMAGE+"logo.png",height: Size.size(150),
                ),
                SizedBox(height: Size.size(20)),
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
                SizedBox(height: Size.size(20)),
                TextFormField(
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                  validator: (value) => value.isEmpty ? 'Password cannot be blank': null,
                  textInputAction: TextInputAction.next,
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white),
                  onFieldSubmitted: (value){FocusScope.of(context).unfocus();},
                  focusNode: _passwordFocus,
                  decoration: CommonWidgets.loginFormDecoration("Password",Icons.lock_outline),
                ),
                SizedBox(height: Size.size(5),),
                Row(
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text("Forgot Password ?",textAlign: TextAlign.end,style: TextStyle(color: AppColours.off_white,fontSize: Size.size(14)),),
                    )),
                  ],
                ),
                SizedBox(height: Size.size(25)),
                SizedBox(height: MediaQuery.of(context).size.width/99),
                CommonWidgets.goldenFullWidthButton("LOGIN",onClick: ()=> _loginClick(context)),
                SizedBox(height: Size.size(30)),
                InkWell(
                  onTap: (){
                    navigationToSignUp();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Text('Don\'t have an account? ',style: TextStyle(color: AppColours.off_white,fontSize: Size.size(16))),
                       Text('Signup Here',style: TextStyle(color: AppColours.golden_button_bg,fontSize: Size.size(18))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigationToSignUp()
  {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignUpScreen()));
  }

  _loginClick(BuildContext con)
  {
    if(CommonWidgets.isValidate(_formKey)) {
      Map jsonPost = {
        Constants.EMAIL: _emailController.text,
        Constants.PASSWORD: _passwordController.text,
      };
      FocusScope.of(context).unfocus();
      API(context).login(jsonPost);
    }
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus)
  {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}