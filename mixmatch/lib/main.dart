import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mixmatch/src/pages/landing.dart';
import 'package:mixmatch/src/pages/matches.dart';
// import 'src/pages/landing.dart';
import 'src/pages/profile.dart';
import 'src/pages/fyp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'src/classes/user.dart';
// import 'src/widgets/profilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'src/pages/onboarding.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UserProfile user = UserProfile(
      username: 'Freddy Freelancer',
      email: '',
      tags: ['Beats', 'HipHop', 'LFW']);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MixMatch',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade700),
          useMaterial3: false,
        ),
        // home: LandingPage(title: 'MixMatch', loginFunc: signInWithGoogle()),
        home: const LandingPage(title: 'MixMatch', loginFunc: signInWithGoogle),
        routes: {
          '/profile' (context) => const ProfilePage(title: "Profile",
            icons: const ['back', 'edit'],
            user: user,
          ),
          '/fyp': (context) => const ForYouPage(title: 'For You'),
          '/matches': (context) => const MatchesPage(title: 'Matches'),
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
