import 'package:flutter/material.dart';

import '../widgets/match_widget.dart';
import '../classes/user.dart';

class Matches extends StatefulWidget {
  final List<UserProfile> matches;
  const Matches({super.key, required this.matches});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  List<MatchWidget> matchWidgets = [];

  @override
  void initState() {
    for (UserProfile user in widget.matches) {
      matchWidgets.add(MatchWidget(user: user));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Column(
        children: matchWidgets,
      ),
    );
  }
}
