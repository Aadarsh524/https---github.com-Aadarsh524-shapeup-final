import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:shapeup/screens/trainer/trainerplans/dayListCustom.dart';

class PlanName extends StatefulWidget {
  const PlanName({super.key});

  @override
  State<PlanName> createState() => _PlanNameState();
}

class _PlanNameState extends State<PlanName> {
  String? planName;
  late Box dataBox;
  String? planUid;

  String? _selectedLevel;
  Color _borderColor = Colors.white;
  final _planNameController = TextEditingController();
  final _newDescController = TextEditingController();
  final _timeController = TextEditingController();
  final _moneyController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference exercise =
      FirebaseFirestore.instance.collection('exercise');

  @override
  void initState() {
    dataBox = Hive.box('storage');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 28, 30, 30),
          title: Text('Your details',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
                  child: TextField(
                    cursorColor: Colors.white,
                    onChanged: (val) {},
                    keyboardType: TextInputType.name,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    controller: _planNameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Please enter your plan name",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      prefixIcon: const Icon(
                        Icons.run_circle_sharp,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //trainee level
                Container(
                  margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
                  child: DropdownButtonFormField<String?>(
                    value: _selectedLevel,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Select Trainee Level",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      prefixIcon: const Icon(
                        Icons.sports_gymnastics_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLevel = newValue;
                        _borderColor = Colors.white;
                      });
                    },
                    items: <String?>['Beginner', 'Intermediate', 'Advanced']
                        .map<DropdownMenuItem<String?>>((String? value) {
                      return DropdownMenuItem<String?>(
                        value: value,
                        child: Text(
                          value ?? '',
                          style: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 190, 227, 57)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
                  child: TextField(
                    cursorColor: Colors.white,
                    onChanged: (val) {},
                    keyboardType: TextInputType.multiline,
                    maxLines: null, // or specify a higher value if needed
                    textInputAction: TextInputAction.newline,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    controller: _newDescController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Must include age group",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      prefixIcon: const Icon(
                        Icons.description,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    controller: _timeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Exercise Duration(in minutes)",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      prefixIcon: const Icon(
                        Icons.watch_later_sharp,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    controller: _moneyController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Plan price",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 39, 48, 81),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      prefixIcon: const Icon(
                        Icons.monetization_on,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
              onPressed: () async {
                int x = int.parse(_moneyController.text);
                print(x);
                if (_planNameController.text != '' &&
                    _newDescController.text != '' &&
                    _timeController.text != '' &&
                    _selectedLevel != null &&
                    _moneyController.text != '' &&
                    x <= 200) {
                  // await dataBox.put('planName', _planNameController.text);
                  // await dataBox.put('planUid', exercise.doc().id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DayListCustom(
                                planUid: _planNameController.text,
                              )));
                  FirebaseFirestore.instance
                      .collection('exercises')
                      .doc(_planNameController.text)
                      .set({
                    "planName": _planNameController.text,
                    "level": _selectedLevel,
                    "description": _newDescController.text,
                    "exerciseDuration": _timeController.text,
                    "createBy": user!.uid,
                    "planUid": exercise.doc().id,
                    "planPrice": _moneyController.text,
                  });
                } else {
                  SnackBar snackBar = SnackBar(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    duration: const Duration(seconds: 2),
                    content: Text(
                      "Field can't be empty.",
                      style: GoogleFonts.montserrat(
                        height: .5,
                        letterSpacing: 0.5,
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
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
                      'Next',
                      style: GoogleFonts.notoSansMono(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      size: 24,
                      Icons.arrow_right,
                      color: Colors.black,
                    )
                  ],
                ),
              )),
        ));
  }
}
