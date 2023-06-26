import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shapeup/models/exercise_detail_model.dart';
import 'package:shapeup/screens/trainer/trainerplans/exercises.dart';
import 'package:shapeup/screens/trainer/trainerplans/planName.dart';
import 'package:shapeup/services/exerciseService.dart';

class UpdateWork extends StatefulWidget {
  final String dayIndex;

  const UpdateWork({Key? key, required this.dayIndex}) : super(key: key);

  @override
  State<UpdateWork> createState() => _UpdateWorkState();
}

class _UpdateWorkState extends State<UpdateWork> {
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
    planName = dataBox.get('planName');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
          title: Text('Update Workout',
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // DropdownButtonFormField(
                //     decoration: InputDecoration(labelText: 'Day'),
                //     dropdownColor: const Color.fromARGB(255, 114, 97, 89),
                //     value: _selectedVal,
                //     items: _days.map((e) {
                //       return DropdownMenuItem(
                //         child: Text(e),
                //         value: e,
                //       );
                //     }).toList(),
                //     onChanged: (val) {
                //       setState(() {
                //         _selectedVal = val as String;
                //       });
                //     }),
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
                          print('Counter: ${selected.counter}');
                        },
                      );
                    } else {
                      return Text('Something went wrong');
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
                        Text(
                          selectedExerciseModel!.description,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 12, left: 5, right: 5),
                          padding: EdgeInsets.only(
                              left: 14, right: 7, top: 7, bottom: 7),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: .5,
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
                    : Container(),

                //this is for drop down menu of widgets

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
              onPressed: () async {
                FirebaseFirestore.instance
                    .collection('exercises')
                    .doc(planName)
                    .collection('day${widget.dayIndex}')
                    .add({
                  'name': selectedExerciseModel!.name,
                  'duration': selectedValue,
                  'description': selectedExerciseModel!.description,
                  'counter': selectedExerciseModel!.counter,
                  'gif': selectedExerciseModel!.gif,
                }).then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddExercise(dayIndex: widget.dayIndex,))));
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