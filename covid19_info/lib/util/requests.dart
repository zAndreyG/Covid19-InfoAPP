import 'package:covid19_info/models/stats.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

Future<Stats> byCountry(String country) async {
  var dio = Dio();

  Response response = await dio.get('https://covid19-brazil-api.now.sh/api/report/v1/' + country);
  if (response != null && response.statusCode == 200) {
      var realData = response.data['data'];
      var country = realData['country'];
      var cases = realData['cases'];
      var confirmed = realData['confirmed'];
      var deaths = realData['deaths'];
      var recovered = realData['recovered'];
      var dateUpdated = realData['updated_at'];
      DateTime date = DateTime.parse(dateUpdated);
      var updated = DateFormat('dd/MM/yyyy').format(date);

      Stats stats = Stats(country, cases, confirmed, deaths, recovered, updated);
      return stats;
    }
}