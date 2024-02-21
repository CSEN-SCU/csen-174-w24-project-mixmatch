import 'package:flutter/material.dart';
import 'landing.dart';
import 'fyp.dart';

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
      // home: const ForYouPage(title: 'For You'),
      home: const LandingPage(title: 'MixMatch'),
      debugShowCheckedModeBanner: false,
      routes: {
        '/fyp': (context) => const ForYouPage(title: 'For You'),
      },
    );
  }
}
