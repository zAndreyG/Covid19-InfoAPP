import 'package:covid19_info/style/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CountriesButton extends StatelessWidget {
  const CountriesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.only(left: 20),
            height: 90,
            width: double.infinity,
            clipBehavior: Clip
                .hardEdge, //Faz a imagem de background ficar dentro da borda do container
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Color(0xFFE5E5E5),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -40,
                  right: -20,
                  child: SvgPicture.asset(
                    'assets/images/world.svg',
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
                Positioned(
                  top: 18,
                  left: 15,
                  child: Text('Ver Países',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 60,
            child: FloatingActionButton(
              backgroundColor: kBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () => Navigator.of(context).pushNamed('/countries'),
              child: Icon(
                Icons.arrow_right_alt_sharp,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
