import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/user/trainerProfile.dart';

class TrainerListScreen extends StatefulWidget {
  const TrainerListScreen({Key? key}) : super(key: key);

  @override
  State<TrainerListScreen> createState() => _TrainerListScreenState();
}

class _TrainerListScreenState extends State<TrainerListScreen> {
  @override
  void initState() {
    super.initState();
  }

  // List<String> imagePathList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        body: Scaffold(
            backgroundColor: Color.fromARGB(255, 28, 28, 30),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
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
                              ListView.builder(
                                  itemCount: 2,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  duration: const Duration(
                                                      milliseconds: 250),
                                                  child: TrainerProfile()));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 90,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height: 65,
                                                    width: 65,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                      child: Image.asset(
                                                        fit: BoxFit.fill,
                                                        "assets/male.png",
                                                      ),
                                                    ),
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
                                                        Text("Aadarsh Ghimire",
                                                            style: GoogleFonts
                                                                .montserrat(
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
                                                            "6 years experience",
                                                            style: GoogleFonts.manjari(
                                                                letterSpacing:
                                                                    .5,
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    190,
                                                                    227,
                                                                    57),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                  const Icon(
                                                    size: 20,
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    color: Color.fromARGB(
                                                        255, 174, 155, 141),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                            ]),
                      ),
                      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                      // floatingActionButton: FloatingActionButton.extended(
                      //     onPressed: () async {

                      //     backgroundColor: Color.fromARGB(255, 166, 181, 106),
                      //     label: Text(
                      //       'Buy Premium',
                      //       style: GoogleFonts.notoSansMono(
                      //           fontSize: 16,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.w600),
                      //     )));
                    )))));
  }
}
