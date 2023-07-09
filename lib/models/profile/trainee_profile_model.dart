class TraineeProfileModel {
  String firstName;
  String lastName;
  String age;
  String email;
  String gender;
  String height;
  String weight;
  String bmi;

  String userImage;
  String userType;

  List purchasedPlans;
  final String id;
  String phone;

  TraineeProfileModel({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
    required this.gender,
    required this.userImage,
    required this.userType,
    required this.id,
    required this.phone,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.purchasedPlans,
  });
}
