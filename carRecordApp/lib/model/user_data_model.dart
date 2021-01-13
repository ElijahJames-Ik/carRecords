class UserDataModel {
  String id;
  String avatar;
  String fullName;
  String createdAt;
  String gender;
  List<String> colorList;
  List<String> countryList;

  UserDataModel(
      {this.id,
      this.avatar,
      this.fullName,
      this.createdAt,
      this.gender,
      this.colorList,
      this.countryList});

  // create user Data model from json object
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    List<String> colors =
        (json['colors'] as List).map((e) => e as String).toList();
    List<String> countries =
        (json['countries'] as List).map((e) => e as String).toList();
    return UserDataModel(
      id: json['id'],
      avatar: json['avatar'],
      fullName: json['fullName'],
      createdAt: json['createdAt'],
      gender: json['gender'],
      colorList: colors != null ? colors : null,
      countryList: countries != null ? countries : null,
    );
  }
}
