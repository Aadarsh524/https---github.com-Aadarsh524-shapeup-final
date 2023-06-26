import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/trainer/trainerplans/exercises.dart';

import 'package:shapeup/screens/trainer/trainerscreen/workoutplan.dart';

import '../../../models/day_model.dart';

class DayListCustom extends StatefulWidget {
  const DayListCustom({Key? key}) : super(key: key);

  @override
  State<DayListCustom> createState() => _DayListCustomState();
}

class _DayListCustomState extends State<DayListCustom> {
  List<String> days = ['1', '2', '3', '4', '5', '6', '7'];
  void handleDayTap(String day) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddExercise(
                  dayIndex: day,
                )));
    print(day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WorkoutPlan()));
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
      )),
    );
  }
}
