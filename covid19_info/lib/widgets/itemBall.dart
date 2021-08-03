import 'package:flutter/material.dart';

class ItemBall extends StatelessWidget {
  const ItemBall({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(.26),
      ),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: color,
              width: 2,
            )),
      ),
    );
  }
}
