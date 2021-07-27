import 'package:covid19_info/models/stats.dart';
import 'package:dio/dio.dart';

Future<StatsW> requestWorld() async {
  var dio = Dio();

  Response response = await dio.get('https://disease.sh/v3/covid-19/all');
  var data = response.data;
  var cases = data['cases'];
  var todayCases = data['todayCases'];
  var deaths = data['deaths'];
  var todayDeaths = data['todayDeaths'];
  var recovered = data['recovered'];
  var todayRecovered = data['todayRecovered'];
  var updated = data['updated'];

  StatsW stats = StatsW(cases, todayCases, deaths, todayDeaths, recovered,
      todayRecovered, updated);
  return stats;
}
