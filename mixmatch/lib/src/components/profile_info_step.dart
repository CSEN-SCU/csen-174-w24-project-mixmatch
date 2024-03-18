import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mixmatch/src/components/onboarding_widget.dart';
import '../classes/styles.dart';

class ProfileInfoStep extends StatefulWidget {
  const ProfileInfoStep({super.key});

  @override
  OnboardingWidgetState<ProfileInfoStep> createState() => _ProfileInfoStepState();
}

class _ProfileInfoStepState extends OnboardingWidgetState<ProfileInfoStep> {
  late final String firstName;
  late final String lastName;
  late final String bio;
  final _bioController = TextEditingController();

  void _updateBio() {
    setState(() {
      bio = _bioController.text;
    });
  }

  @override
  void initState() {
    _bioController.addListener(_updateBio);
    super.initState();
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  bool validate() {
    return bio.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.headerText),
              child: const Text(
                "Welcome to MixMatch!\n",
                textAlign: TextAlign.center,
              )
            ),
            DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.profileBioText),
              child: const Text(
                "Let's get started by creating your profile. First, tell us a little about yourself and why you're here!",
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
                width: 300,
                child: TextFormField(
                  controller: _bioController,
                  cursorColor: Colors.purple.shade200,
                  style: TextStyles.inputText,
                  minLines: 3,
                  maxLines: 5,
                  maxLength: 150,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintStyle: TextStyles.inputText,
                    hintText: "Bio",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: ((newValue) async {
                    await FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).set({
                      'bio': newValue,
                    }, SetOptions(merge: true));
                  }),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
