import 'dart:async';

import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/models/exercise_detail_model.dart';
import 'package:shapeup/screens/user/exercise/exerciserunscreen.dart';

class RestScreen extends StatefulWidget {
  final ExerciseDetailModel nextExercise;
  final int nextExerciseIndex;

  final List<ExerciseDetailModel> nextExerciseList;

  const RestScreen({
    Key? key,
    required this.nextExercise,
    required this.nextExerciseIndex,
    required this.nextExerciseList,
  }) : super(key: key);

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  int timeLeft = 20;

  setAgain() {
    setState(() {
      timeLeft = 20;
    });
  }

  Timer? _timer;

  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft--;
      });

      if (timeLeft == 0) {
        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 250),
              child: ExerciseRunScreen(
                  currentIndex: widget.nextExerciseIndex,
                  exercisedetailmodel: widget.nextExerciseList)),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    setAgain();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 0, right: 0, top: 10, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Next Exercise",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.notoSansMono(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.nextExercise.name,
                                    style: GoogleFonts.notoSansMono(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "X${widget.nextExercise.counter}",
                                    style: GoogleFonts.notoSansMono(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Image.network(
                            widget.nextExercise.gif,
                            colorBlendMode: BlendMode.colorBurn,
                            height: 275,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 214, 243, 155),
                    height: 250,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Rest",
                          style: GoogleFonts.notoSansMono(
                              color: Colors.black.withOpacity(.80),
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "00:$timeLeft",
                          style: GoogleFonts.notoSansMono(
                              color: Colors.black.withOpacity(.80),
                              fontSize: 36,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  timeLeft = timeLeft + 10;
                                });
                              },
                              child: Text(
                                "Add +10s",
                                style: GoogleFonts.notoSansMono(
                                    color: Colors.black.withOpacity(.75),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        duration:
                                            const Duration(milliseconds: 250),
                                        child: ExerciseRunScreen(
                                            currentIndex:
                                                widget.nextExerciseIndex,
                                            exercisedetailmodel:
                                                widget.nextExerciseList)));
                              },
                              child: Text(
                                "Skip",
                                style: GoogleFonts.notoSansMono(
                                    color: Colors.black.withOpacity(.75),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        ));
  }
}
