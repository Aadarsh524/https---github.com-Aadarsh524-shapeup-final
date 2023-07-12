import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../../components/trainerPlanCard.dart';
import '../../../models/exercise/custom_exercise_model.dart';
import '../../../services/exercise/exercise_service.dart';

class TrainersPlansList extends StatefulWidget {
  final String trainerId;

  TrainersPlansList({Key? key, required this.trainerId}) : super(key: key);

  @override
  State<TrainersPlansList> createState() => _TrainersPlansListState();
}

class _TrainersPlansListState extends State<TrainersPlansList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 10, 30, 10),
            child: Text(
              'This Trainer Plans',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Color.fromARGB(255, 190, 227, 57),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          //trainer Plans List
          FutureBuilder<List<CustomExerciseModel>>(
              future: ExerciseService().trainerPlanList(widget.trainerId),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot);
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return TrainerPlanCard(
                          customPlanmodel: snapshot.data![index],
                        );
                      });
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                }
              })),
        ],
      )),
    );
  }
}
