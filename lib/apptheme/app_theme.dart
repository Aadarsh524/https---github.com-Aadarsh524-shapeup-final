import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final Color _iconColor = Colors.blueAccent.shade200;

  static const Color _darkPrimaryColor = Color.fromARGB(255, 28, 28, 30);
  static const Color _darkSecondaryColor = Color.fromARGB(255, 190, 227, 57);
  static const Color _darkTertiaryColor = Color.fromARGB(255, 214, 243, 155);
  static const Color _darkOnTertiaryColor = Color.fromARGB(255, 226, 226, 226);
  static const Color _darkOnPrimaryColor = Color.fromARGB(255, 114, 97, 89);
  static const Color _darkback1 = Color.fromARGB(255, 125, 128, 122);
  static const Color _darkback2 = Color.fromARGB(255, 25, 170, 151);
  static const Color _darkback3 = Color.fromARGB(255, 174, 155, 141);
  static const Color _darkback4 = Color.fromARGB(255, 166, 181, 106);
  static const Color _darkred = Color.fromARGB(255, 214, 21, 11);

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: _darkPrimaryColor,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(color: _darkOnPrimaryColor),
      ),
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimaryColor,
        secondary: _darkSecondaryColor,
        onPrimary: _darkOnPrimaryColor,
        tertiary: _darkTertiaryColor,
        onTertiary: _darkOnTertiaryColor,
      ),
      iconTheme: IconThemeData(
        color: _iconColor,
      ),
      textTheme: _darkTextTheme,
      dividerTheme: const DividerThemeData(color: Colors.black));

  static final TextTheme _darkTextTheme = TextTheme(
      labelLarge: GoogleFonts.getFont("Lateef",
          letterSpacing: .5,
          color: const Color.fromARGB(255, 208, 253, 62),
          fontSize: 48,
          fontWeight: FontWeight.w300),
      labelMedium: GoogleFonts.lateef(
          fontSize: 40, fontWeight: FontWeight.w700, letterSpacing: 1.5),
      labelSmall: GoogleFonts.getFont(
        "Lateef",
        fontSize: 10,
      ),
      bodyMedium: GoogleFonts.getFont(
        "Montserrat",
        letterSpacing: 2,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      bodySmall: GoogleFonts.getFont(
        "Montserrat",
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.black.withOpacity(.25),
      ));
}
