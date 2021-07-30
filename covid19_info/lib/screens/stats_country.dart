import 'package:covid19_info/models/stats.dart';
import 'package:covid19_info/util/requests.dart';
import 'package:covid19_info/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsCountryScreen extends StatefulWidget {
  @override
  _StatsCountryScreenState createState() => _StatsCountryScreenState();
}

class _StatsCountryScreenState extends State<StatsCountryScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    controller.addListener(onScroll);
    super.initState();
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
      body: Container(
        child: Column(
          children: <Widget>[
            MyHeader(
              image: 'assets/icons/coronadr.svg',
              textTop: "Selecione um país",
              textBottom: "para mais detalhes",
              offset: offset,
            ),
            FutureBuilder<List<StatsC>>(
              future: requestCountries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Color(0xFFE5E5E5),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                width: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: Image.network(
                                      snapshot.data![index].flag!,
                                      scale: 2),
                                ),
                              ),
                              Text(
                                snapshot.data![index].country!,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      },
                    ),
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
