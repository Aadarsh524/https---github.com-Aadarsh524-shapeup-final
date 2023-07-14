import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../../components/trainerPlanCard.dart';
import '../../../models/exercise/custom_exercise_model.dart';
import '../../../models/profile/trainee_profile_model.dart';
import '../../../services/exercise/exercise_service.dart';
import '../../../services/profile/trainee_profile_service.dart';
import '../../../services/profile/trainee_profile_service.dart';
import '../exercise/premiumPlansScreen.dart';
import '../exercise/purchasedPlanDetailScreen.dart';

class TrainersPlansList extends StatefulWidget {
  final String trainerId;

  TrainersPlansList({Key? key, required this.trainerId}) : super(key: key);

  @override
  State<TrainersPlansList> createState() => _TrainersPlansListState();
}

class _TrainersPlansListState extends State<TrainersPlansList> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
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

              Padding(
                padding: const EdgeInsets.fromLTRB(35, 10, 30, 10),
                child: Text(
                  'Premium',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Color.fromARGB(255, 190, 227, 57),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FutureBuilder<List<CustomExerciseModel>>(
                future: ExerciseService().customExerciseList,
                builder: (context, exerciseSnapshot) {
                  if (exerciseSnapshot.hasData) {
                    return FutureBuilder<TraineeProfileModel?>(
                      future: TraineeProfileService().traineeProfile(user!.uid),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Something went wrong"),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text("No trainee profile found."),
                          );
                        }

                        final traineeProfile = snapshot.data!;
                        final purchasedPlans = traineeProfile.purchasedPlans;

                        final filteredExercises = exerciseSnapshot.data!
                            .where((exercise) =>
                                !purchasedPlans.contains(exercise.planName))
                            .toList();

                        if (filteredExercises.isEmpty) {
                          return const Center(
                            child: Text("No available exercises."),
                          );
                        }

                        return ListView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable inner list scrolling
                          shrinkWrap: true,
                          itemCount: filteredExercises.length,
                          itemBuilder: (context, index) {
                            return PremiumCardDetailExerciseCard(
                              customPlanmodel: filteredExercises[index],
                            );
                          },
                        );
                      },
                    );
                  } else if (exerciseSnapshot.hasError) {
                    return const Center(
                      child: Text("Failed to fetch exercises."),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(35, 10, 30, 10),
                child: Text(
                  'Purchased',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Color.fromARGB(255, 190, 227, 57),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FutureBuilder<TraineeProfileModel?>(
                future: TraineeProfileService().traineeProfile(user!.uid),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data != null) {
                    final traineeProfile = snapshot.data!;

                    final plans = traineeProfile.purchasedPlans;

                    List<String> plan = List<String>.from(plans);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                              plan.length,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            PurchasedPlanDetailScreen(
                                          id: plan[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 1,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    color:
                                        const Color.fromARGB(255, 114, 97, 89),
                                    child: SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "PlanName:",
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              plan[index],
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.montserrat(
                                                letterSpacing: .5,
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // If no data is available, show a message
                    return const Center(child: Text("Loading"));
                  }
                },
              )
              //trainer Plans List
              // FutureBuilder<List<CustomExerciseModel>>(
              //     future: ExerciseService().trainerPlanList(widget.trainerId),
              //     builder: ((context, snapshot) {
              //       if (snapshot.hasData) {
              //         print(snapshot);
              //         return ListView.builder(
              //             shrinkWrap: true,
              //             itemCount: snapshot.data!.length,
              //             itemBuilder: (context, index) {
              //               return PremiumCardDetailExerciseCard(
              //                 customPlanmodel: snapshot.data![index],
              //               );
              //             });
              //       } else {
              //         return const Center(
              //             child: CircularProgressIndicator(
              //           color: Colors.white,
              //         ));
              //       }
              //     })),
            ],
          ),
        ),
      )),
    );
  }
}
