import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  final Color textColor;

  const TextStyles({required this.textColor});

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
      shape: const CircleBorder(),
      elevation: 1.25,
      minimumSize: const Size(72, 72));

  static ButtonStyle interactionButtons = ElevatedButton.styleFrom(
      backgroundColor: Colors.grey.shade50,
      surfaceTintColor: Colors.purple.shade50,
      shape: const CircleBorder(),
      elevation: 3,
      minimumSize: const Size(86, 86));

  static ButtonStyle matchesButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.grey.shade50,
      surfaceTintColor: Colors.purple.shade50,
      shape: const CircleBorder(),
      elevation: 3,
      minimumSize: const Size(100, 100));
}

// abstract class HeaderTheme {
//   static ThemeData headerTheme =
//       ThemeData(textTheme: GoogleFonts.interTextTheme());
// }
