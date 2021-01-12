class FilterModel {
  String fromYear;
  String toYear;
  String gender;
  List<String> countries;
  List<String> colors;

  FilterModel(
      {this.fromYear, this.toYear, this.gender, this.countries, this.colors});
}
