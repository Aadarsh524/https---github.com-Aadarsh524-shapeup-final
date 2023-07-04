import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shapeup/screens/trainer/trainerplans/customworkout.dart';
import 'package:shapeup/screens/trainer/trainerplans/dayListCustom.dart';
import 'package:shapeup/screens/trainer/userSpecificWorkout/addWorkout.dart';

import '../../../models/exercise_detail_model.dart';
import '../../../services/exerciseService.dart';
import 'dayList.dart';

class AddUserExercise extends StatefulWidget {
  final String dayIndex;

  final String uid;
  const AddUserExercise({super.key, required this.dayIndex, required this.uid});

  @override
  State<AddUserExercise> createState() => _AddUserExerciseState();
}

class _AddUserExerciseState extends State<AddUserExercise> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  Future<void> deleteExercise(ExerciseDetailModel exercise) async {
    try {
      await FirebaseFirestore.instance
          .collection('exercises')
          .doc(exercise.id)
          .delete();
      print('Exercise deleted successfully');
      print(exercise.id);
    } catch (error) {
      print('Error deleting exercise: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DaysList(uid: widget.uid)));
            },
          ),
          title: Text('Add Exercises',
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600)),
          elevation: 0,
        ),
        body: SafeArea(
          child: FutureBuilder<List<ExerciseDetailModel>>(
              future: ExerciseService()
                  .userSpecificExerciseInfo(widget.uid, widget.dayIndex),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ExerciseDetailModel>? allExercises = snapshot.data;

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: allExercises!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                            allExercises[index].gif,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(allExercises[index].name),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteExercise(allExercises[index]);
                            },
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddWorkout(
                              dayIndex: widget.dayIndex,
                              uid: widget.uid,
                            )));
              },
              backgroundColor: const Color.fromARGB(
                255,
                208,
                253,
                62,
              ),
              label: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      size: 24,
                      Icons.add,
                      color: Colors.black,
                    )
                  ],
                ),
              )),
        ));
  }
}
