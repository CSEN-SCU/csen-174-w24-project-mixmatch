import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'card.dart';

class ProfileRecs extends StatefulWidget {
  final List<CardWidget> cards;

  const ProfileRecs({super.key, required this.cards});

  @override
  State<ProfileRecs> createState() => _ProfileRecsState();
}

class _ProfileRecsState extends State<ProfileRecs> {
  final List<SwipeItem> _recs = <SwipeItem>[];

  @override
  void initState() {
    for (int i = 0; i < widget.cards.length; i++) {
      _recs.add(SwipeItem(content: widget.cards[i]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeCards(
      matchEngine: MatchEngine(swipeItems: _recs),
      itemBuilder: (context, index) {
        return Container(
          child: _recs[index].content,
        );
      },
      onStackFinished: () {
        return const Text('All recommended profiles viewed...');
      },
    );
  }
}
