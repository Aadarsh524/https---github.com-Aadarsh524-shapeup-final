import 'dart:async';

import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/restscreen.dart';

import '../models/exercise_detail_model.dart';

class ExerciseRunScreen extends StatefulWidget {
  final List<ExerciseDetailModel> exercisedetailmodel;
  final int currentIndex;
  const ExerciseRunScreen(
      {Key? key, required this.exercisedetailmodel, required this.currentIndex})
      : super(key: key);

  @override
  State<ExerciseRunScreen> createState() => _ExerciseRunScreenState();
}

class _ExerciseRunScreenState extends State<ExerciseRunScreen> {
  ExerciseDetailModel? currentExercise;
  PageController controller = PageController();

  setCurrentExercise() {
    setState(() {
      currentExercise = widget.exercisedetailmodel[widget.currentIndex];
    });
  }

  setExerciseCounter() {
    setState(() {
      time = int.parse(currentExercise!.counter);
      currentIndex = widget.currentIndex;
    });
  }

  int currentIndex = 0;
  int time = 0;
  Timer? _timer;
  startCounter() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        time--;
      });

      if (time == 0) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 250),
            child: RestScreen(
              nextExercise: widget.exercisedetailmodel[currentIndex + 1],
              onNext: () {
                controller.animateToPage(
                  currentIndex + 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
        );
        setExerciseCounter();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // timeleft = int.parse(currentExercise!.counter);
    setCurrentExercise();
    setExerciseCounter();
    startCounter();
    super.initState();
  }

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
        body: Stack(
          children: [
            PageView.builder(
              controller: controller,
              onPageChanged: (val) {
                setState(() {
                  currentIndex = val;
                  currentExercise = widget.exercisedetailmodel[currentIndex];
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.exercisedetailmodel.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 153, 152, 152)),
                        ),
                      ),
                      child: Image.network(
                        currentExercise!.gif,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      currentExercise!.name,
                      style: GoogleFonts.notoSansMono(
                          color: Colors.black.withOpacity(.80),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    currentExercise!.duration == "true"
                        ? Text(
                            "${time}s",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSansMono(
                                color: Colors.black.withOpacity(.80),
                                fontSize: 36,
                                fontWeight: FontWeight.w700),
                          )
                        : Text(
                            currentExercise!.counter,
                            style: GoogleFonts.notoSansMono(
                                color: Colors.black.withOpacity(.80),
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          ),
                    const SizedBox(
                      height: 50,
                    ),
                    currentExercise!.duration == "true"
                        ? Text(
                            "Wait",
                            style: GoogleFonts.notoSansMono(
                                color: Colors.black.withOpacity(.75),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      child: RestScreen(
                                        nextExercise:
                                            widget.exercisedetailmodel[
                                                currentIndex + 1],
                                        onNext: () {
                                          controller.animateToPage(
                                            currentIndex + 1,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeIn,
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: const Color.fromARGB(
                                        255, 227, 252, 255),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    textStyle: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
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
                  ],
                );
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                          setExerciseCounter();
                        },
                        child: Text(
                          "Previous",
                          style: GoogleFonts.notoSansMono(
                              color: widget.currentIndex == 0
                                  ? Colors.grey
                                  : Colors.teal,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          "Skip",
                          style: GoogleFonts.notoSansMono(
                              color: (widget.currentIndex + 1) >=
                                      widget.exercisedetailmodel.length
                                  ? Colors.grey
                                  : Colors.teal,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}
