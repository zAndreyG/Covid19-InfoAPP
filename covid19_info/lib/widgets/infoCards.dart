import 'package:covid19_info/style/constant.dart';
import 'package:covid19_info/widgets/counter.dart';
import 'package:covid19_info/widgets/itemBall.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              offset: Offset(2, 4),
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

class InfoCardComp extends StatefulWidget {
  const InfoCardComp({
    Key? key,
    required this.color,
    required this.number,
    required this.numberT,
    required this.title,
  }) : super(key: key);

  final Color color;
  final int number, numberT;
  final String title;

  @override
  _InfoCardCompState createState() => _InfoCardCompState();
}

class _InfoCardCompState extends State<InfoCardComp> {
  bool noPrecision = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => noPrecision = !noPrecision),
      child: Container(
        padding: EdgeInsets.all(20),
        height: 100,
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
              offset: Offset(4, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ItemBall(color: widget.color),
            // Total
            Counter(
              color: widget.color,
              number: noPrecision
                  ? NumberFormat.compactLong(locale: 'pt').format(widget.number)
                  : widget.number.toString(),
              title: widget.title,
            ),

            // Dia atual
            Counter(
              color: widget.color,
              number: noPrecision
                  ? NumberFormat.compactLong(locale: 'pt')
                      .format(widget.numberT)
                  : widget.numberT.toString(),
              title: 'Novos - HOJE',
            ),
          ],
        ),
      ),
    );
  }
}
