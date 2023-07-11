import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/trainer/trainerscreen/traineesprofile.dart';
import 'package:shapeup/screens/trainer/userSpecificWorkout/addUserExercise.dart';
import 'package:shapeup/screens/trainer/userSpecificWorkout/addWorkout.dart';

import '../../../models/diet/day_model.dart';

class DaysList extends StatefulWidget {
  final String uid;

  const DaysList({super.key, required this.uid});

  @override
  State<DaysList> createState() => _DaysListState();
}

class _DaysListState extends State<DaysList> {
  final List<String> days = ['1', '2', '3', '4', '5', '6', '7'];
  void handleDayTap(String day) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddUserExercise(
                  dayIndex: day,
                  uid: widget.uid,
                )));
    print(day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TraineeProfile(
                            docId: widget.uid,
                          )));
            },
          ),
          title: Text('Days',
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
        ),
        body: SafeArea(
            child: DayCard(
          days: days,
          onTap: handleDayTap,
        )));
  }
}
