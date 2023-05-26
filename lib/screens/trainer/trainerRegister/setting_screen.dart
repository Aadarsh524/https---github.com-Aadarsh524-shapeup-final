// ignore_for_file: file_names, avoid_print, duplicate_ignore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/trainer/trainerscreen/trainerscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingUpScreenT extends StatefulWidget {
  const SettingUpScreenT({Key? key}) : super(key: key);

  @override
  State<SettingUpScreenT> createState() => _SettingUpScreenTState();
}

class _SettingUpScreenTState extends State<SettingUpScreenT> {
  late Box dataBox;
  User? user = FirebaseAuth.instance.currentUser;

  late String firstName;
  late String lastName;
  late String phone;
  late String userType;
  late String age;
  late String gender;
  late String userImage;
  late String uid;
  late String email;
  late String expage;
  late String descrp;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('storage');
    firstName = dataBox.get("firstName");
    lastName = dataBox.get("lastName");
    phone = dataBox.get("phone");
    userType = dataBox.get("userType");
    age = dataBox.get("age");
    gender = dataBox.get("gender");
    expage = dataBox.get("expage");

    uid = dataBox.get("uid");
    email = dataBox.get("email");
    descrp = dataBox.get("descrp");

    print(firstName);
    print(lastName);
    print(phone);
    print(userType);
    print(age);
    print(gender);

    print(uid);
    print(email);

    if (user != null) {
      for (final providerProfile in user!.providerData) {
        userImage = providerProfile.photoURL!;
        print(userImage);
      }
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({
          "uid": uid,
          'firstName': firstName,
          'lastName': lastName,
          'age': age,
          'gender': gender,
          'phone': phone,
          'userType': userType,
          'userImage': userImage,
          'email': email,
          'expage': expage,
          'descrp': descrp,
        })
        .then((value) async => {
              print("Data added suceccfully"),
              print("Data added suceccfully"),
              print("Data added suceccfully"),
              print("Data added suceccfully"),
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 250),
                      child: const TrainerPage()))
            })
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        // ignore: sized_box_for_whitespace
        body: SafeArea(
            child: Center(
                child: CircularProgressIndicator(
          color: Colors.white,
        ))));
  }
}
