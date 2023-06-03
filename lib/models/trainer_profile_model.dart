class TrainerProfileModel {
  String firstName;
  String lastName;
  String age;
  String email;
  String gender;
  String descrp;
  String userImage;
  String userType;
  String expage;
  final String id;
  String phone;
  List clients;

  TrainerProfileModel(
      {required this.firstName,
      required this.lastName,
      required this.age,
      required this.email,
      required this.gender,
      required this.descrp,
      required this.userImage,
      required this.userType,
      required this.expage,
      required this.id,
      required this.phone,
      required this.clients});
}
