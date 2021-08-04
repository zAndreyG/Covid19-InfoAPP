import 'package:covid19_info/models/stats.dart';
import 'package:covid19_info/style/constant.dart';
import 'package:covid19_info/util/requests.dart';
import 'package:covid19_info/widgets/counter.dart';
import 'package:covid19_info/widgets/countriesButton.dart';
import 'package:covid19_info/widgets/infoCards.dart';
import 'package:covid19_info/widgets/my_header.dart';
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
    return Scaffold(
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
            CountriesButton(),
            SizedBox(height: 30),
            Container(
              height: 500,
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(200, 40),
                  topRight: Radius.elliptical(200, 40),
                ),
              ),
              child: Column(
                children: [
                  FutureBuilder<StatsW>(
                    future: requestWorld(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        StatsW dataW = snapshot.data!;
                        return Column(
                          children: [
                            SizedBox(
                              height: 85,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Counter1(
                                    numberTotal: NumberFormat.compact()
                                        .format(dataW.cases),
                                    numberToday: NumberFormat.compact()
                                        .format(dataW.todayCases),
                                    isGood: false,
                                    title: 'INFECTADOS',
                                  ),
                                  Counter1(
                                    numberTotal: NumberFormat.compact()
                                        .format(dataW.recovered),
                                    numberToday: NumberFormat.compact()
                                        .format(dataW.todayRecovered),
                                    isGood: true,
                                    title: 'CURADOS',
                                  ),
                                  Counter1(
                                    numberTotal: NumberFormat.compact()
                                        .format(dataW.deaths),
                                    numberToday: NumberFormat.compact()
                                        .format(dataW.todayDeaths),
                                    isGood: false,
                                    title: 'MORTES',
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Atualizado às ${updatedAt()}hs",
                                  style: TextStyle(
                                    color: kTextLightColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      } else
                        return CircularProgressIndicator(color: Colors.white);
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(200, 60),
                        topRight: Radius.elliptical(200, 60),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            FutureBuilder<StatsW>(
              future: requestWorld(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  StatsW data = snapshot.data!;
                  return Column(
                    children: [
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
                                        text: "Atualizado às ${updatedAt()}hs",
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
                            InfoCardComp(
                              color: kInfectedColor,
                              number: data.cases!,
                              numberT: data.todayCases!,
                              title: 'Infectados',
                            ),
                            SizedBox(height: 15),
                            InfoCardComp(
                              color: kRecovercolor,
                              number: data.recovered!,
                              numberT: data.todayRecovered!,
                              title: 'Curados',
                            ),
                            SizedBox(height: 15),
                            InfoCardComp(
                              color: kDeathColor,
                              number: data.deaths!,
                              numberT: data.todayDeaths!,
                              title: 'Mortes',
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
    );
  }

  String updatedAt() {
    DateTime now = DateTime.now();
    String formatDate = DateFormat('HH:mm').format(now);
    return formatDate;
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
