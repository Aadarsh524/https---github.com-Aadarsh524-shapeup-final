import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/components/exercise_card.dart';
import 'package:shapeup/models/exercise_model.dart';
import 'package:shapeup/services/exercisedb.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 65,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 12, top: 10),
            child: Text(
              "Your Exercises",
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: StreamBuilder<List<ExerciseModel>>(
            stream: ExerciseDatabase().exerciseInfo,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ExerciseCard(
                        exercisemodel: snapshot.data![index],
                      );
                    });
              } else {
                return const CircularProgressIndicator();
              }
            }),
          ),
        ));
  }
}
