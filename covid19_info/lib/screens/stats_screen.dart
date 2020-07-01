import 'package:covid19_info/models/country.dart';
import 'package:covid19_info/models/stats.dart';
import 'package:covid19_info/style/constant.dart';
import 'package:covid19_info/util/requests.dart';
import 'package:covid19_info/widgets/counter.dart';
import 'package:covid19_info/widgets/my_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  static List<Country> countryList = [
    Country('Brasil', 'Brazil'),
    Country('Alemanha', 'Germany'),
    Country('Argentina', 'Argentina'),
    Country('China', 'China'),
    Country('Espanha', 'Spain'),
    Country('Estados Unidos', 'US'),
    Country('França', 'France'),
    Country('India', 'India'),
    Country('Indonésia', 'Indonesia'),
    Country('Irã', 'Iran'),
    Country('Itália', 'Italy'),
    Country('Japão', 'Japan'),
    Country('México', 'Mexico'),
    Country('Peru', 'Peru'),
    Country('Reino Unido', 'United Kingdom'),
    Country('Russia', 'Russia'),
    Country('Suíça', 'Switzerland'),
    Country('Turquia', 'Turkey')
  ];

  Country _dropdownvalue = countryList[0];

  Stats data;
  bool isSearching = false;

  final controller = ScrollController();
  double offset = 0;

  Future<Stats> future;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);

    future = myFuture();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  Future<Stats> myFuture() async {
    data = await byCountry(_dropdownvalue.nameEN);
    return data;
  }

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
        )
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: <Widget>[
              MyHeader(
                image: 'assets/icons/Drcorona.svg',
                textTop: "Tudo o que precisa",
                textBottom: "fazer é se prevenir.",
                offset: offset,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset('assets/icons/maps-and-flags.svg'),
                    SizedBox(width: 20),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: SvgPicture.asset('assets/icons/dropdown.svg'),
                        hint: Text(countryList[0].namePT),
                        value: _dropdownvalue,
                        onChanged: (value) =>  setState(() {
                          _dropdownvalue = value;
                          future = myFuture();
                          }),
                        items: countryList.map((country) => DropdownMenuItem<Country>(
                            value: country,
                            child: Text(country.namePT),
                          )).toList(),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        FutureBuilder<Stats> (
                          future: future,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting)
                              return RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Casos Atualizados\n",
                                      style: kTitleTextstyle,
                                    ),
                                    TextSpan(
                                      text: "Atualizado em ........",
                                      style: TextStyle(
                                        color: kTextLightColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            else
                            return RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Casos Atualizados\n",
                                      style: kTitleTextstyle,
                                    ),
                                    TextSpan(
                                      text: "Atualizado em ${data.updated}",
                                      style: TextStyle(
                                        color: kTextLightColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                          }
                        ),
                        Spacer(),
                        Text(
                          "Detalhes",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 24,
                            color: kActiveShadowColor,
                          ),
                        ],
                      ),
                      child: FutureBuilder<Stats>(
                        future: future,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting)
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 20),
                                const SpinKitRing(
                                  color: Colors.blue,
                                  size: 50.0
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          else
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Counter(
                                  color: kInfectedColor,
                                  number: data.confirmed,
                                  title: "Infectados",
                                ),
                                Counter(
                                  color: kDeathColor,
                                  number: data.deaths,
                                  title: "Mortes",
                                ),
                                Counter(
                                  color: kRecovercolor,
                                  number: data.recovered,
                                  title: "Curados",
                                ),
                              ],
                            );
                        }
                      )
                    ),
                    SizedBox(height: 30),
                    /* Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Avanço do Vírus",
                          style: kTitleTextstyle,
                        ),
                        Text(
                          "Detalhes",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(20),
                      height: 178,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/map.png",
                        fit: BoxFit.contain,
                      ),
                    ), */
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}