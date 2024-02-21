import 'package:flutter/material.dart';
import 'info.dart';
import 'header.dart';
import 'card.dart';
import 'tag.dart';
import 'footer.dart';
import 'profiles.dart';

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
