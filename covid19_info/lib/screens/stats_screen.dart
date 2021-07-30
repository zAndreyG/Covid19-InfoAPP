import 'package:covid19_info/models/stats.dart';
import 'package:covid19_info/screens/stats_country.dart';
import 'package:covid19_info/style/constant.dart';
import 'package:covid19_info/util/requests.dart';
import 'package:covid19_info/widgets/counter.dart';
import 'package:covid19_info/widgets/my_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
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
                        InkWell(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return StatsCountryScreen();
                          })),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
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
                                Expanded(
                                  child: Text('Pesquise por país',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                ),
                                Icon(
                                  Icons.arrow_right_alt_rounded,
                                  size: 45,
                                )
                              ],
                            ),
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
                                          text: "Situação Mundial\n",
                                          style: kTitleTextstyle,
                                        ),
                                        TextSpan(
                                          text:
                                              "Atualizado às ${updatedAt()}hs",
                                          style: TextStyle(
                                            color: kTextLightColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () async {
                                      List<StatsC> countryList =
                                          await requestCountries();
                                      countryList.forEach(
                                          (country) => print(country.country));
                                    },
                                    child: Text(
                                      "Detalhes",
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InfoCard(
                                        color: kInfectedColor,
                                        number: data.cases!,
                                        title: "Infectados"),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: InfoCard(
                                        color: kInfectedColor,
                                        number: data.todayCases!,
                                        title: "HOJE"),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InfoCard(
                                        color: kRecovercolor,
                                        number: data.recovered!,
                                        title: "Curados"),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: InfoCard(
                                        color: kRecovercolor,
                                        number: data.todayRecovered!,
                                        title: "HOJE"),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InfoCard(
                                        color: kDeathColor,
                                        number: data.deaths!,
                                        title: "Mortes"),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: InfoCard(
                                        color: kDeathColor,
                                        number: data.todayDeaths!,
                                        title: "HOJE"),
                                  ),
                                ],
                              ),
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

  String updatedAt() {
    DateTime now = DateTime.now();
    String formatDate = DateFormat('HH:mm').format(now);
    return formatDate;
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
