import 'package:flutter/material.dart';
import 'package:shapeup/screens/trainer/userSpecificWorkout/addWorkout.dart';

import '../../../models/day_model.dart';

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
            builder: (context) => AddWorkout(
                  dayIndex: day,
                  uid: widget.uid,
                )));
    print(day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: DayCard(
      days: days,
      onTap: handleDayTap,
    )));
  }
}
