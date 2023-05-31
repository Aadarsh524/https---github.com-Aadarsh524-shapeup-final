import 'dart:async';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/user/exercise/exercisecompletedscreen.dart';
import 'package:shapeup/screens/user/exercise/restscreen.dart';

import '../../../models/exercise_detail_model.dart';

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
    if (mounted) {
      setState(() {
        if ((currentIndex != (widget.exercisedetailmodel.length - 1))) {
          currentExercise = widget.exercisedetailmodel[widget.currentIndex];
        }
      });
    }
  }

  setExerciseCounter() {
    if (mounted) {
      setState(() {
        if (currentIndex != (widget.exercisedetailmodel.length - 1)) {
          time = int.parse(currentExercise!.counter);
          currentIndex = widget.currentIndex;
          print(currentIndex);
        }
      });
    }
  }

  int currentIndex = 0;
  int time = 0;
  bool isPause = false;
  Timer? _timer;

  startCounter() async {
    setState(() {
      isPause = false;
    });
    if (currentExercise!.duration == "true") {
      await Future.delayed(const Duration(milliseconds: 2000), () {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          print(_timer);
          if (mounted) {
            setState(() {
              time--;
            });
          }
          if (time == 0) {
            if (currentIndex == (widget.exercisedetailmodel.length - 1)) {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  duration: const Duration(milliseconds: 250),
                  child: const ExerciseCompletedScreen(),
                ),
              );
            }
            if (currentIndex < (widget.exercisedetailmodel.length - 1)) {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 250),
                  child: RestScreen(
                    nextExerciseIndex: currentIndex + 1,
                    nextExerciseList: widget.exercisedetailmodel,
                    nextExercise: widget.exercisedetailmodel[currentIndex + 1],
                  ),
                ),
              );
            }
          }
        });
      });
    }
  }

  stopCounter() {
    if (_timer != null && _timer!.isActive) {
      setState(() {
        isPause = true;
      });
      _timer!.cancel();
    }
  }

  @override
  void initState() {
    if (mounted) {
      setCurrentExercise();
      setExerciseCounter();
      startCounter();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
          toolbarHeight: 60,
          centerTitle: true,
          leading: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 114, 97, 89),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: IconButton(
                    color: Colors.black,
                    iconSize: 12,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 0, right: 0, bottom: 5),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 275,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 153, 152, 152)),
                        ),
                      ),
                      child: Image.network(
                        colorBlendMode: BlendMode.colorBurn,
                        height: 275,
                        fit: BoxFit.cover,
                        currentExercise!.gif,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      currentExercise!.name,
                      style: GoogleFonts.montserrat(
                          letterSpacing: .5,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    currentExercise!.duration == "true"
                        ? Text("${time}s",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                letterSpacing: .5,
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600))
                        : Text("${currentExercise!.counter}x",
                            style: GoogleFonts.montserrat(
                                letterSpacing: .5,
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 40,
                    ),
                    currentExercise!.duration == "true"
                        ? (isPause == true
                            ? SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      startCounter();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: const Color.fromARGB(
                                            255, 166, 181, 106),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14, horizontal: 24),
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    child: Text(
                                      "Continue",
                                      style: GoogleFonts.notoSansMono(
                                          color: Colors.black.withOpacity(.75),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ))
                            : SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      stopCounter();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: const Color.fromARGB(
                                            255, 166, 181, 106),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14, horizontal: 24),
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    child: Text(
                                      "Wait",
                                      style: GoogleFonts.notoSansMono(
                                          color: Colors.black.withOpacity(.75),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )))
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      child: RestScreen(
                                        nextExerciseIndex: currentIndex + 1,
                                        nextExerciseList:
                                            widget.exercisedetailmodel,
                                        nextExercise:
                                            widget.exercisedetailmodel[
                                                currentIndex + 1],
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color.fromARGB(
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
                              print(currentIndex);
                              if (currentIndex > 0) {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    duration: const Duration(milliseconds: 250),
                                    child: ExerciseRunScreen(
                                      currentIndex: currentIndex - 1,
                                      exercisedetailmodel:
                                          widget.exercisedetailmodel,
                                    ),
                                  ),
                                );
                              }
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
                              print(currentIndex);
                              print(widget.exercisedetailmodel.length);
                              if (currentIndex ==
                                  (widget.exercisedetailmodel.length - 1)) {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration:
                                          const Duration(milliseconds: 250),
                                      child: ExerciseCompletedScreen()),
                                );
                              }
                              if (currentIndex <
                                  (widget.exercisedetailmodel.length - 1)) {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(milliseconds: 250),
                                    child: ExerciseRunScreen(
                                      currentIndex: currentIndex + 1,
                                      exercisedetailmodel:
                                          widget.exercisedetailmodel,
                                    ),
                                  ),
                                );
                              }
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
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
