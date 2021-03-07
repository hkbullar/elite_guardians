import 'dart:convert';

import 'package:elite_guardians/dashboard/DashBoardScreen.dart';
import 'package:elite_guardians/global/Constants.dart';
import 'package:elite_guardians/global/Global.dart';
import 'package:elite_guardians/global/PLoader.dart';
import 'package:elite_guardians/global/ServiceHttp.dart';
import 'package:elite_guardians/pojo/LoginPojo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API{
  BuildContext context;
  API(this.context);
  login(Map jsonPost){
  PLoader loader=PLoader(context);
  loader.show();
    ServiceHttp().httpRequestPost("login",map: jsonPost,
        onSuccess: (value) async {
          LoginPojo loginPojo= LoginPojo.fromJson(json.decode(value));
          SharedPreferences preferences =await Global.getSharedPref();
          preferences.setString(Constants.TOKEN, loginPojo.token);
          preferences.setBool(Constants.ISREGISTERED, true);
          preferences.setString(Constants.USER_PREF,json.encode(loginPojo.user.toJson()));
          loader.hide();
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()));
        }, onError: (value) {
          Map<String, dynamic> map = json.decode(value);
          Global.toast(context,map["error"]);
          loader.hide();
        });
  }
  register(Map jsonPost){
    PLoader loader=PLoader(context);
    loader.show();
    ServiceHttp().httpRequestPost("register",map: jsonPost,
        onSuccess: (value) async {
          LoginPojo loginPojo= LoginPojo.fromJson(json.decode(value));
          SharedPreferences preferences =await Global.getSharedPref();
          preferences.setString(Constants.TOKEN, loginPojo.token);
          preferences.setBool(Constants.ISREGISTERED, true);
          preferences.setString(Constants.USER_PREF,json.encode(loginPojo.user.toJson()));
          loader.hide();
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()));
        }, onError: (value) {
          Map<String, dynamic> map = json.decode(value);
          Global.toast(context,map["error"]);
          loader.hide();
        });
  }
}