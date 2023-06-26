import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/trainer/trainerscreen/chatRoomScreen.dart';
import 'package:shapeup/screens/trainer/trainerplans/customworkout.dart';
import 'package:shapeup/screens/trainer/trainerplans/dayListCustom.dart';
import 'package:shapeup/screens/trainer/userSpecificWorkout/dayList.dart';
import 'package:shapeup/screens/user/userDashboard/dashboardscreen.dart';

import '../../../models/trainee_profile_model.dart';
import '../../../models/trainer_profile_model.dart';
import '../../../services/traineeprofileservice.dart';
import '../../../services/trainerprofileservice.dart';

class TraineeProfile extends StatefulWidget {
  final String docId;

  TraineeProfile({
    Key? key,
    required this.docId,
  }) : super(key: key);

  @override
  State<TraineeProfile> createState() => _TraineeProfileState();
}

class _TraineeProfileState extends State<TraineeProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  late final Box dataBox;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('storage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 28, 28, 30),
          elevation: 0,
          toolbarHeight: 60,
          title: Text("Trainee Profile",
              style: GoogleFonts.montserrat(
                  letterSpacing: .5,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
          leading: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 114, 97, 89),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: IconButton(
                    color: Colors.black,
                    iconSize: 12,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        // ignore: sized_box_for_whitespace
        body: SafeArea(
          child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 10),
                  child: FutureBuilder<TraineeProfileModel?>(
                    future:
                        TraineeProfileService().traineeProfile(widget.docId),
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

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 3,
                                        color: const Color.fromARGB(
                                            255, 190, 227, 57),
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: Image.network(
                                          traineeProfile.userImage,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.account_circle_sharp,
                                        size: 20,
                                        color:
                                            Color.fromARGB(255, 166, 181, 106),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "${traineeProfile.firstName} ${traineeProfile.lastName}",
                                        style: GoogleFonts.montserrat(
                                          letterSpacing: .5,
                                          color: const Color.fromARGB(
                                              255, 166, 181, 106),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.email_outlined,
                                        size: 20,
                                        color:
                                            Color.fromRGBO(142, 153, 183, 0.5),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        traineeProfile.email,
                                        style: GoogleFonts.montserrat(
                                          letterSpacing: 0,
                                          color: const Color.fromRGBO(
                                              142, 153, 183, 0.5),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        size: 20,
                                        color:
                                            Color.fromRGBO(142, 153, 183, 0.5),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        traineeProfile.phone,
                                        style: GoogleFonts.montserrat(
                                          letterSpacing: 0,
                                          color: const Color.fromRGBO(
                                              142, 153, 183, 0.5),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      traineeProfile.gender == "male"
                                          ? const Icon(
                                              MdiIcons.genderMale,
                                              size: 20,
                                              color: Color.fromRGBO(
                                                  142, 153, 183, 0.5),
                                            )
                                          : const Icon(
                                              MdiIcons.genderFemale,
                                              size: 20,
                                              color: Color.fromRGBO(
                                                  142, 153, 183, 0.5),
                                            ),
                                      const SizedBox(width: 10),
                                      Text(
                                        traineeProfile.gender,
                                        style: GoogleFonts.montserrat(
                                          letterSpacing: 0,
                                          color: const Color.fromRGBO(
                                              142, 153, 183, 0.5),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Center(
                                    child: Text(
                                      'Personal Information',
                                      style: GoogleFonts.montserrat(
                                        letterSpacing: 0,
                                        color: const Color.fromARGB(
                                            255, 114, 97, 89),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Card(
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
                                              "Age:",
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              traineeProfile.age,
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
                                              "BMI:",
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              traineeProfile.bmi,
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
                                              "Height:",
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              traineeProfile.height,
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
                                              "Weight:",
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              traineeProfile.weight,
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
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatRoomScreen()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor:
                                                const Color.fromARGB(
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
                                              "Chat",
                                              style: GoogleFonts.notoSansMono(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DaysList(
                                                          uid:
                                                              traineeProfile.id,
                                                        )));
                                            print(traineeProfile.id);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor:
                                                const Color.fromARGB(
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
                                              "Update Workout",
                                              style: GoogleFonts.notoSansMono(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        // If no data is available, show a message
                        return const Center(child: Text("Loading"));
                      }
                    },
                  ))),
        ));
  }
}
