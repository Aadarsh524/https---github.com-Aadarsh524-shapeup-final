import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:numberpicker/numberpicker.dart';
import 'package:shapeup/screens/trainer/trainerRegister/experiencescreen.dart';

class AgePicker extends StatefulWidget {
  const AgePicker({Key? key}) : super(key: key);

  @override
  State<AgePicker> createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  late final Box dataBox;
  late String firstName;

  User? user = FirebaseAuth.instance.currentUser;
  int _currentIntValue = 20;

  final _ageController = TextEditingController();

  var authName = '';
  @override
  void initState() {
    dataBox = Hive.box('storage');

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        final name = providerProfile.displayName;
        setState(() {
          authName = name!;
        });
      }
    }
    super.initState();
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
                            Text("Bibash",
                                style: GoogleFonts.montserrat(
                                    letterSpacing: .5,
                                    color: Color.fromARGB(255, 190, 227, 57),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Tell us more about you.",
                                style: GoogleFonts.montserrat(
                                    letterSpacing: .5,
                                    color: Color.fromARGB(255, 226, 226, 226),
                                    fontSize: 18,
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
                        onChanged: (value) =>
                            setState(() => _currentIntValue = value),
                      ),
                    ),
                  ],
                ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
              onPressed: () async {
                await dataBox.put('age', _currentIntValue.toString());
                print(_currentIntValue);
                // print(_ageController.text),
                //         await FirebaseFirestore.instance
                //             .collection('profile')
                //             .doc(user?.uid)
                //             .set({
                //           'age': _ageController.text,
                //         }).then((value) => Navigator.pushReplacement(
                //                 context,
                //                 PageTransition(
                //                     type: PageTransitionType.fade,
                //                     duration:
                //                         const Duration(milliseconds: 250),
                //                     child: const GenderScreen())));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ExpAge()));
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
                    Icon(
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
