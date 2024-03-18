import 'package:flutter/material.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mixmatch/src/classes/user.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';
import '../classes/styles.dart';

class CardWidget extends StatefulWidget {
  final String uid;
  final UserProfile profileData;
  final Function likeAction;
  final Function dislikeAction;
  const CardWidget({super.key, required this.uid, required this.profileData, required this.likeAction, required this.dislikeAction});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with TickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {

    String imageURL = UserProfile.getDefaultImage();

    if (widget.profileData.images.isNotEmpty) {
      imageURL = widget.profileData.images[0];
    }

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
                    image: Image.network(imageURL).image, fit: BoxFit.cover)),
          ),
        ),
        Positioned(
          height: 320,
          width: 320,
          bottom: 40,
          right: 40,
          child: Container(
            padding: const EdgeInsets.all(20),
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
                //HtmlWidget('<iframe style="border-radius:12px" src="https://open.spotify.com/embed/track/7tfILeIeYQWEa3jdfg7BCA?utm_source=generator" width="100%" height="152" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>'),
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
              onPressed: () {
                widget.dislikeAction(widget.uid);
              },
              style: ButtonStyles.interactionButtons,
              child: Icon(
                Icons.clear,
                color: Colors.grey.shade900,
                size: 40.0,
                semanticLabel: 'dislike',
              )),
        ),
        Positioned(
          height: 86,
          width: 86,
          bottom: 0,
          right: 0,
          child: ElevatedButton(
              onPressed: () {
                widget.likeAction(widget.uid);
              },
              style: ButtonStyles.interactionButtons,
              child: Icon(
                Icons.thumb_up_alt_rounded,
                color: Colors.purple.shade200,
                size: 40.0,
                semanticLabel: 'like',
              )),
        ),
        Positioned(
          height: 86,
          width: 86,
          bottom: 172, // Adjust based on your layout
          right: 0,
          child: ElevatedButton(
              onPressed: () async {
                if (await canLaunch(widget.profileData.trackLink)) {
                  await launch(widget.profileData.trackLink);
                } else {
                  print("Could not launch $widget.profileData.trackLink");
                }
              },
              style: ButtonStyles.interactionButtons, // Ensure ButtonStyles.interactionButtons is correctly defined elsewhere in your code
              child: Icon(
                Icons.open_in_browser,
                color: Colors.green.shade800,
                size: 40.0,
                semanticLabel: 'Open web page',
              )),
        ),
      ],
    );
  }
}
