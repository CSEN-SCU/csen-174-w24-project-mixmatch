import 'package:flutter/material.dart';

import 'styles.dart';

class Footer extends StatelessWidget {
  final String page;
  const Footer({super.key, this.page = ''});

  @override
  Widget build(BuildContext context) {
    switch (page) {
      default:
        return Container(
          padding: const EdgeInsets.only(bottom: 25),
          child: ElevatedButton(
              onPressed: () {
                // navigate to settings page
              },
              style: ButtonStyles.matchesButton,
              child: Icon(
                Icons.people_alt_rounded,
                color: Colors.grey.shade900,
                size: 40.0,
                semanticLabel: 'matches',
              )),
        );
    }
  }
}
