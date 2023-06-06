import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/trainer/trainerscreen/traineesprofile.dart';
import 'package:shapeup/screens/trainer/trainerscreen/trainerprofile.dart';
import 'package:shapeup/services/traineeprofileservice.dart';

import '../../../models/trainee_profile_model.dart';
import '../../../models/trainer_profile_model.dart';
import '../../../services/trainerprofileservice.dart';

class HomePageT extends StatefulWidget {
  const HomePageT({Key? key}) : super(key: key);

  @override
  State<HomePageT> createState() => _HomePageTState();
}

class _HomePageTState extends State<HomePageT> {
  User? trainerId = FirebaseAuth.instance.currentUser;
  String? week;
  String? day;
  String? month;
  DateTime date = DateTime.now();

  @override
  void initState() {
    setState(() {
      week = DateFormat('EEEE').format(date);
      day = DateFormat('d').format(date);
      month = DateFormat('MMMM').format(date);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //collection reference for users
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        child: InkWell(
                          onTap: () {
                            // Get.to(() => const TrainerProfile(),
                            //     transition: Transition.circularReveal,
                            //     duration: const Duration(seconds: 1));
                          },
                          child: IconButton(
                            color: const Color.fromARGB(255, 190, 227, 57),
                            iconSize: 24,
                            padding: const EdgeInsets.all(0),
                            icon: const Icon(Icons.person_outlined),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TrainerProfile()));
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hey, Bibash", //firebase trainer name
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  color: Color.fromARGB(255, 190, 227, 57),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 3,
                          ),
                          Text("$week, $day $month",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 20, 30, 10),
                  child: Text(
                    'Trainees List',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Color.fromARGB(255, 190, 227, 57),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: FutureBuilder<TrainerProfileModel?>(
                      future: TrainerProfileService()
                          .trainerProfile(trainerId!.uid),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text("Something went wrong"));
                        }

                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData &&
                            snapshot.data != null) {
                          final trainerProfile = snapshot.data!;

                          final trainerClients = trainerProfile.clients;

                          List<String> clients =
                              new List<String>.from(trainerClients);
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: clients.length,
                              itemBuilder: (BuildContext context, int index) {
                                final traineeId = clients[index];

                                return FutureBuilder<TraineeProfileModel?>(
                                  future: TraineeProfileService()
                                      .traineeProfile(traineeId),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      final traineeData = snapshot.data!;
                                      final traineeName = traineeData.firstName;
                                      final userImage = traineeData.userImage;
                                      final lastName = traineeData.lastName;

                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  duration: const Duration(
                                                      milliseconds: 250),
                                                  child: TraineeProfile(
                                                    docId: traineeData.id,
                                                  )));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 85,
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Card(
                                            elevation: 5,
                                            color: const Color.fromARGB(
                                                255, 114, 97, 89),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                    width: 60,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                      child: Image.network(
                                                          height: 65,
                                                          width: 65,
                                                          fit: BoxFit.contain,
                                                          userImage),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 25,
                                                  ),
                                                  SizedBox(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                            "${traineeName} ${lastName}",
                                                            style: GoogleFonts.montserrat(
                                                                letterSpacing:
                                                                    .5,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Text('No clients');
                                    } else {
                                      return ListTile(
                                        title: Text('Loading...'),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error loading trainer'),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
