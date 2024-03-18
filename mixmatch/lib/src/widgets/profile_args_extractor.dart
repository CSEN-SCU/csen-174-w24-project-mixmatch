// A Widget that extracts the necessary arguments from
// the ModalRoute.
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mixmatch/src/classes/profile_args.dart';
import 'package:mixmatch/src/classes/user.dart';
import 'package:mixmatch/src/pages/profile.dart';

class ProfileArgumentsScreen extends StatelessWidget {
  const ProfileArgumentsScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ProfileArguments;


    if (args.id == UserProfile.currentID()) {
      return ProfilePage(title: "Profile",
        icons: const ['back', 'edit'],
        userID: args.id,
      );
    }
    else {
      return ProfilePage(title: "Profile",
        icons: const ['back', 'profile'],
        userID: args.id,
      );
    }
     /*Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );*/
  }
}