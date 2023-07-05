import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/user/exercise/customexercisedaydetail.dart';

import '../../../models/custom_exercise_model.dart';
import '../../../services/exerciseService.dart';

class CustomDayList extends StatelessWidget {
  final CustomExerciseModel exercisemodel;
  const CustomDayList({Key? key, required this.exercisemodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
          title: Text("Your Exercises",
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
          elevation: 0.0,
        ),
        body: SafeArea(
          child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: ExerciseService(docID: exercisemodel.id).list,
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return ListView.builder(
                    //shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (context, listindex) {
                      return GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Customexercisedaydetail(
                                        dayindex: listindex + 1,
                                        docId: exercisemodel.id,
                                      ))),
                        },
                        child: Card(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          elevation: 10.0,
                          child: Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Day ${listindex + 1}",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        color:
                                            Color.fromARGB(255, 226, 226, 226),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
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
