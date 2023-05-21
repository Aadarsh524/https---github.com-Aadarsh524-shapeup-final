import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/trainer/trainerscreen/daycard.dart';
import 'package:shapeup/screens/trainer/trainerscreen/peoplepage.dart';

//import '../../../../services/firebaseservices.dart';

import 'package:shared_preferences/shared_preferences.dart';

class TraineeProfile extends StatefulWidget {
  const TraineeProfile({Key? key}) : super(key: key);

  @override
  State<TraineeProfile> createState() => _TraineeProfileState();
}

class _TraineeProfileState extends State<TraineeProfile> {
  String? authName;
  double? bmi;
  String? height;
  String? weight;
  asyncFunc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bmi = prefs.getDouble("BMI");
      prefs.getString("gender");
      height = prefs.getString("height");
      weight = prefs.getString("weight");
      prefs.getString("age");
      prefs.getBool("premium");
      authName = prefs.getString("authName");
    });
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  void initState() {
    asyncFunc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
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
              margin: const EdgeInsets.only(left: 15),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 114, 97, 89),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                color: Colors.black,
                iconSize: 18,
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: double.infinity,
        //   child: Card(
        //     margin: const EdgeInsets.only(left: 15, top: 12, bottom: 12),
        //     elevation: 5,
        //     shape:
        //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //     color: const Color.fromARGB(255, 114, 97, 89),
        //     child: Container(
        //       child: IconButton(
        //         icon: const Icon(
        //           Icons.arrow_back_ios_new_rounded,
        //           size: 18,
        //           color: Colors.black,
        //         ),
        //         onPressed: () => Navigator.of(context).pop(),
        //       ),
        //     ),
        //   ),
        // ),
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
                        top: 25, left: 20, right: 20, bottom: 10),
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
                                      color: Color.fromARGB(255, 190, 227, 57)),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.asset(
                                    fit: BoxFit.fill,
                                    "assets/male.png",
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
                            Text("Aadarsh Ghimire",
                                style: GoogleFonts.montserrat(
                                    letterSpacing: .5,
                                    color: Color.fromARGB(255, 166, 181, 106),
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
                            Text("aadarshghimire524@gmail.com",
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
                            Text("+977 9827182190",
                                style: GoogleFonts.montserrat(
                                    letterSpacing: 0,
                                    color: Color.fromRGBO(142, 153, 183, 0.5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
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
                                    "BMI:",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '22 ',
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
                                    '170 cm',
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
                                    '70 kg',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(
                                  255,
                                  208,
                                  253,
                                  62,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DayCard()));
                              },
                              child: Text(
                                'Update Workout',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 208, 253, 62),
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserPage()));
                                },
                                child: Icon(
                                  Icons.chat_bubble,
                                  color: Colors.black,
                                ))
                          ],
                        )
                      ],
                    )),
              ))),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       // print(_ageController.text),
      //       //         await FirebaseFirestore.instance
      //       //             .collection('profile')
      //       //             .doc(user?.uid)
      //       //             .set({
      //       //           'age': _ageController.text,
      //       //         }).then((value) => Navigator.pushReplacement(
      //       //                 context,
      //       //                 PageTransition(
      //       //                     type: PageTransitionType.fade,
      //       //                     duration:
      //       //                         const Duration(milliseconds: 250),
      //       //                     child: const GenderScreen())));
      //       // Navigator.push(context,
      //       //     MaterialPageRoute(builder: (context) => const LoginScreen()));
      //     },
      // backgroundColor: Color.fromARGB(255, 214, 21, 11),
      // label: SizedBox(
      //   child: Text(
      //     'Sign out',
      //     style: GoogleFonts.notoSansMono(
      //         fontSize: 14,
      //         color: Colors.black,
      //         fontWeight: FontWeight.w600),
      //   ),
      // )),
    );
  }
}
