import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/settingScreen.dart';
import 'package:shapeup/screens/user/userRegister/genderscreen.dart';
import 'package:shapeup/screens/user/userRegister/heightscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shapeup/screens/user/userRegister/imagepickerscreen.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({Key? key}) : super(key: key);

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  int _currentIntValue = 60;
  late final Box dataBox;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('storage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        // ignore: sized_box_for_whitespace
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 75,
              ),
              Text("What are your Weight?",
                  style: GoogleFonts.montserrat(
                      letterSpacing: .5,
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 10,
              ),
              Text("You can always change this later",
                  style: GoogleFonts.montserrat(
                      letterSpacing: .5,
                      color: Color.fromARGB(255, 174, 155, 141),
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberPicker(
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
                    minValue: 1,
                    maxValue: 150,
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
                    onChanged: (value) =>
                        setState(() => _currentIntValue = value),
                  ),
                  Text("KG",
                      style: GoogleFonts.lateef(
                          letterSpacing: .5,
                          color: Color.fromARGB(255, 226, 226, 226),
                          fontSize: 16,
                          fontWeight: FontWeight.w600))
                ],
              )
            ],
          )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
              onPressed: () async {
                await dataBox.put('weight', _currentIntValue.toString());
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 250),
                        child: const SettingUpScreen()));
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
