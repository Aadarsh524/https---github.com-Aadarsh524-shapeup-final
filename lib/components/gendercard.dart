import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const GenderCard(
      {required this.cardIcon,
      required this.cardTitle,
      required this.cardColor,
      required this.iconColor}); //remove required
  final IconData cardIcon;
  final String cardTitle;
  final Color cardColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 140,
        width: 140,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
            color: cardColor,
            child: Container(
              height: 140,
              width: 140,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    cardIcon,
                    color: iconColor,
                    size: 36,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      cardTitle,
                      style: GoogleFonts.montserrat(
                        letterSpacing: .4,
                        fontSize: 14,
                        color: iconColor,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
