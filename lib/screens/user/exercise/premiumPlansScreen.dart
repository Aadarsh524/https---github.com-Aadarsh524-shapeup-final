import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/user/exercise/premiumPlansDetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/exercise/custom_exercise_model.dart';
import '../../../services/exercise/exercise_service.dart';

class PremiumPlanScreen extends StatefulWidget {
  const PremiumPlanScreen({Key? key}) : super(key: key);

  @override
  State<PremiumPlanScreen> createState() => _PremiumPlanScreenState();
}

class _PremiumPlanScreenState extends State<PremiumPlanScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  bool? premium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: true,
          title: Text("Exercises",
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
                  FutureBuilder<List<CustomExerciseModel>>(
                    future: ExerciseService().customExerciseList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable inner list scrolling
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return PremiumCardDetailExerciseCard(
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

class PremiumCardDetailExerciseCard extends StatelessWidget {
  final CustomExerciseModel customPlanmodel;
  const PremiumCardDetailExerciseCard({Key? key, required this.customPlanmodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  PremiumPlanDetailScreen(exercisemodel: customPlanmodel))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    customPlanmodel.planName,
                    style: GoogleFonts.montserrat(
                        color: Color.fromARGB(255, 226, 226, 226),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
