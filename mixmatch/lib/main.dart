import 'dart:js';

import 'package:flutter/material.dart';
import 'src/pages/landing.dart';
import 'src/pages/fyp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'src/classes/user.dart';
import 'src/widgets/profilePage.dart';
import 'src/widgets/swipe_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MixMatch',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade700),
          useMaterial3: true,
        ),
        home: LandingPage(title: 'MixMatch', loginFunc: signInWithGoogle),
        routes: {
          '/fyp': (context) => const ForYouPage(title: 'For You'),
        });
  }
}

Future<UserCredential> signInWithGoogle(BuildContext context) async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  // Once signed in, return the UserCredential
  UserCredential credentials =
      await FirebaseAuth.instance.signInWithPopup(googleProvider);

  UserProfile.ensure();

  if (UserProfile.loggedIn()) {
    Navigator.pushNamed(context, '/fyp');
  }

  return credentials;

  // Or use signInWithRedirect
  // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
}
