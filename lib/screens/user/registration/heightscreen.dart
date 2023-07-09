import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shapeup/screens/user/registration/weightscreen.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({Key? key}) : super(key: key);

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  int _currentIntValue = 150;
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
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 75,
            ),
            Text("What is your Height?",
                style: GoogleFonts.montserrat(
                    letterSpacing: .5,
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 10,
            ),
            Text("This helps us to know your BMI",
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
                  minValue: 0,
                  maxValue: 250,
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
                Text("CM",
                    style: GoogleFonts.lateef(
                        letterSpacing: .5,
                        color: Color.fromARGB(255, 226, 226, 226),
                        fontSize: 16,
                        fontWeight: FontWeight.w600))
              ],
            )
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
              onPressed: () async {
                await dataBox.put('height', _currentIntValue.toString());
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 250),
                        child: const WeightScreen()));
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
