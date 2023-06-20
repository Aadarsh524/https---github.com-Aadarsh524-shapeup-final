import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/user/exercise/exerciserunscreen.dart';

import 'package:styled_widget/styled_widget.dart';

import '../../../models/exercise_detail_model.dart';
import '../../../services/exerciseService.dart';
import 'package:wakelock/wakelock.dart';

class ExerciseDayDetail extends StatefulWidget {
  final String docId;
  final int dayindex;

  const ExerciseDayDetail(
      {Key? key, required this.docId, required this.dayindex})
      : super(key: key);

  @override
  State<ExerciseDayDetail> createState() => _ExerciseDayDetailState();
}

class _ExerciseDayDetailState extends State<ExerciseDayDetail> {
  PageController controller = PageController();

  int currentIndex = 0;
  int daysLength = 0;
  String? id;

  setLength(int length) {
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        daysLength = length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shape: const Border(
            bottom:
                BorderSide(color: Color.fromARGB(255, 190, 227, 57), width: 1)),
        toolbarHeight: 60,
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
            padding: const EdgeInsets.only(left: 12, top: 0),
            child: Text("Day: ${widget.dayindex}",
                style: GoogleFonts.montserrat(
                    letterSpacing: .5,
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600))),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            FutureBuilder<List<ExerciseDetailModel>>(
                future: ExerciseService(
                        docID: widget.docId, dayindex: widget.dayindex)
                    .listExerciseInfo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("have data");
                    return Expanded(
                        flex: 1,
                        child: Column(children: [
                          Flexible(
                            child: PageView.builder(
                              controller: controller,
                              itemCount: snapshot.data!.length,
                              onPageChanged: ((value) {
                                setState(() {
                                  currentIndex = value;
                                });
                              }),
                              itemBuilder: (context, index) {
                                setLength(snapshot.data!.length);

                                return snapshot.data![index].name == "restday"
                                    ? Center(
                                        child: Text(
                                          "Take Rest",
                                          style: GoogleFonts.notoSansMono(
                                              color: const Color.fromARGB(
                                                  255, 226, 226, 226),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${index + 1}',
                                              style: GoogleFonts.notoSansMono(
                                                  color: const Color.fromARGB(
                                                      255, 226, 226, 226),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ExerciseDetailWidget(
                                              title: 'Name',
                                              data: snapshot.data![index].name,
                                            ),
                                            ExerciseDetailWidget(
                                              title: 'Description',
                                              data: snapshot
                                                  .data![index].description,
                                            ),
                                            ExerciseDetailWidget(
                                              title: 'Counter',
                                              data: snapshot
                                                  .data![index].counter
                                                  .toString(),
                                            ),
                                            Image.network(
                                              colorBlendMode:
                                                  BlendMode.colorBurn,
                                              height: 275,
                                              fit: BoxFit.fill,
                                              snapshot.data![index].gif,
                                            ).center().expanded(),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            SizedBox(
                                                width: double.infinity,
                                                child: Center(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Wakelock.enable();
                                                      Navigator.pushReplacement(
                                                        context,
                                                        PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      250),
                                                          child:
                                                              ExerciseRunScreen(
                                                            exercisedetailmodel:
                                                                snapshot.data!,
                                                            currentIndex: 0,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        elevation: 0,
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                166,
                                                                181,
                                                                106),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 14,
                                                                horizontal: 20),
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    child: Text(
                                                      "Start",
                                                      style: GoogleFonts
                                                          .notoSansMono(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      .75),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  ),
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15, bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      controller.previousPage(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      300),
                                                          curve: Curves.easeIn);
                                                    },
                                                    child: Text(
                                                      'Previous',
                                                      style: GoogleFonts.montserrat(
                                                          color: currentIndex ==
                                                                  0
                                                              ? const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  174,
                                                                  155,
                                                                  141)
                                                              : const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  25,
                                                                  170,
                                                                  151),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      controller.nextPage(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      300),
                                                          curve: Curves.easeIn);
                                                    },
                                                    child: Text(
                                                      'Next',
                                                      style: GoogleFonts.montserrat(
                                                          color: (currentIndex +
                                                                      1) >=
                                                                  daysLength
                                                              ? const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  174,
                                                                  155,
                                                                  141)
                                                              : const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  25,
                                                                  170,
                                                                  151),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                            ),
                          ),
                        ]));
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class ExerciseDetailWidget extends StatelessWidget {
  final String title;
  final String data;
  const ExerciseDetailWidget(
      {Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: GoogleFonts.montserrat(
            letterSpacing: .5,
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        children: [
          TextSpan(
              text: data,
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    ).padding(bottom: 10);
  }
}
