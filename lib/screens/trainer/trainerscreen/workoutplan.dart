import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/components/exercise_card.dart';
import 'package:shapeup/models/custom_exercise_model.dart';
import 'package:shapeup/models/exercise_model.dart';
import 'package:shapeup/screens/trainer/trainerplans/planName.dart';
import 'package:shapeup/screens/trainer/trainerplans/dayListCustom.dart';
import 'package:shapeup/services/exerciseService.dart';

import '../../../components/customPlanCard.dart';

class WorkoutPlan extends StatefulWidget {
  const WorkoutPlan({super.key});

  @override
  State<WorkoutPlan> createState() => _WorkoutPlanState();
}

class _WorkoutPlanState extends State<WorkoutPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
          title: Text("Your Plans",
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                FutureBuilder<List<CustomExerciseModel>>(
                    future: ExerciseService().customPlanList,
                    builder: ((context, snapshot){
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount:snapshot.data!.length, 
                            itemBuilder: (context, index) {
                              return CustomPlanCard(
                                  customPlanmodel: snapshot.data![index]);
                            });
                      }else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }
                    })),
                Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: ElevatedButton.icon(
                    label: Text(
                      'Create plan',
                      style: GoogleFonts.notoSansMono(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      // padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlanName()));
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
