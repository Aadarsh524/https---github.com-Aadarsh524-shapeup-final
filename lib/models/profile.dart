class Profile {
  String firstName;
  String lastName;
  String age;
  String gender;
  String height;
  String weight;
  String userType;
  String phone;

  Profile(
      {required this.firstName,
      required this.lastName,
      required this.age,
      required this.phone,
      required this.gender,
      required this.height,
      required this.weight,
      required this.userType});

  // Profile.fromJson(Map<String, dynamic> json) {
  //   firstName = json['firstName'];
  //   lastName = json['lastName'];
  //   age = json['age'];
  //   gender = json['gender'];
  //   height = json['height'];
  //   phone = json['phone'];
  //   weight = json['weight'];
  //   userType = json['userType'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['age'] = age;
    data['gender'] = gender;
    data['height'] = height;
    data['weight'] = weight;
    data['phone'] = phone;

    data['userType'] = userType;
    return data;
  }
}
