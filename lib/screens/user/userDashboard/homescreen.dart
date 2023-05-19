import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shapeup/screens/user/userDashboard/profilescreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/stepstracker.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Box dataBox;
  late String firstName;
  late String calories;
  late String burn;
  late String glasses;
  late String carbs;
  late String protein;
  late String fat;
  late String fiber;
  DateTime date = DateTime.now();
  String? week;
  String? day;
  String? month;
  String? sleeptime = '';

  setSleeptTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context, //context of current state
    );
    if (pickedTime != null) {
      DateTime parsedTime = DateFormat.jm()
          // ignore: use_build_context_synchronously
          .parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.

      String formattedTime = DateFormat('h:mma').format(parsedTime);
      debugPrint(formattedTime);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("sleeptime", formattedTime);

      setState(() {
        sleeptime = prefs.getString("sleeptime");
        User? user = FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance.collection('profile').doc(user?.uid).update({
          'sleeptime': sleeptime,
        });
      });
    } else {
      debugPrint("Time is not selected");
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      week = DateFormat('EEEE').format(date);
      day = DateFormat('d').format(date);
      month = DateFormat('MMMM').format(date);
    });
    dataBox = Hive.box('storage');
    firstName = dataBox.get("firstName");
    calories = dataBox.get("calories").toString();
    burn = dataBox.get("burn").toString();
    glasses = dataBox.get("glasses").toString();
    carbs = dataBox.get("carbs").toString();
    protein = dataBox.get("protein").toString();
    fat = dataBox.get("fat").toString();
    fiber = dataBox.get("fiber").toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      body: SafeArea(
          child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 190, 227, 57),
                              width: 2),
                          borderRadius: BorderRadius.circular(50)),
                      child: IconButton(
                        color: Colors.white,
                        iconSize: 24,
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(Icons.person_outlined),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                              child: const ProfileScreen(),
                            ),
                          );
                        },
                      )),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey, $firstName",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 3,
                      ),
                      Text("$week, $day $month",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 15, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Lifestyle",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                        letterSpacing: .5,
                        color: Color.fromARGB(255, 166, 181, 106),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CarouselSlider(
                      options: CarouselOptions(
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: false,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1,
                      ),
                      items: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            color: Color.fromARGB(255, 190, 227, 57),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Nutrition",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.manjari(
                                        letterSpacing: 1,
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                width: 3, color: Colors.black)),
                                        child: const Center(
                                            child: Icon(
                                          size: 28,
                                          Icons.food_bank_outlined,
                                          color: Colors.black,
                                        )),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Eat upto $calories cal",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.montserrat(
                                            letterSpacing: .5,
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black)),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "swipe left to watch macros",
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.manjari(
                                            letterSpacing: .5,
                                            color: const Color.fromARGB(
                                                255, 25, 170, 151),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            color: Color.fromARGB(255, 190, 227, 57),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Macros",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.manjari(
                                        letterSpacing: 1,
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          CircularPercentIndicator(
                                            radius: 30.0,
                                            lineWidth: 5.0,
                                            percent: .4,
                                            center: Text(
                                              "Carbs",
                                              style: GoogleFonts.manjari(
                                                  letterSpacing: 1,
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            progressColor: Colors.black,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "$carbs gm",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.manjari(
                                                letterSpacing: 1,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          CircularPercentIndicator(
                                            radius: 30.0,
                                            lineWidth: 5.0,
                                            percent: .3,
                                            center: Text(
                                              "Protein",
                                              style: GoogleFonts.manjari(
                                                  letterSpacing: 1,
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            progressColor: Colors.black,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "$protein gm",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.manjari(
                                                letterSpacing: 1,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          CircularPercentIndicator(
                                            radius: 30.0,
                                            lineWidth: 5.0,
                                            percent: .3,
                                            center: Text(
                                              "Fat",
                                              style: GoogleFonts.manjari(
                                                  letterSpacing: 1,
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            progressColor: Colors.black,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "$fat gm",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.manjari(
                                                letterSpacing: 1,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Fiber",
                                            style: GoogleFonts.manjari(
                                                letterSpacing: 1,
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "$fiber gm",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.manjari(
                                                letterSpacing: 1,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Card(
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            color: const Color.fromARGB(255, 174, 155, 141),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 3, color: Colors.black)),
                                    child: const Center(
                                        child: Icon(
                                      size: 28,
                                      Icons.run_circle_outlined,
                                      color: Colors.black,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Burn atleast $burn",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "calories",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        letterSpacing: .5,
                                        color:
                                            const Color.fromARGB(125, 0, 0, 0),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 1,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            color: Color.fromARGB(255, 174, 155, 141),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 3, color: Colors.black)),
                                    child: const Center(
                                        child: Icon(
                                      size: 28,
                                      Icons.water_drop_sharp,
                                      color: Colors.black,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Drink $glasses glasses",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "of water",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        color:
                                            const Color.fromARGB(125, 0, 0, 0),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                      elevation: 1,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      color: const Color.fromARGB(255, 125, 128, 122),
                      child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sleep Time : $sleeptime",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                  color: Colors.black,
                                  padding: const EdgeInsets.all(0),
                                  iconSize: 20,
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    setSleeptTime();
                                  },
                                ),
                              ],
                            ),
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                      elevation: 1,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      color: const Color.fromARGB(255, 125, 128, 122),
                      child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Exercise Time : $sleeptime",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                  color: Colors.black,
                                  padding: const EdgeInsets.all(0),
                                  iconSize: 20,
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    setSleeptTime();
                                  },
                                ),
                              ],
                            ),
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                      elevation: 1,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      color: const Color.fromARGB(255, 125, 128, 122),
                      child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "View all trackers",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                  padding: const EdgeInsets.all(0),
                                  color: Colors.black,
                                  iconSize: 24,
                                  icon: const Icon(Icons.arrow_right_alt),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: const StepTracker(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ))),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
