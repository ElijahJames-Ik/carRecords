class FilterCarModel {
  String fromYear;
  String toYear;
  String gender;
  String model;
  List<String> countries;
  List<String> colors;

  FilterCarModel(
      {this.fromYear,
      this.toYear,
      this.model,
      this.gender,
      this.countries,
      this.colors});
}
