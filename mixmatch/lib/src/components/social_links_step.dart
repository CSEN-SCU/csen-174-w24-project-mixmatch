import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/styles.dart';

class SocialLinksStep extends StatefulWidget {
  const SocialLinksStep({super.key});

  @override
  State<SocialLinksStep> createState() => _SocialLinksStepState();
}

class _SocialLinksStepState extends State<SocialLinksStep> {
  late final String soundcloudLink;
  late final String imgurLink;
  final _soundcloudLinkController = TextEditingController();
  final _imgurLinkController = TextEditingController();

  void _updateSoundcloud() {
    setState(() {
      soundcloudLink = _soundcloudLinkController.text;
    });
  }

  void _updateImgur() {
    setState(() {
      imgurLink = _imgurLinkController.text;
    });
  }

  @override
  void initState() {
    _soundcloudLinkController.addListener(_updateSoundcloud);
    _imgurLinkController.addListener(_updateImgur);
    super.initState();
  }

  @override
  void dispose() {
    _soundcloudLinkController.dispose();
    _imgurLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.profileBioText),
              child: const Text(
                "Choose your best track to show off your skills!",
                textAlign: TextAlign.center,
              )
            ),
          Theme(
            data: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                  selectionColor: Colors.purple.shade50),
              inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade500),
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              width: 400,
              child: TextFormField(
                controller: _soundcloudLinkController,
                cursorColor: Colors.purple.shade200,
                style: TextStyles.inputText,
                cursorHeight: 26,
                decoration: InputDecoration(
                  hintStyle: TextStyles.inputText,
                  hintText: "Music Track Link",
                ),
                onSaved: ((newValue) async {
                  await FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).set({
                    'trackLink': newValue,
                  }, SetOptions(merge: true));
                })
              ),
            ),
          ),
          DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.profileBioText),
              child: const Text(
                "Put a link to your profile picture.",
                textAlign: TextAlign.center,
              )
            ),
          Theme(
            data: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                  selectionColor: Colors.purple.shade50),
              inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade500),
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              width: 400,
              child: TextFormField(
                controller: _imgurLinkController,
                cursorColor: Colors.purple.shade200,
                style: TextStyles.inputText,
                decoration: InputDecoration(
                  hintStyle: TextStyles.inputText,
                  hintText: "Imgur Link",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                ),
                onSaved: ((newValue) async {
                  await FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).set({
                    'images': [ newValue ],
                  }, SetOptions(merge: true));
                })
              ),
            ),
          ),
        ],
      ),
    );
  }
}
