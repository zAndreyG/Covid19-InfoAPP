import 'package:covid19_info/models/stats.dart';
import 'package:covid19_info/util/countries.dart';
import 'package:dio/dio.dart';

var dio = Dio();

Future<StatsW> requestWorld() async {
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

Future<List<StatsC>> requestCountries() async {
  List<StatsC> list = [];
  Response response = await dio.get('https://disease.sh/v3/covid-19/countries');
  var data = response.data;
  data.forEach((dataC) {
    if (dataC['countryInfo']['iso3'] != null) {
      var country = countries
          .firstWhere(
              (element) => element.iso3Code == dataC['countryInfo']['iso3'])
          .namePT!;
      var flag = dataC['countryInfo']['flag'];
      var cases = dataC['cases'];
      var todayCases = dataC['todayCases'];
      var deaths = dataC['deaths'];
      var todayDeaths = dataC['todayDeaths'];
      var recovered = dataC['recovered'];
      var todayRecovered = dataC['todayRecovered'];
      var updated = dataC['updated'];

      StatsC stats = StatsC(country, flag, cases, todayCases, deaths,
          todayDeaths, recovered, todayRecovered, updated);
      list.add(stats);
    }
  });
  return list;
}
