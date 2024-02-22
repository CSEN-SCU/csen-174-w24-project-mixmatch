import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mixmatch/src/classes/styles.dart';
import 'package:mixmatch/src/classes/user.dart';
import 'package:mixmatch/src/schema/swipe.dart';
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
    int i, j;

    List<CardWidget> cards = [];

    var profiles = (await FirebaseFirestore.instance.collection('userProfiles').get()).docs;

    var swipes = (await FirebaseFirestore.instance.collection('swipes').where("swiper", isEqualTo: UserProfile.currentID()).get()).docs;

    //TODO: O(n^2) is trash pls fix. I read BloomFilters may help!
    for (i = 0; i < swipes.length; i++) {
      Map<String, dynamic> swipe = swipes[i].data();
        for (j = 0; j < profiles.length; j++) {
          if (swipe["swipee"] == profiles[j].id) {
            profiles.remove(profiles[j]);
          }
        }
    }

    for (i = 0; i < profiles.length; i++) {
      UserProfile profile = UserProfile.fromDocument(profiles[i]);
      //TODO: This could be null, careful my boy
      String id = (await UserProfile.idFromUsername(profile.username))!;
      if (profiles[i].id != UserProfile.currentID()) {
        cards.add(CardWidget(
          uid: id,
          profileData: profile,
          likeAction: (String id) => {
            UserProfile.like(context, id)
          },
          dislikeAction: (String id) => {
            UserProfile.dislike(context, id)
          }
        ));
      }
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    List<CardWidget> cards = [];

    Widget middle = FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            cards.addAll(snapshot.data!);
          }

          if (cards.isNotEmpty) {
            return ProfileRecs(cards: cards);
          }
          else {
            return DefaultTextStyle(
              style: TextStyles.cardHeaderAge,
              child: Text(
                  'All recommendations viewed... please come back later! :)'),
            );
          }
        },
        future: cardFuture
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderWidget(
            title: widget.title,
            icons: const ['profile', 'settings'],
          ),
          // CardWidget(profileData: profile),
          middle,
          const Footer(page: 'fyp')
        ],
      )
    );
  }
}
