class CarOwnerDataModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String country;
  final String carModel;
  final String carModelYear;
  final String carColor;
  final String gender;
  final String jobTitle;
  final String bio;

  CarOwnerDataModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.country,
      this.carModel,
      this.carModelYear,
      this.carColor,
      this.gender,
      this.jobTitle,
      this.bio});

  factory CarOwnerDataModel.fromList(List<String> list) {
    return CarOwnerDataModel(
        id: list[0],
        firstName: list[1],
        lastName: list[2],
        email: list[3],
        country: list[4],
        carModel: list[5],
        carModelYear: list[6],
        carColor: list[7],
        gender: list[8],
        jobTitle: list[9],
        bio: list[10]);
  }
}
