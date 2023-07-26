import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shapeup/models/exercise/exercise_detail_model.dart';

import '../../../services/exercise/exercise_service.dart';
import 'addUserExercise.dart';

class AddWorkout extends StatefulWidget {
  final String dayIndex;
  final String uid;
  const AddWorkout({Key? key, required this.dayIndex, required this.uid})
      : super(key: key);

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  //variables

  var _counterValueController = TextEditingController();

  ExerciseDetailModel? selectedExerciseModel;
  bool? selectedValue;
  int _val = 1;
  late Box dataBox;
  late String planName;
  @override
  void initState() {
    // TODO: implement initState
    dataBox = Hive.box('storage');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
          title: Text('Add Workout',
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddUserExercise(
                            uid: widget.uid,
                            dayIndex: widget.dayIndex,
                          )));
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                FutureBuilder<List<ExerciseDetailModel>>(
                  future: ExerciseService().allExercises,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ExerciseDetailModel>? allExercises = snapshot.data;
                      return TypeAheadField<ExerciseDetailModel>(
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 39, 48, 81),
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintText: "Select Exercise",
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 39, 48, 81),
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIcon: const Icon(
                              Icons.run_circle_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          // Filter the exercise list based on the user's input pattern
                          return allExercises!
                              .where((exercise) => exercise.name
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                              .toList();
                        },
                        itemBuilder: (context, ExerciseDetailModel selected) {
                          return ListTile(
                            leading: Image.network(
                              selected.gif,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(selected.name),
                          );
                        },
                        onSuggestionSelected: (ExerciseDetailModel selected) {
                          setState(() {
                            selectedExerciseModel = selected;
                            _counterValueController.text =
                                selectedExerciseModel!.counter.toString();
                            // ignore: unrelated_type_equality_checks
                            if (selectedExerciseModel!.duration == 'true') {
                              selectedValue = true;
                            } else {
                              selectedValue = false;
                            }

                            print(selectedExerciseModel!.duration);
                            print(selectedValue);
                          });

                          // Handle the selection of an exercise
                          // You can access the selected exercise properties (name, description, gif, duration, counter) from the suggestion object
                          print('Selected Exercise: ${selected.name}');
                          print('Description: ${selected.description}');
                          print('GIF URL: ${selected.gif}');
                          print('Duration: ${selected.duration}');
                          print('Counter:${_counterValueController}');
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                selectedExerciseModel != null
                    ? Column(children: [
                        Image.network(
                          selectedExerciseModel!.gif,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          selectedExerciseModel!.name,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 12, left: 5, right: 5),
                          padding: EdgeInsets.only(
                              left: 14, right: 7, top: 7, bottom: 7),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: .5,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            selectedExerciseModel!.description,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 12, left: 5, right: 5),
                          padding: EdgeInsets.only(
                              left: 14, right: 7, top: 7, bottom: 7),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: .5,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Duration',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Radio(
                                  value: true,
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue == value!;
                                    });
                                  }),
                              SizedBox(
                                child: Text(
                                  'True',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Radio(
                                  value: false,
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue == value!;
                                    });
                                  }),
                              SizedBox(
                                child: Text(
                                  'False',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 12, left: 5, right: 5),
                          child: SizedBox(
                              child: TextFormField(
                            cursorColor: Colors.white,
                            onChanged: (val) {},
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                            controller: _counterValueController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "Counter Value",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 48, 81),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.numbers,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          )),
                        ),
                      ])
                    : CircularProgressIndicator(),

                //this is for drop down menu of widgets

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
              onPressed: () async {
                FirebaseFirestore.instance
                    .collection('userSpecific')
                    .doc(widget.uid)
                    .collection('day${widget.dayIndex}')
                    .add({
                  'name': selectedExerciseModel!.name,
                  'duration': selectedValue,
                  'description': selectedExerciseModel!.description,
                  'counter': _counterValueController.text,
                  'gif': selectedExerciseModel!.gif,
                }).then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddUserExercise(
                                  dayIndex: widget.dayIndex,
                                  uid: widget.uid,
                                ))));
                ;
                print(_counterValueController.text);
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
                    Text(
                      'Add Workout',
                      style: GoogleFonts.notoSansMono(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )),
        ));
  }
}
