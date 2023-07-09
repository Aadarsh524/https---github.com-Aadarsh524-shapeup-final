import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/trainer/trainerplans/customworkout.dart';
import 'package:shapeup/screens/trainer/trainerplans/dayListCustom.dart';

import '../../../models/exercise/exercise_detail_model.dart';
import '../../../services/exercise/exercise_service.dart';

class AddExercise extends StatefulWidget {
  final String dayIndex;
  final String planUid;
  const AddExercise({super.key, required this.dayIndex, required this.planUid});

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  @override
  void initState() {
    // TODO: implement initState

    print(widget.dayIndex);
    super.initState();
  }

  Future<void> deleteExercise(ExerciseDetailModel exercise) async {
    try {
      SnackBar snackBar = SnackBar(
        padding: const EdgeInsets.all(20),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
        content: Text(
          "Exercise deleted successfully",
          style: GoogleFonts.montserrat(
            height: .5,
            letterSpacing: 0.5,
            fontSize: 12,
            color: Colors.red,
          ),
        ),
      );
      await FirebaseFirestore.instance
          .collection('exercises')
          .doc(widget.planUid)
          .collection('day${widget.dayIndex}')
          .doc(exercise.id)
          .delete()
          .then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(snackBar));
      setState(() {
        // Refresh the page by triggering a rebuild
      });
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
                      builder: (context) => DayListCustom(
                            planUid: widget.planUid,
                          )));
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
                  .customExerciseInfo(widget.planUid, widget.dayIndex),
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
                        builder: (context) => UpdateWork(
                              dayIndex: widget.dayIndex,
                              planUid: widget.planUid,
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
