// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shapeup/models/exercise_model.dart';
import 'package:shapeup/screens/user/exercise/exercisedaylist.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseDetail extends StatelessWidget {
  final ExerciseModel exercisemodel;
  const ExerciseDetail({Key? key, required this.exercisemodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(exercisemodel.type),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                exercisemodel.image,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                exercisemodel.type,
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.justify,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // print(exercisemodel.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ExerciseDayList(exercisemodel: exercisemodel),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                  ),
                  child: const Text(
                    'See Plan Details',
                    style: TextStyle(fontSize: 15),
                  ),
                ).height(45).padding(top: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
