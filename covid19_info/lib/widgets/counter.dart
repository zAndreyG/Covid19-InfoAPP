import 'package:covid19_info/style/constant.dart';
import 'package:covid19_info/widgets/itemBall.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final String? number;
  final Color? color;
  final String? title;
  const Counter({
    Key? key,
    this.number,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "$number",
            style: TextStyle(
              fontSize: 25,
              color: color,
            ),
          ),
        ),
        Text(title!, style: kSubTextStyle),
      ],
    );
  }
}

class Counter1 extends StatelessWidget {
  final String numberTotal;
  final String numberToday;
  final String title;
  final bool isGood;
  const Counter1({
    Key? key,
    required this.numberTotal,
    required this.numberToday,
    required this.isGood,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            numberTotal,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        Text(title, style: kSubTextStyle),
        Row(
          children: [
            ItemBall(color: isGood ? kRecovercolor : kDeathColor),
            SizedBox(width: 6),
            Text('+$numberToday',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isGood ? kRecovercolor : kDeathColor)),
          ],
        )
      ],
    );
  }
}
