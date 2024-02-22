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
        home: LandingPage(title: 'MixMatch', loginFunc: signInWithGoogle()),
        routes: {
          '/': (context) => const MyHomePage(title: 'MixMatch'),
          '/fyp': (context) => const ForYouPage(title: 'For You'),
          // '/': (context) => const MyHomePage(title: 'MixMatch'),
        });
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  // Once signed in, return the UserCredential
  UserCredential credentials =
      await FirebaseAuth.instance.signInWithPopup(googleProvider);

  UserProfile.ensure();

  return credentials;

  // Or use signInWithRedirect
  // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Builder(
            builder: (context) {
              if (UserProfile.loggedIn()) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the ProfilePage
                        // Pass the documentId of the user profile you want to edit
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ForYouPage(title: "fyp")),
                        );
                      },
                      child: Text('For You'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the ProfilePage
                        // Pass the documentId of the user profile you want to edit
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfilePage(documentId: UserProfile.currentID())),
                        );
                      },
                      child: Text('Edit Profile'),
                    )
                  ]
                );
              }
              else {
                return ElevatedButton(
                  onPressed: () async {
                    // Navigate back to first route when tapped.
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => const SwipePage(title: "Swipe Away!")));
                    UserCredential currUser = await signInWithGoogle();

                    print(currUser.user);
                  },
                  child: const Text('Login'),
                );
              }
            },
        ),
      )
    );
  }
}
