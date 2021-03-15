
import 'package:elite_guardians/global/AppColours.dart';
import 'package:elite_guardians/loginpages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ELITE',
      theme: ThemeData(
        unselectedWidgetColor: AppColours.golden_button_bg,
        primarySwatch: Colors.grey,
      ),
      //home: JobsScreen(),
     home: SplashScreen(),
    );
  }
}

