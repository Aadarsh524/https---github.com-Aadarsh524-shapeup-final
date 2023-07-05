import 'package:flutter/material.dart';
import 'package:shapeup/models/custom_exercise_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/user/exercise/customDayList.dart';

class CustomExerciseCard extends StatelessWidget {
  final CustomExerciseModel customPlanmodel;
  const CustomExerciseCard({Key? key, required this.customPlanmodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CustomDayList(exercisemodel: customPlanmodel))),
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
