import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../classes/styles.dart';

class LandingPage extends StatelessWidget {
  final String title;
  final Future<UserCredential> Function(BuildContext) loginFunc;
  const LandingPage({super.key, required this.title, required this.loginFunc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
          child: DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.bigText),
              child: Text(
                title,
                textAlign: TextAlign.center,
              )),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 100),
          child: DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.bodyText),
              child: const Text(
                "Wanting to see what all the hype's about? \n Login below to expand your network of musical talent...",
                textAlign: TextAlign.center,
              )),
        ),
        ElevatedButton(
            onPressed: () => loginFunc(context),
            style: ButtonStyles.loginButton,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextStyle(
                    style: GoogleFonts.inter(textStyle: TextStyles.loginText),
                    child: const Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                    ))
              ],
            )),
      ],
    );
  }
}
