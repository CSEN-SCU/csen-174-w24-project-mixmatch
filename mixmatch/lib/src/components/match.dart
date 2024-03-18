import 'package:flutter/material.dart';

import '../widgets/match_widget.dart';
import '../classes/user.dart';

class Matches extends StatefulWidget {

  final Map<String, UserProfile> matches;
  const Matches({super.key, required this.matches});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  List<MatchWidget> matchWidgets = [];

  @override
  void initState() {
    for (MapEntry<String, UserProfile> entry in widget.matches.entries) {
      matchWidgets.add(MatchWidget(user: entry.value, id: entry.key));
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
