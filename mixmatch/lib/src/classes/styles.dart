import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  final Color textColor;

  const TextStyles({required this.textColor});

  static TextStyle onboardingText = TextStyle(
      color: Colors.grey.shade800,
      fontFamily: 'Inter',
      fontSize: 60.0,
      fontWeight: FontWeight.w900,
      height: 1);

  static TextStyle inputText = TextStyle(
      color: Colors.grey.shade600,
      fontFamily: GoogleFonts.inter.toString(),
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 1);

  static TextStyle bigText = TextStyle(
      color: Colors.grey.shade800,
      fontFamily: GoogleFonts.inter.toString(),
      fontSize: 72.0,
      fontWeight: FontWeight.w900,
      height: 1);

  static TextStyle bodyText = TextStyle(
      color: Colors.grey.shade800,
      fontFamily: GoogleFonts.inter.toString(),
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      height: 1.5);

  static TextStyle loginText = TextStyle(
      color: Colors.grey.shade50,
      fontFamily: GoogleFonts.inter.toString(),
      fontSize: 20.0,
      fontWeight: FontWeight.w800,
      height: 1);

  static TextStyle headerText = TextStyle(
      color: Colors.grey.shade900,
      fontFamily: GoogleFonts.inter.toString(),
      fontSize: 36.0,
      fontWeight: FontWeight.w900,
      height: 1);

  static TextStyle cardHeaderName = TextStyle(
      color: Colors.grey.shade900,
      fontFamily: GoogleFonts.inter.toString(),
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
      height: 1);

  static TextStyle cardHeaderAge = TextStyle(
      color: Colors.grey.shade900,
      fontFamily: GoogleFonts.inter.toString(),
      fontSize: 22.0,
      fontWeight: FontWeight.w800,
      height: 1);

  static TextStyle cardAbout = TextStyle(
      color: Colors.grey.shade800,
      fontFamily: GoogleFonts.inter.toString(),
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.5);

  static TextStyle cardTopTags = TextStyle(
      color: Colors.grey.shade700,
      fontFamily: GoogleFonts.inter.toString(),
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      height: 1);
}

abstract class ButtonStyles {
  static ButtonStyle headerButtons = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.purple.shade50,
      foregroundColor: Colors.purple.shade50,
      shape: const CircleBorder(),
      elevation: 1.25,
      minimumSize: const Size(72, 72));

  static ButtonStyle interactionButtons = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.purple.shade50,
      foregroundColor: Colors.purple.shade50,
      shape: const CircleBorder(),
      elevation: 3,
      minimumSize: const Size(86, 86));

  static ButtonStyle matchesButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.purple.shade50,
      foregroundColor: Colors.purple.shade50,
      shape: const CircleBorder(),
      elevation: 3,
      minimumSize: const Size(100, 100));

  static ButtonStyle loginButton = ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 230, 145, 230),
      surfaceTintColor: Colors.purple.shade50,
      foregroundColor: Colors.purple.shade50,
      elevation: 3,
      minimumSize: const Size(100, 75),
      maximumSize: const Size(200, 125));

  static ButtonStyle proceedButton = ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 230, 145, 230),
      surfaceTintColor: Colors.purple.shade50,
      foregroundColor: Colors.purple.shade50,
      shape: const CircleBorder(),
      elevation: 5,
      minimumSize: const Size(100, 75),
      maximumSize: const Size(200, 125));
}

// abstract class HeaderTheme {
//   static ThemeData headerTheme =
//       ThemeData(textTheme: GoogleFonts.interTextTheme());
// }
