import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/user/dashboard/dashboardscreen.dart';
import 'package:wakelock/wakelock.dart';

class ExerciseCompletedScreen extends StatefulWidget {
  const ExerciseCompletedScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseCompletedScreen> createState() =>
      _ExerciseCompletedScreenState();
}

class _ExerciseCompletedScreenState extends State<ExerciseCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        body: SafeArea(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Congratulation, You've burned enough for the day.",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.notoSansMono(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            duration: const Duration(milliseconds: 250),
                            child: DashBoardScreen(
                              selectedIndex: 0,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      child: Text(
                        "Leave",
                        style: GoogleFonts.notoSansMono(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ]),
          ),
        )));
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }
}
