import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/exerciserunscreen.dart';
import 'package:shapeup/services/exercisedb.dart';
import 'package:styled_widget/styled_widget.dart';

import '../models/exercise_detail_model.dart';

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
  dynamic data;

  String? save;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
            padding: const EdgeInsets.only(left: 12, top: 10),
            child: Text("Day: ${widget.dayindex}",
                style: GoogleFonts.montserrat(
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 20)))),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color.fromARGB(255, 153, 152, 152)),
              ),
            ),
          ),
          StreamBuilder<List<ExerciseDetailModel>>(
              stream: ExerciseDatabase(
                      docID: widget.docId, dayindex: widget.dayindex)
                  .listExerciseInfo,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DietDetailWidget(
                                          title: 'Name',
                                          data: snapshot.data![index].name,
                                        ),
                                        DietDetailWidget(
                                          title: 'Description',
                                          data:
                                              snapshot.data![index].description,
                                        ),
                                        DietDetailWidget(
                                          title: 'Counter',
                                          data: snapshot.data![index].counter
                                              .toString(),
                                        ),
                                        Image.network(
                                          snapshot.data![index].gif,
                                        ).center().expanded(),
                                      ],
                                    ).padding(top: 20, horizontal: 20);
                            },
                          ),
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        duration:
                                            const Duration(milliseconds: 250),
                                        child: ExerciseRunScreen(
                                          exercisedetailmodel: snapshot.data!,
                                          currentIndex: currentIndex,
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
                                    "Start",
                                    style: GoogleFonts.notoSansMono(
                                        color: Colors.black.withOpacity(.75),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )))
                      ]));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                child: Text(
                  'Previous',
                  style: TextStyle(
                      color: currentIndex == 0 ? Colors.grey : Colors.teal),
                ),
              ),
              TextButton(
                onPressed: () {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: (currentIndex + 1) >= daysLength
                          ? Colors.grey
                          : Colors.teal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DietDetailWidget extends StatelessWidget {
  final String title;
  final String data;
  const DietDetailWidget({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: GoogleFonts.notoSansMono(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
        children: [
          TextSpan(
            text: data,
            style: GoogleFonts.notoSansMono(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ).padding(bottom: 15);
  }

  void save() {}
}
