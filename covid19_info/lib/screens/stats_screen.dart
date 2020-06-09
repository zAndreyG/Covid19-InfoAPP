import 'package:covid19_info/style/constant.dart';
import 'package:covid19_info/widgets/counter.dart';
import 'package:covid19_info/widgets/my_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final List<String> dropDownList = ['Brasil', 'Indonésia', 'China', 'Estados Unidos', 'Japão', 'França', 'Itália', 'Argentina', 'Alemanha', 'Mexico'];
  final List<String> countryList = ['Brazil', 'Indonesia', 'China, USA', 'Japan', 'French', 'Italy', 'Argentina', 'Germany', 'Mexico'];

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
                    Expanded(child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset('assets/icons/dropdown.svg'),
                      value: 'Brasil',
                      items: dropDownList
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {},
                    ),)
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
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Casos Atualizados\n",
                                style: kTitleTextstyle,
                              ),
                              TextSpan(
                                text: "Atualizado em 06 de Março",
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Counter(
                            color: kInfectedColor,
                            number: 1046,
                            title: "Infectados",
                          ),
                          Counter(
                            color: kDeathColor,
                            number: 87,
                            title: "Mortes",
                          ),
                          Counter(
                            color: kRecovercolor,
                            number: 46,
                            title: "Curados",
                          ),
                        ],
                      ),
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