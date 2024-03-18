import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mixmatch/src/classes/profile_args.dart';
import 'package:mixmatch/src/widgets/profile_args_extractor.dart';
import '../classes/user.dart';
import '../classes/styles.dart';

class MatchWidget extends StatelessWidget {
  final String id;
  final UserProfile user;
  const MatchWidget({super.key, required this.id, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: () {
          // open profile of given user
          
          Navigator.pushNamed(context, ProfileArgumentsScreen.routeName,
            arguments: ProfileArguments(id)
          );
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
                child: ClipOval(
                  child: Image(
                    image: Image.network(user.getImage()).image,//AssetImage('assets/images/metro-in-studio.png'),
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
                    children: user.buildTags() /* [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Builder(builder: (BuildContext context) {
                          if (user.tags.length > 0) {
                            return Tag(
                              tagName: user.tags[0],
                              tagColor: Colors.pink.shade100,
                              textColor: Colors.pink.shade400
                            );
                          }
                          return const Text("No Tags!");
                        },
                      )),
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
                    ],*/
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
