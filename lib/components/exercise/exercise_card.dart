import 'package:flutter/material.dart';
import 'package:shapeup/models/exercise/exercise_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/user/exercise/exercisedaylist.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseModel exercisemodel;
  const ExerciseCard({Key? key, required this.exercisemodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ExerciseDayList(exercisemodel: exercisemodel))),
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
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    height: 150,
                    width: double.infinity,
                    colorBlendMode: BlendMode.colorBurn,
                    exercisemodel.image,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    exercisemodel.type,
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
