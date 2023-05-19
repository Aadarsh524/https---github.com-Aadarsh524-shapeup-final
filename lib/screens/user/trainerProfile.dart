import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/screens/chatScreen.dart';

class TrainerProfile extends StatefulWidget {
  TrainerProfile({Key? key}) : super(key: key);

  @override
  State<TrainerProfile> createState() => _TrainerProfileState();
}

class _TrainerProfileState extends State<TrainerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 28, 28, 30),
          elevation: 0,
          toolbarHeight: 60,
          title: Text("Trainer Profile",
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
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 20, right: 20, bottom: 20),
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
                              color: const Color.fromARGB(255, 190, 227, 57)),
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            fit: BoxFit.fill,
                            "assets/male.png",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.account_circle_sharp,
                          size: 20,
                          color: Color.fromARGB(255, 166, 181, 106),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Aadarsh Ghimire",
                            style: GoogleFonts.montserrat(
                                letterSpacing: .5,
                                color: const Color.fromARGB(255, 166, 181, 106),
                                fontSize: 24,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          size: 20,
                          color: Color.fromRGBO(142, 153, 183, 0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("email",
                            style: GoogleFonts.montserrat(
                                letterSpacing: 0,
                                color: Color.fromRGBO(142, 153, 183, 0.5),
                                fontSize: 15,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 20,
                          color: Color.fromRGBO(142, 153, 183, 0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("+977 8239828392",
                            style: GoogleFonts.montserrat(
                                letterSpacing: 0,
                                color: Color.fromRGBO(142, 153, 183, 0.5),
                                fontSize: 15,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        // gender == "male"
                        //     ? const Icon(
                        //         MdiIcons.genderMale,
                        //         size: 20,
                        //         color: Color.fromRGBO(142, 153, 183, 0.5),
                        //       )
                        //     :
                        const Icon(
                          MdiIcons.genderFemale,
                          size: 20,
                          color: Color.fromRGBO(142, 153, 183, 0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("gender",
                            style: GoogleFonts.montserrat(
                                letterSpacing: 0,
                                color: Color.fromRGBO(142, 153, 183, 0.5),
                                fontSize: 15,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text("Training Information",
                          style: GoogleFonts.montserrat(
                              letterSpacing: 0,
                              color: Color.fromARGB(255, 114, 97, 89),
                              fontSize: 15,
                              fontWeight: FontWeight.w300)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      elevation: 1,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      color: Color.fromARGB(255, 114, 97, 89),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " Experience:",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "6 years",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                    letterSpacing: .5,
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      elevation: 1,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      color: Color.fromARGB(255, 114, 97, 89),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Active clients:",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '15',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                    letterSpacing: .5,
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 250),
                                    child: ChatScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  Color.fromARGB(255, 190, 227, 57),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 1, bottom: 1),
                            child: Text(
                              "Appoint",
                              style: GoogleFonts.notoSansMono(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
        ));
  }
}
