import 'package:flutter/material.dart';
import '../classes/styles.dart';

class SocialLinksStep extends StatefulWidget {
  const SocialLinksStep({super.key});

  @override
  State<SocialLinksStep> createState() => _SocialLinksStepState();
}

class _SocialLinksStepState extends State<SocialLinksStep> {
  late final String soundcloudLink;
  late final String imgurLink;
  final _soundcloudLinkController = TextEditingController();
  final _imgurLinkController = TextEditingController();

  void _updateSoundcloud() {
    setState(() {
      soundcloudLink = _soundcloudLinkController.text;
    });
  }

  void _updateImgur() {
    setState(() {
      imgurLink = _imgurLinkController.text;
    });
  }

  @override
  void initState() {
    _soundcloudLinkController.addListener(_updateSoundcloud);
    _imgurLinkController.addListener(_updateImgur);
    super.initState();
  }

  @override
  void dispose() {
    _soundcloudLinkController.dispose();
    _imgurLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Theme(
            data: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                  selectionColor: Colors.purple.shade50),
              inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade500),
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              width: 400,
              child: TextFormField(
                controller: _soundcloudLinkController,
                cursorColor: Colors.purple.shade200,
                style: TextStyles.inputText,
                cursorHeight: 26,
                decoration: InputDecoration(
                  hintStyle: TextStyles.inputText,
                  hintText: "Music Track Link",
                ),
              ),
            ),
          ),
          Theme(
            data: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                  selectionColor: Colors.purple.shade50),
              inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade500),
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              width: 400,
              child: TextFormField(
                controller: _imgurLinkController,
                cursorColor: Colors.purple.shade200,
                style: TextStyles.inputText,
                decoration: InputDecoration(
                  hintStyle: TextStyles.inputText,
                  hintText: "Imgur Link",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
