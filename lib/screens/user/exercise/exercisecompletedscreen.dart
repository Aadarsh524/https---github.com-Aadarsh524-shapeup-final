import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/user/userDashboard/dashboardscreen.dart';

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
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      duration: const Duration(milliseconds: 250),
                      child: DashBoardScreen(),
                    ),
                  );
                },
                child: Text(
                  "Leave",
                  style: GoogleFonts.notoSansMono(
                      color: Colors.teal,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              )
            ])));
  }
}
