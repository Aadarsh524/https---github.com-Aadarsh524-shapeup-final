import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shapeup/screens/user/diet/daily_diet_plan_page.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../models/diet_model.dart';

class DietDetailPage extends StatelessWidget {
  final DietModel dietModel;
  const DietDetailPage({Key? key, required this.dietModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 114, 97, 89),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: IconButton(
                  color: Colors.black,
                  iconSize: 12,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
        title: Text(dietModel.title,
            style: GoogleFonts.montserrat(
                letterSpacing: .5,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: dietModel.imagePath,
                child: CachedNetworkImage(
                  imageUrl: dietModel.imagePath,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Description',
                style: GoogleFonts.montserrat(
                    letterSpacing: .5,
                    color: Color.fromARGB(255, 174, 155, 141),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Text(dietModel.description,
                  style: GoogleFonts.montserrat(
                      letterSpacing: .5,
                      color: Color.fromARGB(255, 226, 226, 226),
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 15,
              ),
              Text('Duration: ${dietModel.duration}',
                  style: GoogleFonts.montserrat(
                      letterSpacing: .5,
                      color: Color.fromARGB(255, 125, 128, 122),
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 15,
              ),
              Text('Difficulty: ${dietModel.difficulty}',
                  style: GoogleFonts.montserrat(
                      letterSpacing: .5,
                      color: Color.fromARGB(255, 125, 128, 122),
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 15,
              ),
              Text('Commitment: ${dietModel.commitment}',
                  style: GoogleFonts.montserrat(
                      letterSpacing: .5,
                      color: Color.fromARGB(255, 125, 128, 122),
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DailyDietPlanPage(
                          docId: dietModel.id,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color.fromARGB(255, 166, 181, 106),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  child: Text(
                    "See Plan",
                    style: GoogleFonts.notoSansMono(
                        color: Colors.black.withOpacity(.75),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(dietModel.caution,
                  style: GoogleFonts.manjari(
                      letterSpacing: .5,
                      color: Color.fromARGB(255, 190, 227, 57),
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
