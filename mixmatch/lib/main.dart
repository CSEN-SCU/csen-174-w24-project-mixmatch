import 'package:flutter/material.dart';
import 'package:mixmatch/info.dart';
import 'header.dart';
import 'card.dart';
import 'tag.dart';
import 'footer.dart';
import 'profiles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 198, 64, 222)),
        useMaterial3: true,
      ),
      home: const ForYouPage(title: 'For You'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
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
                // Navigate back to first route when tapped.
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const SwipePage(title: "Swipe Away!")));
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

class SwipePage extends StatefulWidget {
  const SwipePage({super.key, required this.title});

  final String title;

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
            child: Row(children: [
          Column(
            children: [
              ElevatedButton(
                child: Text("X"),
                onPressed: () => {},
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Placeholder()),
                    Expanded(child: Text("DJ John Doe"))
                  ],
                ),
                Row(children: [Expanded(child: Text("DJ/Mixing"))]),
                Row(
                  children: [Expanded(child: Placeholder())],
                )
              ],
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                child: Text("✓"),
                onPressed: () => {},
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ])));
  }
}

class ForYouPage extends StatefulWidget {
  const ForYouPage({super.key, required this.title});
  final String title;

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  static List<Tag> topTags = [
    Tag(
        tagName: 'Beats',
        tagColor: Colors.pink.shade100,
        textColor: Colors.pink.shade300),
    Tag(
        tagName: 'HipHop',
        tagColor: Colors.blue.shade100,
        textColor: Colors.blue.shade300),
    Tag(
        tagName: 'Rap',
        tagColor: Colors.orange.shade100,
        textColor: Colors.orange.shade300),
  ];
  static Profile profile1 = Profile(
      'Freddy Freelancer',
      25,
      'Aspiring music producer. Chicago native. Looking for gigs. 🎸',
      topTags,
      [const AssetImage('images/metro-in-studio.png')]);

  static Profile profile2 = Profile(
      'George Washington',
      147,
      'Aspiring music producer. Chicago native. Looking for gigs. 🎸',
      topTags,
      [const AssetImage('images/metro-in-studio.png')]);

  List<CardWidget> recs = [
    CardWidget(
      profileData: profile1,
    ),
    CardWidget(
      profileData: profile2,
    ),
    CardWidget(
      profileData: profile1,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderWidget(
            title: widget.title,
            icons: const ['profile', 'settings'],
          ),
          // CardWidget(profileData: profile),
          ProfileRecs(cards: recs),
          const Footer(page: 'fyp')
        ],
      ),
    );
  }
}
