
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shapeup/screens/trainer/trainerplans/customworkout.dart';
import 'package:shapeup/screens/trainer/trainerplans/dayListCustom.dart';

import '../../../models/exercise_detail_model.dart';
import '../../../services/exerciseService.dart';

class AddExercise extends StatefulWidget {
  final String dayIndex;
  const AddExercise({super.key, required this.dayIndex});

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  late Box dataBox;
  late String planUid;
  @override
  @override
  void initState() {
    // TODO: implement initState
    dataBox = Hive.box('storage');
    planUid = dataBox.get('planName');
    print(widget.dayIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DayListCustom()));
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
                  .customExerciseInfo(planUid, widget.dayIndex),
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
                        );
                      });
                } else {
                  return Text('sikanmsdjkabd');
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
