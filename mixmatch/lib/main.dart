import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';
import 'src/widgets/profilePage.dart';
import 'src/widgets/swipe_page.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade700),
          useMaterial3: true,
        ),
        //home: const MyHomePage(title: 'MixMatch Landing Page'),
        routes: {
          '/': (context) => const MyHomePage(title: 'MixMatch Landing Page'),
          '/swipe': (context) => const SwipePage(title: "Swipe!")
        }
    );
  }
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
                  MaterialPageRoute(builder: (context) => ProfilePage(documentId: "yourDocumentId")),
                );
              },
              child: Text('Edit Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate back to first route when tapped.
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SwipePage(title: "Swipe Away!")));
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

