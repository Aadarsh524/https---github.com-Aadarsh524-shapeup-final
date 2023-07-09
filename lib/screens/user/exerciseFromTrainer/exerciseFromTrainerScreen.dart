import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shapeup/screens/user/exerciseFromTrainer/trainerexercisedaydetail.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../services/exercise/exercise_service.dart';

class ExerciseFromTrainerScreen extends StatefulWidget {
  const ExerciseFromTrainerScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseFromTrainerScreen> createState() =>
      _ExerciseFromTrainerScreenState();
}

class _ExerciseFromTrainerScreenState extends State<ExerciseFromTrainerScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  late final Box dataBox;
  late bool premium;
  late bool hasTrainer;
  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('storage');
    premium = dataBox.get('premium');
    hasTrainer = dataBox.get('hasTrainer');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          centerTitle: true,
          title: Text("Your Trainers Exercises",
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
          elevation: 0.0,
        ),
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  premium == true
                      ? (hasTrainer == true)
                          ? FutureBuilder<DocumentSnapshot<Object?>>(
                              future: ExerciseService(docID: user!.uid).list,
                              builder: ((context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView.builder(
                                        //shrinkWrap: true,

                                        itemCount: 7,
                                        itemBuilder: (context, listindex) {
                                          return GestureDetector(
                                            onTap: () => {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          Trainerexercisedaydetail(
                                                            dayindex:
                                                                listindex + 1,
                                                            docId: user!.uid,
                                                          ))),
                                            },
                                            child: Card(
                                              margin: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 10,
                                                  bottom: 10),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              elevation: 10.0,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "Day ${listindex + 1}",
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  226,
                                                                  226,
                                                                  226),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                }
                                if (snapshot.data == []) {
                                  const Text(
                                      "Maybe Trainer has not created your plan",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 190, 227, 57)));
                                } else {
                                  const Text("Error while loading data",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 190, 227, 57)));
                                }
                                return const CircularProgressIndicator();
                              }),
                            )
                          : const Center(
                              child: Text(
                                  "Appoint trainer to Get Trainers Plan",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 190, 227, 57))))
                      : const Center(
                          child: Text("Need Premium to Get Trainers Plan",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 190, 227, 57))))
                ],
              ),
            ),
          ),
        ));
  }
}
