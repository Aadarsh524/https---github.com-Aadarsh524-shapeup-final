import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shapeup/screens/user/premium/subscription_screen.dart';
import 'package:shapeup/screens/user/dashboard/profilescreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/services/notification/notification_services.dart';
import '../../../services/notification/local_notification_service.dart';
import '../../../services/stepstracker.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late final Box dataBox;
  late String firstName;
  late String calories;
  late String burn;
  late String glasses;
  late String carbs;
  late String protein;
  late String fat;
  late String fiber;
  late bool premium;
  late String sleepTime;
  late String exerciseTime;
  late String userImage;

  DateTime date = DateTime.now();
  String? week;
  String? day;
  String? month;

  setSleepTime() async {
    Time newSleepTime = Time(hour: 12, minute: 00, second: 00);
    void onTimeChanged(Time newTime) {
      setState(() {
        newSleepTime = newTime;
      });
    }

    Navigator.of(context).push(
      showPicker(
        showSecondSelector: false,
        context: context,
        value: newSleepTime,
        onChange: onTimeChanged,
        minuteInterval: TimePickerInterval.FIVE,
        onChangeDateTime: (DateTime dateTime) async {
          {
            String formattedSleepTime = DateFormat('h:mm a').format(dateTime);

            setState(() {
              sleepTime = formattedSleepTime;
            });

            await dataBox.put('sleepTime', sleepTime);

            FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .update({
              'sleepTime': sleepTime,
            }).then((value) => {
                      if (sleepTime != '')
                        {
                          LocalNotificationServices()
                              .scheduleSleepNotification(sleepTime)
                        }
                    });
          }
        },
      ),
    );
  }

  setExerciseTime() async {
    Time newSleepTime = Time(hour: 12, minute: 00, second: 00);
    void onTimeChanged(Time newTime) {
      setState(() {
        newSleepTime = newTime;
      });
    }

    Navigator.of(context).push(
      showPicker(
        showSecondSelector: false,
        context: context,
        value: newSleepTime,
        onChange: onTimeChanged,
        minuteInterval: TimePickerInterval.FIVE,
        // Optional onChange to receive value as DateTime
        onChangeDateTime: (DateTime dateTime) async {
          {
            String formattedExerciseTime =
                DateFormat('h:mm a').format(dateTime);
            setState(() {
              exerciseTime = formattedExerciseTime;
            });

            await dataBox.put('exerciseTime', exerciseTime);

            FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .update({
              'exerciseTime': exerciseTime,
            }).then((value) => {
                      if (exerciseTime != '')
                        {
                          LocalNotificationServices()
                              .scheduleExerciseNotification(exerciseTime)
                        }
                    });
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    NotificationServices().requestNotificationPermission();
    NotificationServices().firebaseNotificationInit(context);
    NotificationServices().setUpInteractMessage(context);

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
    premium = dataBox.get('premium');
    sleepTime = dataBox.get("sleepTime").toString();
    exerciseTime = dataBox.get("exerciseTime").toString();
    userImage = dataBox.get("userImage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 300),
                          child: const ProfileScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 3,
                              color: const Color.fromARGB(255, 190, 227, 57)),
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            fit: BoxFit.fill,
                            userImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //     width: 40,
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //         border: Border.all(
                  //             color: Color.fromARGB(255, 190, 227, 57),
                  //             width: 2),
                  //         borderRadius: BorderRadius.circular(50)),
                  //     child: IconButton(
                  //       color: Colors.white,
                  //       iconSize: 24,
                  //       padding: const EdgeInsets.all(0),
                  //       icon: const Icon(Icons.person_outlined),
                  //       onPressed: () async {
                  //         Navigator.push(
                  //           context,
                  //           PageTransition(
                  //             type: PageTransitionType.fade,
                  //             duration: const Duration(milliseconds: 300),
                  //             child: const ProfileScreen(),
                  //           ),
                  //         );
                  //       },
                  //     )),
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
                        color: const Color.fromARGB(255, 166, 181, 106),
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
                            color: const Color.fromARGB(255, 190, 227, 57),
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
                            color: const Color.fromARGB(255, 190, 227, 57),
                            child: premium == true
                                ? Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                        fontWeight:
                                                            FontWeight.w700),
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
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                                        fontWeight:
                                                            FontWeight.w700),
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
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                                        fontWeight:
                                                            FontWeight.w700),
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
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                                      fontWeight:
                                                          FontWeight.w700),
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
                                  )
                                : Stack(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Blur(
                                        blur: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                        style:
                                                            GoogleFonts.manjari(
                                                                letterSpacing:
                                                                    1,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      progressColor:
                                                          Colors.black,
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "$carbs gm",
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.manjari(
                                                              letterSpacing: 1,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
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
                                                        style:
                                                            GoogleFonts.manjari(
                                                                letterSpacing:
                                                                    1,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      progressColor:
                                                          Colors.black,
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "$protein gm",
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.manjari(
                                                              letterSpacing: 1,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
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
                                                        style:
                                                            GoogleFonts.manjari(
                                                                letterSpacing:
                                                                    1,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      progressColor:
                                                          Colors.black,
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "$fat gm",
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.manjari(
                                                              letterSpacing: 1,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
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
                                                      style:
                                                          GoogleFonts.manjari(
                                                              letterSpacing: 1,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "$fiber gm",
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.manjari(
                                                              letterSpacing: 1,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
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
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SubscriptionPage()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 125, 128, 122),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              textStyle: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 1,
                                                bottom: 1),
                                            child: Text(
                                              "Buy Premium",
                                              style: GoogleFonts.notoSansMono(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
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
                                  "Sleep Time : $sleepTime",
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
                                    setSleepTime();
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
                                  "Exercise Time : $exerciseTime",
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
                                    setExerciseTime();
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
                                        child: StepsTracker(),
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
