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
import 'package:intl/intl.dart';

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

  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
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
      home: Scaffold(
        body: SingleChildScrollView(
          //controller: controller,
          child: Column(
            children: <Widget>[
              MyHeader(
                image: 'assets/icons/Drcorona.svg',
                textTop: "Cuide da sua saúde",
                textBottom: "e vacine-se!",
                offset: offset,
              ),
              FutureBuilder<StatsW>(
                future: requestWorld(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    StatsW data = snapshot.data!;
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          height: 70,
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Brazil.svg/1920px-Flag_of_Brazil.svg.png'),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Text('Brasil',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Casos Atualizados\n",
                                          style: kTitleTextstyle,
                                        ),
                                        TextSpan(
                                          text: "Atualizado em Hoje",
                                          style: TextStyle(
                                            color: kTextLightColor,
                                          ),
                                        ),
                                      ],
                                    ),
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
                              InfoCard(
                                  color: kInfectedColor,
                                  number: data.cases!,
                                  title: "Infectados"),
                              SizedBox(height: 15),
                              InfoCard(
                                  color: kRecovercolor,
                                  number: data.recovered!,
                                  title: "Curados"),
                              SizedBox(height: 15),
                              InfoCard(
                                  color: kDeathColor,
                                  number: data.deaths!,
                                  title: "Mortes"),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatefulWidget {
  const InfoCard({
    Key? key,
    required this.color,
    required this.number,
    required this.title,
  }) : super(key: key);

  final Color color;
  final int number;
  final String title;

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool noPrecision = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => noPrecision = !noPrecision),
      child: Container(
        width: double.infinity,
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
            BoxShadow(
              color: widget.color,
              offset: Offset(4, 6),
            ),
          ],
        ),
        child: Counter(
          color: widget.color,
          number: noPrecision
              ? NumberFormat.compactLong(locale: 'pt').format(widget.number)
              : widget.number.toString(),
          title: widget.title,
        ),
      ),
    );
  }
}

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
