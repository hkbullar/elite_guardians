
import 'package:elite_guardians/dashboard/HomeScreen.dart';
import 'package:elite_guardians/dashboard/JobsScreen.dart';
import 'package:elite_guardians/dashboard/ProfileScreen.dart';
import 'package:elite_guardians/dashboard/SettingsScreen.dart';
import 'package:elite_guardians/global/AppColours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget
{

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  int _selectedIndex = 0;
  static const List<String> titleList=<String>["Home","Jobs","Profile","Settings"];
   List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),JobsScreen(),ProfileScreen(),SettingsScreen(),
  ];
    String title="Home";
  void _onItemTapped(int index) {
    setState(() {
      title=titleList[index];
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.black,
      appBar: AppBar(
        backgroundColor: AppColours.black,
          title: Text(title,style: TextStyle(color: AppColours.white),)),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
              label: "Jobs",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
                label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColours.golden_button_bg,
          unselectedItemColor: AppColours.off_white,
          iconSize: 35,
          backgroundColor: AppColours.black,
          selectedFontSize: 16,
          unselectedFontSize: 12,
          onTap: _onItemTapped,
      ),
    );
  }
}