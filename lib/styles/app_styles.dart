import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle screenTitle = TextStyle(
    fontSize: 25,
    color: Colors.black54,
    fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  static TextStyle screenSubTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black45,
    fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  static TextStyle buttonsText = TextStyle(
    color: const Color.fromARGB(255, 87, 68, 255),
    fontFamily: GoogleFonts.robotoMono().fontFamily,
  );

  static TextStyle otherText = TextStyle(
    fontSize: 18,
    color: const Color.fromARGB(171, 0, 0, 0),
    fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  static TextStyle errorMsg = TextStyle(
    fontSize: 22,
    color: Colors.red,
    fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 106, 100, 194),
    foregroundColor: const Color.fromARGB(221, 184, 180, 180),
    centerTitle: true,
    titleTextStyle: screenSubTitle,
  );

  static ThemeData themeData = ThemeData(
      appBarTheme: appBarTheme,
      scaffoldBackgroundColor: const Color.fromARGB(255, 217, 230, 238));
}
