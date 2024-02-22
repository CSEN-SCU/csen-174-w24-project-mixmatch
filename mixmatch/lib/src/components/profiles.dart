import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_cards/swipe_cards.dart';
// import 'package:swipe_to/swipe_to.dart';

import '../widgets/card.dart';
import '../classes/styles.dart';

class ProfileRecs extends StatefulWidget {
  final List<CardWidget> cards;

  const ProfileRecs({super.key, required this.cards});

  @override
  State<ProfileRecs> createState() => _ProfileRecsState();
}

class _ProfileRecsState extends State<ProfileRecs> {
  late final List<SwipeItem> _cards = <SwipeItem>[];
  late final MatchEngine _matchEngine;
  late int _counter = 0;
  bool _isDone = false;

  _like() {
    setState(() {
      _counter++;
    });
  }

  _nope() {
    setState(() {
      _counter++;
    });
  }

  _done() {
    setState(() {
      _isDone = true;
    });
  }

  Widget _buildCard(int index) {
    return _cards[index].content;
  }

  @override
  void initState() {
    for (int i = 0; i < widget.cards.length; ++i) {
      _cards.add(SwipeItem(
        content: widget.cards[i],
        likeAction: _like,
        nopeAction: _nope,
      ));
    }
    _matchEngine = MatchEngine(swipeItems: _cards);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_isDone
        ? SizedBox(
            height: 640,
            width: 420,
            child: SwipeCards(
              itemBuilder: (BuildContext context, int index) =>
                  _buildCard(index),
              matchEngine: _matchEngine,
              onStackFinished: _done,
            ),
          )
        : Column(children: [
            DefaultTextStyle(
              style: TextStyles.cardHeaderAge,
              child: Text(
                  'All recommendations viewed ($_counter)... please come back later! :)'),
            ),
          ]);
  }
}
