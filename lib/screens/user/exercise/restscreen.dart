import 'dart:async';

import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/models/exercise_detail_model.dart';

class RestScreen extends StatefulWidget {
  final VoidCallback onNext;
  final ExerciseDetailModel nextExercise;
  const RestScreen({Key? key, required this.onNext, required this.nextExercise})
      : super(key: key);

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
        Navigator.pop(context);
        widget.onNext();
        setAgain();
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.notoSansMono(
                              color: Colors.black.withOpacity(.80),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.nextExercise.name,
                              style: GoogleFonts.notoSansMono(
                                  color: Colors.black.withOpacity(.80),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "X${widget.nextExercise.counter}",
                              style: GoogleFonts.notoSansMono(
                                  color: Colors.black.withOpacity(.80),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 153, 152, 152)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 240,
                          width: double.infinity,
                          child: Image.asset("assets/splash.png"),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 125, 117, 6),
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
                                Navigator.pop(context);
                                widget.onNext();
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
