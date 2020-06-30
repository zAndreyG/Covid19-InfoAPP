class Stats {
  String country;
  int cases;
  int confirmed;
  int deaths;
  int recovered;
  String updated;

  // Constructor
  Stats(String country, int cases, int confirmed, int deaths, int recovered, String updated) {
    this.country = country;
    this.cases = cases;
    this.confirmed = confirmed;
    this.deaths = deaths;
    this.recovered = recovered;
    this.updated = updated;
  }
}