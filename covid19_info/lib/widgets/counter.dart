import 'package:covid19_info/style/constant.dart';
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
