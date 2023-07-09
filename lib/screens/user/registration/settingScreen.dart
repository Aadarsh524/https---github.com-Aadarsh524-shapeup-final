// ignore_for_file: file_names, avoid_print, duplicate_ignore

import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/notification/notification_services.dart';
import '../dashboard/dashboardscreen.dart';

class SettingUpScreen extends StatefulWidget {
  const SettingUpScreen({Key? key}) : super(key: key);

  @override
  State<SettingUpScreen> createState() => _SettingUpScreenState();
}

class _SettingUpScreenState extends State<SettingUpScreen> {
  late Box dataBox;
  User? user = FirebaseAuth.instance.currentUser;

  late String firstName;
  late String lastName;
  late String phone;
  late String userType;
  late String age;
  late String gender;
  late String height;
  late String weight;
  late String userImage;
  late String uid;
  late String email;
  late bool premium = false;
  late bool hasTrainer = false;

  late String sleepTime;
  late String exerciseTime;
  int calories = 0;
  int burn = 0;
  double bmr = 0;
  double amr = 0;

  int glasses = 0;
  double water = 0;

  double bmi = 0;

  int carbs = 0;
  int protein = 0;
  int fat = 0;
  int fiber = 0;

  String? deviceToken;

  void fetchDeviceToken() async {
    String? token = await NotificationServices().getDeviceToken();
    if (token != null) {
      setState(() {
        deviceToken = token;
        print(deviceToken);

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
              'height': height,
              'weight': weight,
              'userImage': userImage,
              'email': email,
              'calories': calories.toString(),
              'burn': burn.toString(),
              'glasses': glasses.toString(),
              'bmi': bmi.toString(),
              'carbs': carbs.toString(),
              'protein': protein.toString(),
              'fat': fat.toString(),
              'fiber': fiber.toString(),
              'premium': premium,
              'hasTrainer': hasTrainer,
              "myTrainer": '',
              "sleepTime": '',
              "exerciseTime": '',
              "deviceToken": deviceToken
            })
            .then((value) async => {
                  print("Data added suceccfully"),
                  print("Data added suceccfully"),
                  print("Data added suceccfully"),
                  print("Data added suceccfully"),
                  await dataBox.put('userImage', userImage),
                  await dataBox.put('calories', calories),
                  await dataBox.put('burn', burn),
                  await dataBox.put('glasses', glasses),
                  await dataBox.put('bmi', bmi),
                  await dataBox.put('carbs', carbs),
                  await dataBox.put('protein', protein),
                  await dataBox.put('fat', fat),
                  await dataBox.put('fiber', fiber),
                  await dataBox.put('premium', premium),
                  await dataBox.put('hasTrainer', hasTrainer),
                  await dataBox.put('myTrainer', ''),
                  await dataBox.put('sleepTime', sleepTime),
                  await dataBox.put('exerciseTime', exerciseTime),
                  await dataBox.put('deviceToken', deviceToken),
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 250),
                          child: const DashBoardScreen(
                            selectedIndex: 0,
                          )))
                })
            .catchError((error) => print("Failed to add user: $error"));
      });
    }
  }

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
    height = dataBox.get("height");
    weight = dataBox.get("weight");
    uid = dataBox.get("uid");
    email = dataBox.get("email");
    sleepTime = dataBox.get("sleepTime");
    exerciseTime = dataBox.get("exerciseTime");

// calorie counter
    if (gender == "male") {
      bmr = 66.47 +
          (13.75 * int.parse(weight)) +
          (5.003 * int.parse(height)) -
          (6.755 * int.parse(age));
    } else if (gender == "female") {
      bmr = 655.1 +
          (13.75 * int.parse(weight)) +
          (5.003 * int.parse(height)) -
          (6.755 * int.parse(age));
    }
    amr = bmr * 1.375;
    int factor = amr ~/ 100;
    calories = factor * 100;
    print(calories);

//burn calories
    burn = (.2 * calories).toInt();
    print(burn);

// bmi
    bmi = (int.parse(weight) / pow(int.parse(height) / 100, 2));
    print(bmi);

//glasses of water
    water = (int.tryParse(weight)! * 2.20462) / 2;
    glasses = water ~/ 10;
    print(water);

//macros

    carbs = (0.4 * calories) ~/ 4;
    protein = (0.3 * calories) ~/ 4;
    fat = (0.3 * calories) ~/ 9;
    fiber = 20;

    print(carbs);
    print(protein);
    print(carbs);
    print(fiber);

    if (user != null) {
      for (final providerProfile in user!.providerData) {
        userImage = providerProfile.photoURL!;
        print(userImage);
      }
    }

    fetchDeviceToken();
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
