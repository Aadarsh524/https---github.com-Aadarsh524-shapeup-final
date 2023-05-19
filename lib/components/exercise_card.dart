import 'package:flutter/material.dart';
import 'package:shapeup/models/exercise_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/exercisedetail.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseModel exercisemodel;
  const ExerciseCard({Key? key, required this.exercisemodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ExerciseDetail(exercisemodel: exercisemodel))),
      child: Card(
        margin: const EdgeInsets.all(15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 10.0,
        child: Column(
          children: [
            Image.network(
              exercisemodel.image,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                exercisemodel.type,
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
