import 'package:covid19_info/screens/info_screen.dart';
import 'package:covid19_info/screens/stats_country.dart';
import 'package:covid19_info/screens/stats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'style/constant.dart';

void main() {
  runApp(Covid19InfoApp());
}

class Covid19InfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            bodyText1: TextStyle(color: kBodyTextColor),
          )),
      initialRoute: '/',
      routes: {
        '/': (context) => StatsScreen(),
        '/info': (context) => InfoScreen(),
        '/countries': (context) => StatsCountryScreen()
      },
    );
  }
}
