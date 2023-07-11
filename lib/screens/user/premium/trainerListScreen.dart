import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/models/profile/trainer_profile_model.dart';
import 'package:shapeup/screens/user/premium/trainerProfile.dart';
import 'package:shapeup/services/profile/trainer_profile_service.dart';

class TrainerListScreen extends StatefulWidget {
  const TrainerListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TrainerListScreen> createState() => _TrainerListScreenState();
}

class _TrainerListScreenState extends State<TrainerListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        body: Scaffold(
            backgroundColor: Color.fromARGB(255, 28, 28, 30),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text("TrainerList",
                  style: GoogleFonts.montserrat(
                      letterSpacing: .5,
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600)),
              backgroundColor: Color.fromARGB(255, 28, 28, 30),
              elevation: 0.0,
            ),
            body: SafeArea(
                child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 20, right: 20, bottom: 15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Text(
                                      'Choose one as your trainer',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 190, 227, 57)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              FutureBuilder<List<TrainerProfileModel>>(
                                future:
                                    TrainerProfileService().trainerProfileList,
                                builder: ((context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    250),
                                                        child: TrainerProfile(
                                                          docId: snapshot
                                                              .data![index].id,
                                                        )));
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 85,
                                                margin: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Card(
                                                  elevation: 5,
                                                  color: const Color.fromARGB(
                                                      255, 114, 97, 89),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 60,
                                                          width: 60,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100.0),
                                                            child:
                                                                Image.network(
                                                              height: 65,
                                                              width: 65,
                                                              fit: BoxFit
                                                                  .contain,
                                                              snapshot
                                                                  .data![index]
                                                                  .userImage,
                                                            ),
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
                                                                  "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}",
                                                                  style: GoogleFonts.montserrat(
                                                                      letterSpacing:
                                                                          .5,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                              Text(
                                                                  "Experience ${snapshot.data![index].expage} years ",
                                                                  style: GoogleFonts.manjari(
                                                                      letterSpacing:
                                                                          .5,
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          190,
                                                                          227,
                                                                          57),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500)),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ));
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ));
                                  }
                                }),
                              ),
                            ]),
                      ),
                    )))));
  }
}
