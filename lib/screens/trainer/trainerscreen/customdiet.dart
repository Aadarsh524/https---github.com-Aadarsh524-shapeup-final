import 'package:flutter/material.dart';

class UpdateDietPlan extends StatefulWidget {
  const UpdateDietPlan({Key? key}) : super(key: key);

  @override
  State<UpdateDietPlan> createState() => _UpdateDietPlanState();
}

class _UpdateDietPlanState extends State<UpdateDietPlan> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text('List of trainees')),
    );
  }
}
