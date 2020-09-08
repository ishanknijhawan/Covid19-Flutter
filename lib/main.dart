import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static const recovered = 'assets/images/heart.svg';
  static const confirmed = 'assets/images/virus.svg';
  static const active = 'assets/images/patient.svg';
  static const fever = 'assets/images/fever.svg';
  static const thermometer = 'assets/images/thermometer.svg';
  static const death = 'assets/images/grave.svg';
  static const sun = 'assets/images/sun.svg';

  static const moon = 'assets/images/moon.svg';
  static var isDarkTheme = false;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void changeTheme() {
    setState(() {
      MyApp.isDarkTheme = !MyApp.isDarkTheme;
      setPrefs();
    });
  }

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyApp.isDarkTheme
          //dark theme
          ? ThemeData(
              primaryColor: Color(0xff6eb5ef),
              accentColor: Colors.black,
              buttonColor: Colors.white,
              scaffoldBackgroundColor: Color(0xff222222),
              backgroundColor: Color(0xff222222),
              fontFamily: 'Ubuntu',
            )
          //no dark theme
          : ThemeData(
              primaryColor: Color(0xff0F528A),
              accentColor: Colors.white,
              buttonColor: Colors.black,
              scaffoldBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              fontFamily: 'Ubuntu',
            ),
      debugShowCheckedModeBanner: false,
      home: TabsScreen(changeTheme),
    );
  }

  void setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', MyApp.isDarkTheme);
  }

  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isDark') != null) {
      setState(() {
        MyApp.isDarkTheme = prefs.getBool('isDark');
      });
    }
  }
}
