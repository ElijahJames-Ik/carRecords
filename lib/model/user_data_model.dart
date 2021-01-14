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
    List<String> colors = json['colors'] != null
        ? (json['colors'] as List).map((e) => e as String).toList()
        : null;
    List<String> countries = json['countries'] != null
        ? (json['countries'] as List).map((e) => e as String).toList()
        : null;
    return UserDataModel(
      id: json['id'] != null ? json['id'] : null,
      avatar: json['avatar'] != null ? json['avatar'] : null,
      fullName: json['fullName'] != null ? json['fullName'] : null,
      createdAt: json['createdAt'] != null ? json['createdAt'] : null,
      gender: json['gender'] != null ? json['gender'] : null,
      colorList: colors != null ? colors : null,
      countryList: countries != null ? countries : null,
    );
  }
}
