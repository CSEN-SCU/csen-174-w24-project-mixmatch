import 'package:flutter/material.dart';
import 'package:mixmatch/src/pages/matches.dart';
// import 'src/pages/landing.dart';
import 'src/pages/fyp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'src/classes/user.dart';
import 'src/widgets/profilePage.dart';
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
        home: const MatchesPage(
          title: "Matches",
        ),
        routes: {
          '/fyp': (context) => const ForYouPage(title: 'For You'),
          '/matches': (context) => const MatchesPage(title: 'Matches'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the ProfilePage
                // Pass the documentId of the user profile you want to edit
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ProfilePage(documentId: "yourDocumentId")),
                );
              },
              child: const Text('Edit Profile'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Navigate back to first route when tapped.
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const SwipePage(title: "Swipe Away!")));
                UserCredential currUser = await signInWithGoogle();

                print(currUser.user);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
