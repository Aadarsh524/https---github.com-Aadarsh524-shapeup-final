import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/trainer/trainerplans/exercises.dart';
import 'package:shapeup/screens/trainer/trainerscreen/customworkout.dart';

class DayCard extends StatefulWidget {
  
  const DayCard({Key? key}) : super(key: key);

  @override
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  List days = ['1', '2', '3', '4', '5', '6', '7'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      appBar: AppBar(
        elevation: 0,
        title: Text('Days',
            style: GoogleFonts.montserrat(
                letterSpacing: .5,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600)),
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddExercise()));
                },
                child: Card(
                  elevation: 15,
                  color: Color.fromARGB(255, 114, 97, 89),
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Day' + ' ' + days[index],
                      style: GoogleFonts.montserrat(
                          letterSpacing: .5,
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
            }),
            itemCount: days.length,
          ),
        ),
      ),
    );
  }
}
