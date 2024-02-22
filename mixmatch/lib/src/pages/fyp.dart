import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../classes/info.dart';
import '../components/header.dart';
import '../widgets/card.dart';
import '../widgets/tag.dart';
import '../components/footer.dart';
import '../components/profiles.dart';

class ForYouPage extends StatefulWidget {
  const ForYouPage({super.key, required this.title});
  final String title;

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {

  late final Future cardFuture = getSwipeCards();

  Future getSwipeCards() async {
    List<CardWidget> cards = [];

    QuerySnapshot profiles = await FirebaseFirestore.instance.collection('userProfiles').get();

    for (int i = 0; i < profiles.size; i++) {
      if (profiles.docs[i].id != UserProfile.currentID()) {
        cards.add(CardWidget(profileData: UserProfile.fromDocument(profiles.docs[i])));
      }
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    List<CardWidget> cards = [];

    return Scaffold(
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            cards.addAll(snapshot.data!);
            print(cards.length);
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderWidget(
                  title: widget.title,
                  icons: const ['profile', 'settings'],
                ),
                // CardWidget(profileData: profile),
                ProfileRecs(cards: cards),
                const Footer(page: 'fyp')
              ],
            );
          }
          else {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return Text("Loading");
          }
          
        },
        future: cardFuture
      )
    );
  }
}
