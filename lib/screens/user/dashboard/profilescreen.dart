import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/login_screen.dart';
import 'package:shapeup/screens/user/premium/subscription_screen.dart';

import '../../../services/notification/local_notification_service.dart';
import 'editprofilescreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final Box dataBox;
  late String firstName;
  late String lastName;
  late String age;
  late String gender;
  late String height;
  late String weight;
  late String bmi;
  late String email;
  late String phone;
  late bool premium;
  late String userImage;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('storage');
    firstName = dataBox.get("firstName").toString();
    lastName = dataBox.get("lastName").toString();
    age = dataBox.get("age").toString();
    gender = dataBox.get("gender").toString();
    email = dataBox.get("email").toString();
    phone = dataBox.get("phone").toString();
    height = dataBox.get("height").toString();
    weight = dataBox.get("weight").toString().toString();
    bmi = dataBox.get("bmi").toString();
    premium = dataBox.get('premium');
    userImage = dataBox.get('userImage').toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        elevation: 0,
        toolbarHeight: 60,
        title: Text("Profile",
            style: GoogleFonts.montserrat(
                letterSpacing: .5,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600)),
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 114, 97, 89),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: IconButton(
                  color: Colors.black,
                  iconSize: 12,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 190, 227, 57),
                    borderRadius: BorderRadius.circular(100)),
                child: IconButton(
                  color: Colors.black,
                  iconSize: 18,
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 250),
                            child: const EditProfileScreen()));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      // ignore: sized_box_for_whitespace
      body: SafeArea(
          child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3,
                                      color: const Color.fromARGB(
                                          255, 190, 227, 57)),
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
                            Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                  //                   <--- right side
                                  color: Color.fromRGBO(142, 153, 183, 0.5),
                                  width: 1.0,
                                )),
                              ),
                              child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 5),
                                    child: premium == true
                                        ? InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text("Premium Account",
                                                  style: GoogleFonts.montserrat(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 255, 215, 0),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      duration: const Duration(
                                                          milliseconds: 250),
                                                      child:
                                                          const SubscriptionPage()));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text("Buy Premium",
                                                  style: GoogleFonts.montserrat(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 214, 21, 11),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          )),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.account_circle_sharp,
                              size: 20,
                              color: Color.fromARGB(255, 166, 181, 106),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("$firstName$lastName",
                                style: GoogleFonts.montserrat(
                                    letterSpacing: .5,
                                    color: const Color.fromARGB(
                                        255, 166, 181, 106),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              size: 20,
                              color: Color.fromRGBO(142, 153, 183, 0.5),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(email,
                                style: GoogleFonts.montserrat(
                                    letterSpacing: 0,
                                    color: Color.fromRGBO(142, 153, 183, 0.5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 20,
                              color: Color.fromRGBO(142, 153, 183, 0.5),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("+977 $phone",
                                style: GoogleFonts.montserrat(
                                    letterSpacing: 0,
                                    color: Color.fromRGBO(142, 153, 183, 0.5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            gender == "male"
                                ? const Icon(
                                    MdiIcons.genderMale,
                                    size: 20,
                                    color: Color.fromRGBO(142, 153, 183, 0.5),
                                  )
                                : const Icon(
                                    MdiIcons.genderFemale,
                                    size: 20,
                                    color: Color.fromRGBO(142, 153, 183, 0.5),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(gender,
                                style: GoogleFonts.montserrat(
                                    letterSpacing: 0,
                                    color: Color.fromRGBO(142, 153, 183, 0.5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text("Personal Information",
                              style: GoogleFonts.montserrat(
                                  letterSpacing: 0,
                                  color: Color.fromARGB(255, 114, 97, 89),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 1,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          color: Color.fromARGB(255, 114, 97, 89),
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Age:",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    age,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        letterSpacing: .5,
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Card(
                          elevation: 1,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          color: Color.fromARGB(255, 114, 97, 89),
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "BMI:",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    bmi,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        letterSpacing: .5,
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Card(
                          elevation: 1,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          color: Color.fromARGB(255, 114, 97, 89),
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Height:",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '$height cm',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        letterSpacing: .5,
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Card(
                          elevation: 1,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          color: Color.fromARGB(255, 114, 97, 89),
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Weight:",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '$weight kg',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        letterSpacing: .5,
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                      bottom: 15, top: 15),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    top: BorderSide(
                                      //                   <--- right side
                                      color: Color.fromRGBO(142, 153, 183, 0.5),
                                      width: 1.0,
                                    ),
                                    bottom: BorderSide(
                                      //                   <--- right side
                                      color: Color.fromRGBO(142, 153, 183, 0.5),
                                      width: 1.0,
                                    ),
                                  )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Privacy Policy",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.montserrat(
                                            color: const Color.fromRGBO(
                                                142, 153, 183, 0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color:
                                            Color.fromRGBO(142, 153, 183, 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // InkWell(
                              //   onTap: () {},
                              //   child: Container(
                              //     width: double.infinity,
                              //     padding: const EdgeInsets.only(
                              //         bottom: 15, top: 15),
                              //     decoration: const BoxDecoration(
                              //         border: Border(
                              //       bottom: BorderSide(
                              //         //                   <--- right side
                              //         color: Color.fromRGBO(142, 153, 183, 0.5),
                              //         width: 1.0,
                              //       ),
                              //     )),
                              //     child: Row(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.center,
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Text(
                              //           "Settings",
                              //           textAlign: TextAlign.left,
                              //           style: GoogleFonts.montserrat(
                              //               color: const Color.fromRGBO(
                              //                   142, 153, 183, 0.5),
                              //               fontSize: 14,
                              //               fontWeight: FontWeight.w600),
                              //         ),
                              //         const Icon(
                              //           Icons.arrow_forward_ios,
                              //           size: 16,
                              //           color:
                              //               Color.fromRGBO(142, 153, 183, 0.5),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    LocalNotificationServices()
                                        .cancelUserNotifications();
                                    GoogleSignIn googleSignIn = GoogleSignIn();
                                    await googleSignIn.signOut();
                                    await dataBox.clear();
                                    await _firebaseAuth.signOut().then(
                                        (value) => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen())));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: const Color.fromARGB(
                                          255, 125, 128, 122),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      textStyle: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 1, bottom: 1),
                                    child: Text(
                                      "Log out",
                                      style: GoogleFonts.notoSansMono(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ))),
    );
  }
}
