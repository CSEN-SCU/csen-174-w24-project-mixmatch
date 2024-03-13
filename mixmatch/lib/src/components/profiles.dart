import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mixmatch/src/classes/user.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:swipe_to/swipe_to.dart';

import '../widgets/card.dart';
import '../classes/styles.dart';

class ProfileRecs extends StatefulWidget {
  final List<CardWidget>? cards;

  const ProfileRecs({super.key, required this.cards});

  @override
  State<ProfileRecs> createState() => _ProfileRecsState();
}

class _ProfileRecsState extends State<ProfileRecs> {
  late final List<SwipeItem> _cards = <SwipeItem>[];
  late final MatchEngine _matchEngine;
  late int _counter = 0;
  bool _isDone = false;

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
    print("Init!");
    for (int i = 0; i < widget.cards!.length; ++i) {
      _cards.add(SwipeItem(
        content: widget.cards![i],
        swipeeID: widget.cards![i].uid,
        likeAction: (String id) => { setState(() {
          widget.cards![i].likeAction.call(id);
          
        }) },
        nopeAction: (String id) => { setState(() { widget.cards![i].dislikeAction.call(id); }) },
      ));
    }

    _matchEngine = MatchEngine(swipeItems: _cards);
    // if (_cards.isNotEmpty)
    //   _topCard = _cards[0].content;
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
              child: const Text(
                  'All recommendations viewed... please come back later! :)'),
            ),
          ]);
  }
}
