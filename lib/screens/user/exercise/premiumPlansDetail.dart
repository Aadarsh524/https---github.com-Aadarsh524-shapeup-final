import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/user/premium/trainerprofile.dart';
import 'package:shapeup/screens/user/dashboard/dashboardscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/exercise/custom_exercise_model.dart';
import '../../../models/profile/trainer_profile_model.dart';
import '../../../services/exercise/exercise_service.dart';
import '../../../services/profile/trainer_profile_service.dart';

class PremiumPlanDetailScreen extends StatefulWidget {
  final CustomExerciseModel exercisemodel;
  const PremiumPlanDetailScreen({Key? key, required this.exercisemodel})
      : super(key: key);

  @override
  State<PremiumPlanDetailScreen> createState() =>
      _PremiumPlanDetailScreenState();
}

class _PremiumPlanDetailScreenState extends State<PremiumPlanDetailScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  bool? premium;

  Future<void> asyncFunc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      premium = prefs.getBool("premium");
    });
  }

  @override
  void initState() {
    super.initState();
    asyncFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: Text(
          "Plan Details",
          style: GoogleFonts.montserrat(
            letterSpacing: .5,
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 10,
              ),
              child: FutureBuilder<CustomExerciseModel?>(
                future: ExerciseService().premiumPlans(widget.exercisemodel.id),
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
                    final exerciseModel = snapshot.data!;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Card(
                                elevation: 1,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                color: const Color.fromARGB(255, 114, 97, 89),
                                child: FutureBuilder<TrainerProfileModel?>(
                                  future: TrainerProfileService()
                                      .trainerProfile(exerciseModel.createBy),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasError) {
                                      return const Center(
                                          child:
                                              Text("Something went wrong ..."));
                                    }

                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData &&
                                        snapshot.data != null) {
                                      final trainerProfile = snapshot.data!;

                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                const SizedBox(height: 15),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Created By:",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${trainerProfile.firstName}${trainerProfile.lastName}",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          letterSpacing: .5,
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Center(
                                                  child: SizedBox(
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                type:
                                                                    PageTransitionType
                                                                        .fade,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            250),
                                                                child:
                                                                    TrainerProfile(
                                                                  docId:
                                                                      trainerProfile
                                                                          .id,
                                                                )));
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        elevation: 0,
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                214,
                                                                243,
                                                                155),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 14),
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 24,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 1,
                                                          bottom: 1,
                                                        ),
                                                        child: Text(
                                                          "View Profile",
                                                          style: GoogleFonts
                                                              .notoSansMono(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return Text("No data");
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),
                              Card(
                                elevation: 1,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                color: const Color.fromARGB(255, 114, 97, 89),
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
                                          "Plan Name:",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          exerciseModel.planName,
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
                              const SizedBox(height: 8),
                              Card(
                                elevation: 1,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                color: const Color.fromARGB(255, 114, 97, 89),
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
                                          "Description:",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          exerciseModel.description,
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
                              const SizedBox(height: 8),
                              Card(
                                elevation: 1,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                color: const Color.fromARGB(255, 114, 97, 89),
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
                                          "Level:",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          exerciseModel.level,
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
                              const SizedBox(height: 8),
                              Card(
                                elevation: 1,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                color: const Color.fromARGB(255, 114, 97, 89),
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
                                          "Duration:",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          exerciseModel.exerciseDuration,
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
                              const SizedBox(height: 8),
                              Card(
                                elevation: 1,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                color: const Color.fromARGB(255, 114, 97, 89),
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
                                          "Plan Cost:",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Rs.99",
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
                              const SizedBox(height: 8),
                              Center(
                                child: SizedBox(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      KhaltiScope.of(context).pay(
                                        config: PaymentConfig(
                                          amount: 99 * 100,
                                          productIdentity:
                                              'dells-sssssg5-g5510-2021',
                                          productName: 'Product Name',
                                        ),
                                        preferences: [
                                          PaymentPreference.khalti,
                                        ],
                                        onSuccess: (su) async => {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user?.uid)
                                              .update({
                                                'purchasedPlans':
                                                    FieldValue.arrayUnion(
                                                        [exerciseModel.id])
                                              })
                                              .then((value) => Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      child:
                                                          const DashBoardScreen(
                                                        selectedIndex: 0,
                                                      ))))
                                              .then((value) => Future(() {
                                                    SnackBar successsnackBar =
                                                        SnackBar(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      backgroundColor:
                                                          Colors.white,
                                                      duration: const Duration(
                                                          seconds: 2),
                                                      content: Text(
                                                        "Payment Success",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          height: .5,
                                                          letterSpacing: 0.5,
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            successsnackBar);
                                                  }))
                                        },
                                        onFailure: (fa) {
                                          SnackBar failedSnackBar = SnackBar(
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor: Colors.white,
                                            duration:
                                                const Duration(seconds: 2),
                                            content: Text(
                                              "Payment Failed",
                                              style: GoogleFonts.montserrat(
                                                height: .5,
                                                letterSpacing: 0.5,
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(failedSnackBar);
                                        },
                                        onCancel: () {
                                          SnackBar cancelledSnackBar = SnackBar(
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor: Colors.white,
                                            duration:
                                                const Duration(seconds: 2),
                                            content: Text(
                                              "Payment Failed",
                                              style: GoogleFonts.montserrat(
                                                height: .5,
                                                letterSpacing: 0.5,
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(cancelledSnackBar);
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: const Color.fromARGB(
                                          255, 190, 227, 57),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      textStyle: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 1,
                                        bottom: 1,
                                      ),
                                      child: Text(
                                        "Buy Plan",
                                        style: GoogleFonts.notoSansMono(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox(); // Return an empty widget if none of the conditions are met.
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
