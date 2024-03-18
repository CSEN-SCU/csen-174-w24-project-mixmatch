import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tag extends StatelessWidget {
  final String tagName;
  final Color tagColor;
  final Color textColor;

  const Tag(
      {super.key,
      required this.tagName,
      required this.tagColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          color: tagColor),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: DefaultTextStyle(
          style: TextStyle(
              color: textColor,
              fontFamily: GoogleFonts.inter.toString(),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1),
          child: Text(tagName),
        ),
      ),
    );
  }
}
