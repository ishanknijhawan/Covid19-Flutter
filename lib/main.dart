import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sher_in_the_city/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const recovered = 'assets/images/heart.svg';
  static const confirmed = 'assets/images/virus.svg';
  static const active = 'assets/images/patient.svg';
  static const fever = 'assets/images/fever.svg';
  static const thermometer = 'assets/images/thermometer.svg';
  static const death = 'assets/images/grave.svg';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff0F528A),
        accentColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Ubuntu',
      ),
      debugShowCheckedModeBanner: false,
      home: TabsScreen(),
    );
  }
}
