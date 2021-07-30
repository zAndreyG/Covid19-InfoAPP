// DADOS GLOBAIS
class StatsW {
  int? cases;
  int? todayCases;
  int? deaths;
  int? todayDeaths;
  int? recovered;
  int? todayRecovered;
  int? updated;

  // Constructor
  StatsW(int cases, int todayCases, int deaths, int todayDeaths, int recovered,
      int todayRecovered, int updated) {
    this.cases = cases;
    this.todayCases = todayCases;
    this.deaths = deaths;
    this.todayDeaths = todayDeaths;
    this.recovered = recovered;
    this.todayRecovered = todayRecovered;
    this.updated = updated;
  }
}

// DADOS POR PAÍS
class StatsC {
  String? country;
  String? flag;
  int? cases;
  int? todayCases;
  int? deaths;
  int? todayDeaths;
  int? recovered;
  int? todayRecovered;
  int? updated;

  // Constructor
  StatsC(String country, String flag, int cases, int todayCases, int deaths,
      int todayDeaths, int recovered, int todayRecovered, int updated) {
    this.country = country;
    this.flag = flag;
    this.cases = cases;
    this.todayCases = todayCases;
    this.deaths = deaths;
    this.todayDeaths = todayDeaths;
    this.recovered = recovered;
    this.todayRecovered = todayRecovered;
    this.updated = updated;
  }
}
