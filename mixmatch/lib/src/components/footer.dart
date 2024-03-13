import 'package:flutter/material.dart';

import '../classes/styles.dart';

class Footer extends StatelessWidget {
  final String page;
  const Footer({super.key, this.page = ''});

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case 'matches':
        return Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.7)
              ],
              stops: const [0.3, 1.0],
            ),
          ),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                // navigate to settings page
              },
              style: ButtonStyles.matchesButton,
              child: Icon(
                Icons.whatshot,
                color: Colors.grey.shade900,
                size: 50.0,
                semanticLabel: 'matches',
              ),
            ),
          ),
        );
      default:
        return Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.white.withOpacity(0.7)],
            ),
          ),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                // navigate to settings page
              },
              style: ButtonStyles.matchesButton,
              child: Icon(
                Icons.people_alt_rounded,
                color: Colors.grey.shade900,
                size: 50.0,
                semanticLabel: 'fyp',
              ),
            ),
          ),
        );
    }
  }
}
