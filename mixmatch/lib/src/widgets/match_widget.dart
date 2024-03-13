import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/user.dart';
import '../classes/styles.dart';
import '../widgets/tag.dart';

class MatchWidget extends StatelessWidget {
  final UserProfile user;
  const MatchWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: () {
          // open profile of given user
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.transparent,
          shadowColor: Colors.grey.shade300,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          padding: EdgeInsets.zero,
          elevation: 20,
        ),
        child: Container(
          width: 450,
          height: 110,
          padding: const EdgeInsets.only(left: 25, right: 25),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
                top: BorderSide(color: Colors.grey.shade200),
                right: BorderSide(color: Colors.grey.shade200),
                left: BorderSide(color: Colors.grey.shade200)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(50, 226, 138, 222),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: const ClipOval(
                  child: Image(
                    image: AssetImage('assets/images/metro-in-studio.png'),
                    width: 65,
                    height: 65,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                    style:
                        GoogleFonts.inter(textStyle: TextStyles.matchNameText),
                    child: Text(
                      user.username,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 7)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Tag(
                            tagName: user.tags[0],
                            tagColor: Colors.pink.shade100,
                            textColor: Colors.pink.shade400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Tag(
                            tagName: user.tags[1],
                            tagColor: Colors.blue.shade100,
                            textColor: Colors.blue.shade400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Tag(
                            tagName: user.tags[2],
                            tagColor: Colors.green.shade100,
                            textColor: Colors.green.shade400),
                      ),
                    ],
                  )
                ],
              ),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 35,
                color: Colors.grey.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
