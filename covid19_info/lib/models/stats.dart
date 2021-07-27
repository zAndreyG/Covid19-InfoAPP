class StatsC {
  String? country;
  int? cases;
  int? confirmed;
  int? deaths;
  int? recovered;
  String? updated;

  // Constructor
  Stats(String country, int cases, int confirmed, int deaths, int recovered,
      String updated) {
    this.country = country;
    this.cases = cases;
    this.confirmed = confirmed;
    this.deaths = deaths;
    this.recovered = recovered;
    this.updated = updated;
  }
}

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
