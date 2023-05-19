import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shapeup/models/profile.dart';
import 'package:shapeup/screens/user/userRegister/genderscreen.dart';
import 'package:shapeup/screens/user/userRegister/heightscreen.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({Key? key}) : super(key: key);

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  late final Box dataBox;
  late String firstName;

  int _currentIntValue = 20;

  var authName = '';
  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('storage');
    firstName = dataBox.get("firstName");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        // ignore: sized_box_for_whitespace
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("Welcome,",
                                style: GoogleFonts.montserrat(
                                    letterSpacing: .5,
                                    color: Color.fromARGB(255, 125, 128, 122),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(firstName,
                                style: GoogleFonts.montserrat(
                                    letterSpacing: .5,
                                    color: Color.fromARGB(255, 190, 227, 57),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "To create a suitable fitness plan we need to know more about you",
                                style: GoogleFonts.montserrat(
                                    letterSpacing: .5,
                                    color: Color.fromARGB(255, 226, 226, 226),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400)),
                          ]),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text("What is your age?",
                        style: GoogleFonts.montserrat(
                            letterSpacing: .5,
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: NumberPicker(
                          value: _currentIntValue,
                          textStyle: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Colors.white12,
                          ),
                          selectedTextStyle: GoogleFonts.montserrat(
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          minValue: 0,
                          maxValue: 100,
                          step: 1,
                          haptics: true,
                          itemCount: 7,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color.fromARGB(
                                  255,
                                  208,
                                  253,
                                  62,
                                ),
                                width: 3.0,
                              ),
                              bottom: BorderSide(
                                color: Color.fromARGB(
                                  255,
                                  208,
                                  253,
                                  62,
                                ),
                                width: 3.0,
                              ),
                            ),
                          ),
                          onChanged: (value) => setState(() => {
                                _currentIntValue = value,
                              })),
                    ),
                  ],
                ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
              onPressed: () async {
                await dataBox.put('age', _currentIntValue.toString());

                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 250),
                        child: const GenderScreen()));
              },
              backgroundColor: const Color.fromARGB(
                255,
                208,
                253,
                62,
              ),
              label: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: GoogleFonts.notoSansMono(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    const Icon(
                      size: 24,
                      Icons.arrow_right,
                      color: Colors.black,
                    )
                  ],
                ),
              )),
        ));
  }
}
