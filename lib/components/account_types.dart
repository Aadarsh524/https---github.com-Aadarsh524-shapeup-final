import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountTypeCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AccountTypeCard(
      {required this.cardImg,
      required this.cardBorder,
      required this.cardTitle}); //remove required
  final String cardImg;
  final String cardTitle;
  final double cardBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(width: cardBorder, color: Colors.white),
        color: Color.fromARGB(255, 28, 28, 30),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
                width: 90,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 190, 227, 57),
                    shape: BoxShape.circle),
                height: 90,
                child: Center(
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      cardImg,
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                cardTitle,
                style: GoogleFonts.montserrat(
                  letterSpacing: .4,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
