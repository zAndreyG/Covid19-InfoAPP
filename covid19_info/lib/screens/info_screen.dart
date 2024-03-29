import 'package:covid19_info/style/constant.dart';
import 'package:covid19_info/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
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
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MyHeader(
            image: "assets/icons/coronadr.svg",
            textTop: "Saiba mais",
            textBottom: "sobre o Covid-19",
            offset: offset,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Sintomas",
                  style: kTitleTextstyle,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SymptomCard(
                      image: "assets/images/headache.png",
                      title: "Dor de Cabeça",
                      isActive: true,
                    ),
                    SymptomCard(
                      image: "assets/images/caugh.png",
                      title: "Tosse",
                      isActive: true,
                    ),
                    SymptomCard(
                      image: "assets/images/fever.png",
                      title: "Febre",
                      isActive: true,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("Prevenção", style: kTitleTextstyle),
                SizedBox(height: 20),
                PreventCard(
                  image: "assets/images/wear_mask.png",
                  title: "Utilize máscara",
                  text:
                      "Desde o início da pandemia, alguns lugares exigem o uso de máscaras para a circulação em seu interior.",
                  isActive: true,
                ),
                PreventCard(
                  image: "assets/images/wash_hands.png",
                  title: "Lave as mãos",
                  text:
                      "Lavar as mãos com água e sabão, é a sua maior arma contra o coronavírus.",
                  isActive: true,
                ),
                SizedBox(height: 50)
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class PreventCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? text;
  final bool? isActive;
  const PreventCard({
    Key? key,
    this.image,
    this.title,
    this.text,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 156,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 136,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  isActive!
                      ? BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 24,
                          color: kActiveShadowColor,
                        )
                      : BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          color: kShadowColor,
                        ),
                ],
              ),
            ),
            Image.asset(image!),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(title!, style: kTitleTextstyle.copyWith(fontSize: 16)),
                    Text(
                      text!,
                      style: TextStyle(fontSize: 12),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset("assets/icons/forward.svg")),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String? image;
  final String? title;
  final bool isActive;
  const SymptomCard({
    Key? key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            isActive
                ? BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    color: kActiveShadowColor,
                  )
                : BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 6,
                    color: kShadowColor,
                  ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Image.asset(image!, height: 90),
            Text(
              title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ));
  }
}
