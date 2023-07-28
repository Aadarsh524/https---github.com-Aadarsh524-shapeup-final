import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayCard extends StatelessWidget {
  final List<String> days;
  final Function(String) onTap;

  const DayCard({super.key, required this.days, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Select Day',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 190, 227, 57),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  return Card(
                    elevation: 15,
                    color: const Color.fromARGB(255, 114, 97, 89),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: ListTile(
                      title: Text(
                        'Day $day',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => onTap(day),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
