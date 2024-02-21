import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'styles.dart';

class LandingPage extends StatelessWidget {
  final String title;
  const LandingPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.headerText),
              child: Text(
                title,
                textAlign: TextAlign.center,
              )),
        ),
      ],
    );
  }
}
