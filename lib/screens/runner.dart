import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/restscreen.dart';

class ExerciseRunScreen extends StatefulWidget {
  const ExerciseRunScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseRunScreen> createState() => _ExerciseRunScreenState();
}

class _ExerciseRunScreenState extends State<ExerciseRunScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          toolbarHeight: 65,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
            child: Stack(
          children: [
            Column(mainAxisSize: MainAxisSize.max, children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(color: Color.fromARGB(255, 153, 152, 152)),
                  ),
                ),
                child: Image.asset("assets/splash.png"),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Jumping Jack",
                style: GoogleFonts.notoSansMono(
                    color: Colors.black.withOpacity(.80),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Timer or Count",
                style: GoogleFonts.notoSansMono(
                    color: Colors.black.withOpacity(.80),
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         type: PageTransitionType.fade,
                      //         duration: const Duration(milliseconds: 250),
                      //         child: const RestScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: const Color.fromARGB(255, 227, 252, 255),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: Text(
                      "Done",
                      style: GoogleFonts.notoSansMono(
                          color: Colors.black.withOpacity(.75),
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ]),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Previous",
                          style: GoogleFonts.notoSansMono(
                              color: Colors.black.withOpacity(.75),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Skip",
                          style: GoogleFonts.notoSansMono(
                              color: Colors.black.withOpacity(.75),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        )));
  }
}
