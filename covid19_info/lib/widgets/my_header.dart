import 'package:covid19_info/screens/info_screen.dart';
import 'package:covid19_info/style/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHeader extends StatefulWidget {
  final String? image;
  final String? textTop;
  final String? textBottom;
  final double? offset;
  final bool? route;
  const MyHeader({
    Key? key,
    this.image,
    this.textTop,
    this.textBottom,
    this.offset,
    this.route,
  }) : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF3383CD),
                Color(0xFF11249F),
              ],
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/virus.png'),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ModalRoute.of(context)!.settings.name == '/'
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return InfoScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset('assets/icons/menu.svg'),
                    ))
                : InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset('assets/icons/forward.svg'))),
            SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: (widget.offset! < 0) ? 0 : widget.offset,
                    child: SvgPicture.asset(
                      widget.image!,
                      width: 230,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                    top: 30 - widget.offset! / 2,
                    left: 160,
                    child: Text(
                      "${widget.textTop} \n${widget.textBottom}",
                      style: kHeadingTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                  Container() //Por algum motivo o texto não é totalmente renderizado corretamente sem este container extra
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
