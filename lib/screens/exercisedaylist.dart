import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/models/exercise_model.dart';
import 'package:shapeup/screens/exercisedaydetail.dart';
import 'package:shapeup/services/exercisedb.dart';

class ExerciseDayList extends StatelessWidget {
  final ExerciseModel exercisemodel;
  const ExerciseDayList({Key? key, required this.exercisemodel})
      : super(key: key);

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
            child: Text(
              "Your Exercises",
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: StreamBuilder<DocumentSnapshot<Object?>>(
            stream: ExerciseDatabase(docID: exercisemodel.id).list,
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: exercisemodel.number,
                    itemBuilder: (context, listindex) {
                      return GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ExerciseDayDetail(
                                        dayindex: listindex + 1,
                                        docId: exercisemodel.id,
                                      ))),
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          elevation: 10.0,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Day ${listindex + 1} ",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return const CircularProgressIndicator();
              }
            }),
          ),
        ));
  }
}
