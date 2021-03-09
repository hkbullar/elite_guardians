import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/loginpages/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Global{
  static Future<SharedPreferences> getSharedPref() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return _prefs;
  }

  static void toast(BuildContext context,String message) {
    Toast.show(message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
  }

  static Future<bool> isRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.ISREGISTERED) ?? false;
  }
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.TOKEN) ?? '';
  }

  static Future<String> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.LANGUAGE_CODE) ?? 'en';
  }
 static String getDayOfMonthSuffix(int dayNum) {
    if(!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if(dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch(dayNum % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }
  static setLang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(Constants.LANGUAGE_CODE,lang) ?? '';
  }

  static Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.EMAIL) ?? '';

  }

  static fomattedTime(String time){
    int timeInMillis = int.parse(time);
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    return  DateFormat.yMd().add_jm().format(date);
  }

  static fomattedDate(String time){
    int timeInMillis = int.parse(time);
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    return  DateFormat.yMd().format(date).toString(); // Apr 8, 2020
  }
  //logout app
  //remove shared prefrences
  static removePreferences(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove(Constants.ISREGISTERED);
    //Remove bool
    prefs.remove(Constants.TOKEN);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) => LoginScreen()), ModalRoute.withName("/Login"));
  }
  static getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.USER_PREF) ?? '';
  }
  //hide keyboard
  static  hideKeyBoard(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }
}