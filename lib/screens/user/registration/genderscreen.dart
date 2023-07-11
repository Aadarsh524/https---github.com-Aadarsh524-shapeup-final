import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shapeup/components/gendercard.dart';
import 'package:shapeup/screens/user/registration/heightscreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

enum Gender {
  male,
  female,
}

class _GenderScreenState extends State<GenderScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late final Box dataBox;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('storage');
  }

  late Gender selectedGender = Gender.male;
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
          const SizedBox(
            height: 75,
          ),
          Text("What are you?",
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                  child: GenderCard(
                      iconColor: selectedGender == Gender.male
                          ? Colors.black
                          : Colors.white,
                      cardTitle: "Male",
                      cardColor: selectedGender == Gender.male
                          ? const Color.fromARGB(
                              255,
                              208,
                              253,
                              62,
                            )
                          : const Color.fromARGB(255, 44, 44, 46),
                      cardIcon: MdiIcons.genderMale),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                  child: GenderCard(
                      iconColor: selectedGender == Gender.female
                          ? Colors.black
                          : Colors.white,
                      cardTitle: "Female",
                      cardColor: selectedGender == Gender.female
                          ? const Color.fromARGB(
                              255,
                              208,
                              253,
                              62,
                            )
                          : const Color.fromARGB(255, 44, 44, 46),
                      cardIcon: MdiIcons.genderFemale),
                ),
              ),
            ],
          ),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
            onPressed: () async {
              print(selectedGender.name);
              await dataBox.put('gender', selectedGender.name);

              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 250),
                      child: const HeightScreen()));
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
      ),
    );
  }
}
