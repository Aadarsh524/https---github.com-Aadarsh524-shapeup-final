import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/user/exercise/purchasedExerciseDayList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/exercise/exercise_model.dart';
import '../../../models/profile/trainee_profile_model.dart';
import '../../../services/exercise/exercise_service.dart';
import '../../../services/profile/trainee_profile_service.dart';
import 'exercisedaydetail.dart';

class PurchasedPlanScreen extends StatefulWidget {
  const PurchasedPlanScreen({Key? key}) : super(key: key);

  @override
  State<PurchasedPlanScreen> createState() => _PurchasedPlanScreenState();
}

class _PurchasedPlanScreenState extends State<PurchasedPlanScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  bool? premium;
  Future asyncFunc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      premium = prefs.getBool("premium");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),

                  FutureBuilder<TraineeProfileModel?>(
                    future: TraineeProfileService().traineeProfile(user!.uid),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text("Something went wrong"));
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

                        String planName = plan.join(', ');
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    PurchasedExerciseDayList(
                                                        docId: planName)));
                                      },
                                      child: Card(
                                        elevation: 1,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        color: const Color.fromARGB(
                                            255, 114, 97, 89),
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                  planName,
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
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        // If no data is available, show a message
                        return const Center(child: Text("Loading"));
                      }
                    },
                  )
                  // FutureBuilder<TraineeProfileModel?>(
                  //     future: TraineeProfileService().traineeProfile(user!.uid),
                  //     builder: (BuildContext context, snapshot) {
                  //       if (snapshot.hasError) {
                  //         return const Center(
                  //             child: Text("Something went wrong"));
                  //       }

                  //       if (!snapshot.hasData) {
                  //         return const Center(
                  //             child: CircularProgressIndicator());
                  //       }
                  //       if (snapshot.connectionState == ConnectionState.done &&
                  //           snapshot.hasData &&
                  //           snapshot.data != null) {
                  //         final traineeProfile = snapshot.data!;

                  //         return ListView.builder(
                  //           itemCount: 2,
                  //           itemBuilder: (context, index) {
                  //             return CustomExerciseCard(
                  //               customPlanmodel:
                  //                   traineeProfile.purchasedPlans[index],
                  //             );
                  //           },
                  //         );

                  //         // FutureBuilder<List<CustomExerciseModel>>(
                  //         //   future: ExerciseService().getPurchasedPlanIDs(
                  //         //       traineeProfile.purchasedPlans as String),
                  //         //   builder: (context, snapshot) {
                  //         //     if (snapshot.hasData) {
                  //         //       print(snapshot);
                  //         //       return ListView.builder(
                  //         //         physics:
                  //         //             NeverScrollableScrollPhysics(), // Disable inner list scrolling
                  //         //         shrinkWrap: true,
                  //         //         itemCount: snapshot.data!.length,
                  //         //         itemBuilder: (context, index) {
                  //         //           return CustomExerciseCard(
                  //         //             customPlanmodel: snapshot.data![index],
                  //         //           );
                  //         //         },
                  //         //       );
                  //         //     } else {
                  //         //       return const Center(
                  //         //         child: CircularProgressIndicator(
                  //         //           color: Colors.white,
                  //         //         ),
                  //         //       );
                  //         //     }
                  //         //   },
                  //         // );
                  //       }
                  //       return Text("No data");
                  //     })
                ],
              ),
            ),
          ),
        ));
  }
}
