import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/header.dart';
import '../components/footer.dart';
import '../components/match.dart';
import '../classes/styles.dart';
import '../classes/user.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key, required this.title});
  final String title;

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  late final Future matchesFuture = UserProfile.getMatches();

  // get list of user's matches as UserProfiles
  // pass into Matches widget

  /*UserProfile user1 = UserProfile(
      username: 'Drake Didgeridoo',
      email: '',
      tags: ['R&B', 'HipHop', 'Singer']);
  UserProfile user2 = UserProfile(
      username: 'Andrew Amateur',
      email: '',
      tags: ['Beats', 'Student', 'LoFi']);
  UserProfile user3 = UserProfile(
      username: 'Freddy Freelancer',
      email: '',
      tags: ['Beats', 'HipHop', 'LFW']);
  UserProfile user4 = UserProfile(
      username: 'Freddy Freelancer',
      email: '',
      tags: ['Beats', 'HipHop', 'LFW']);
  UserProfile user5 = UserProfile(
      username: 'Freddy Freelancer',
      email: '',
      tags: ['Beats', 'HipHop', 'LFW']);
  UserProfile user6 = UserProfile(
      username: 'Freddy Freelancer',
      email: '',
      tags: ['Beats', 'HipHop', 'LFW']);
  UserProfile user7 = UserProfile(
      username: 'Freddy Freelancer',
      email: '',
      tags: ['Beats', 'HipHop', 'LFW']);
  UserProfile user8 = UserProfile(
      username: 'Freddy Freelancer',
      email: '',
      tags: ['Beats', 'HipHop', 'LFW']);
  UserProfile user9 = UserProfile(
      username: 'Freddy Freelancer',
      email: '',
      tags: ['Beats', 'HipHop', 'LFW']);
  UserProfile user10 = UserProfile(
      username: 'Freddy Freelancer',
      email: '',
      tags: ['Beats', 'HipHop', 'LFW']);*/

  List<UserProfile> matches = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget middle = FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            matches.addAll(snapshot.data!);
          }

          if (matches.isNotEmpty) {
            return Matches(matches: matches);
          }
          else {
            return DefaultTextStyle(
              style: TextStyles.cardHeaderAge,
              child: const Text(
                  'You do not have any matches. Time to get to swiping!'),
            );
          }
        },
        future: matchesFuture
    );

    return Scaffold(
      appBar: HeaderWidget(
        title: widget.title,
        icons: const ['profile', 'settings'],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: DefaultTextStyle(
                style: GoogleFonts.inter(textStyle: TextStyles.numMatchesText),
                child: Text(
                  "You have 0 new matches and ${matches.length} total matches.",
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: middle,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const Footer(
        page: 'matches',
      ),
    );
  }
}
