import 'package:flutter/material.dart';
import 'package:mixmatch/src/pages/landing.dart';
import 'package:mixmatch/src/pages/matches.dart';
import 'package:mixmatch/src/pages/onboarding.dart';
import 'package:mixmatch/src/widgets/profile_args_extractor.dart';
// import 'src/pages/landing.dart';
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
          useMaterial3: false,
        ),
        // home: LandingPage(title: 'MixMatch', loginFunc: signInWithGoogle()),
        home: const LandingPage(title: 'MixMatch', loginFunc: signInWithGoogle),
        routes: {
          /*'/profile': (context) => ProfilePage(title: "Profile",
            icons: const ['back', 'edit'],
            userID: UserProfile.currentID()
          ),*/
          ProfileArgumentsScreen.routeName: (context) => const ProfileArgumentsScreen(), 
          '/fyp': (context) => const ForYouPage(title: 'For You',
            icons: ['profile', 'edit']
          ),
          '/matches': (context) => const MatchesPage(title: 'Matches',
            icons: ['back', 'profile']
          ),
          '/onboarding': (context) => const OnboardingPage()
        });
  }
}

Future<UserCredential> signInWithGoogle(BuildContext context) async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  // Once signed in, return the UserCredential
  UserCredential credentials =
      await FirebaseAuth.instance.signInWithPopup(googleProvider);

  await UserProfile.ensure();

  if (UserProfile.loggedIn()) {
    UserProfile? user = await UserProfile.currentProfile();
    if (user!.bio == "") {
      Navigator.pushNamed(context, '/onboarding');
    }
    else {
      Navigator.pushNamed(context, '/fyp');
    }
  }

  return credentials;

  // Or use signInWithRedirect
  // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
}
