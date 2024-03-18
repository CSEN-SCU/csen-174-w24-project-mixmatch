import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mixmatch/src/classes/profile_args.dart';
import 'package:mixmatch/src/classes/user.dart';
import 'package:mixmatch/src/widgets/profile_args_extractor.dart';
import '../classes/styles.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWidget({super.key, required this.title, required this.icons});
  final String title;
  final List<String> icons;

  @override
  Widget build(BuildContext context) {
    if (icons == const ['back', 'edit']) {
      return Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.only(left: 100.0, right: 100.0, top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // navigate to profile page
                Navigator.pop(context);
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.arrow_back,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: icons[0],
              ),
            ),
            DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.headerText),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // navigate to settings page
                Navigator.pushNamed(context, '/edit-profile');
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.edit,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: icons[1],
              ),
            ),
          ],
        ),
      );
    } else if (icons == const ['profile', 'settings']) {
      /*return Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.only(left: 100.0, right: 100.0, top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.headphones,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: icons[0],
              ),
            ),
            DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.headerText),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.headphones,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: icons[1],
              ),
            ),
          ],
        ),
      );*/
      return Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.only(left: 100.0, right: 100.0, top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // navigate to profile page
                Navigator.pop(context);
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.arrow_back,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: icons[0],
              ),
            ),
            DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.headerText),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/edit-profile');
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.edit,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: icons[1],
              ),
            ),
          ],
        ),
      );
    } else if (icons == const ['back', 'profile']) {
      return Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.only(left: 100.0, right: 100.0, top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // navigate to profile page
                Navigator.pop(context);
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.arrow_back,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: icons[0],
              ),
            ),
            DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.headerText),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfileArgumentsScreen.routeName,
                  arguments: ProfileArguments(UserProfile.currentID())
                );
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.headphones,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: icons[1],
              ),
            ),
          ],
        ),
      );
      } else if (icons == const ['profile', 'edit']) {
      return Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.only(left: 100.0, right: 100.0, top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // navigate to profile page
                Navigator.pushNamed(context, '/edit-profile');
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.edit,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: icons[0],
              ),
            ),
            DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.headerText),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfileArgumentsScreen.routeName,
                  arguments: ProfileArguments(UserProfile.currentID())
                );
              },
              style: ButtonStyles.headerButtons,
              child: Icon(
                Icons.headphones,
                color: Colors.grey.shade900,
                size: 36.0,
                semanticLabel: icons[1],
              ),
            ),
          ],
        ),
      );
      } else {
        return Container(
          decoration: const BoxDecoration(),
          padding: const EdgeInsets.only(left: 100.0, right: 100.0, top: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DefaultTextStyle(
                style: GoogleFonts.inter(textStyle: TextStyles.headerText),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      }
  }

  @override
  Size get preferredSize => const Size.fromHeight(400);
}
