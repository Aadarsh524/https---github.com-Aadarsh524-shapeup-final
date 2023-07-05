import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/components/exercise_card.dart';
import 'package:shapeup/models/exercise_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../components/customExerciseCard.dart';
import '../../../models/custom_exercise_model.dart';
import '../../../services/exerciseService.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          centerTitle: true,
          title: Text("Exercises Types",
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  FutureBuilder<List<ExerciseModel>>(
                    future: ExerciseService().exerciseInfo,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics:
                              NeverScrollableScrollPhysics(), // Disable inner list scrolling
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
                  FutureBuilder<List<CustomExerciseModel>>(
                    future: ExerciseService().customExerciseList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics:
                              NeverScrollableScrollPhysics(), // Disable inner list scrolling
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return CustomExerciseCard(
                              customPlanmodel: snapshot.data![index],
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
                ],
              ),
            ),
          ),
        ));
  }
}
