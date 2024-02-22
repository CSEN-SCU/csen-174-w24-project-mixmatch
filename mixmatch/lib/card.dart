import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mixmatch/user.dart';

import 'styles.dart';
import 'info.dart';

class CardWidget extends StatefulWidget {
  final UserProfile profileData;
  const CardWidget({super.key, required this.profileData});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(40),
          child: Container(
            height: 560,
            width: 340,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade900, blurRadius: 5.0)
                ],
                image: DecorationImage(
                    image: Image.network(widget.profileData.images[0]).image, fit: BoxFit.cover)),
          ),
        ),
        Positioned(
          height: 240,
          width: 320,
          bottom: 60,
          right: 40,
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24)),
                color: Colors.grey.shade100.withOpacity(0.9)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultTextStyle(
                        style: GoogleFonts.inter(
                            textStyle: TextStyles.cardHeaderName),
                        child: Text(widget.profileData.username)),
                    /*DefaultTextStyle(
                        style: GoogleFonts.inter(
                            textStyle: TextStyles.cardHeaderAge),
                        child: Text(widget.profileData.age.toString())),*/
                  ],
                ),
                DefaultTextStyle(
                    style: GoogleFonts.inter(textStyle: TextStyles.cardAbout),
                    child: Text(
                      widget.profileData.bio,
                    )),
                Column(
                  children: [
                    DefaultTextStyle(
                        style: GoogleFonts.inter(
                            textStyle: TextStyles.cardTopTags),
                        child: const Text(
                          'TOP TAGS',
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.profileData.buildTags(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          height: 86,
          width: 86,
          bottom: 0,
          left: 0,
          child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyles.interactionButtons,
              child: Icon(
                Icons.clear,
                color: Colors.grey.shade900,
                size: 40.0,
                semanticLabel: 'leave',
              )),
        ),
        Positioned(
          height: 86,
          width: 86,
          bottom: 0,
          right: 0,
          child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyles.interactionButtons,
              child: Icon(
                Icons.thumb_up_alt_rounded,
                color: Colors.purple.shade200,
                size: 40.0,
                semanticLabel: 'like',
              )),
        ),
      ],
    );
  }
}
