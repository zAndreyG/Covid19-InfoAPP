import 'package:covid19_info/screens/info_screen.dart';
import 'package:covid19_info/screens/stats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(Covid19InfoApp());
}

class Covid19InfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/'    : (context) => StatsScreen(),
        '/info': (context) => InfoScreen()
      },
    );
  }
}