import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shapeup/components/exercise/exercise_card.dart';
import 'package:shapeup/models/exercise/exercise_model.dart';
import 'package:shapeup/screens/user/exercise/premiumPlansScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../services/exercise/exercise_service.dart';

class FreePlansScreen extends StatefulWidget {
  const FreePlansScreen({Key? key}) : super(key: key);

  @override
  State<FreePlansScreen> createState() => _FreePlansScreenState();
}

class _FreePlansScreenState extends State<FreePlansScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  bool? premium;

  PageController controller = PageController();
  final List<Widget> pageList = <Widget>[
    const PremiumPlanScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder<List<ExerciseModel>>(
                  future: ExerciseService().exerciseInfo,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics:
                            const NeverScrollableScrollPhysics(), // Disable inner list scrolling
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ExerciseCard(
                            exercisemodel: snapshot.data![index],
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Card(
                    shadowColor: Colors.black,
                    color: Colors.greenAccent[100],
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Premiun Plans',
                              style: GoogleFonts.montserrat(
                                letterSpacing: 1.0,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 125, 128, 122),
                              ),
                            ), //Text//SizedBox
                            SizedBox(
                              child: ElevatedButton(
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: const PremiumPlanScreen(),
                                    ),
                                  ),
                                },
                                child: const Icon(Icons.arrow_forward),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
