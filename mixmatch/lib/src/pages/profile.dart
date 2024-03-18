import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mixmatch/src/classes/styles.dart';
import 'package:mixmatch/src/classes/user.dart';
import 'package:mixmatch/src/components/header.dart';
import 'package:mixmatch/src/components/footer.dart';
import 'package:mixmatch/src/widgets/tag.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(
      {super.key,
      required this.title,
      required this.icons,
      required this.userID});
  final String title;
  final List<String> icons;
  final String userID;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
    userFuture = UserProfile.profileFromID(widget.userID);
  }

  late Future<UserProfile> userFuture;

  Widget buildTags(UserProfile user) {
    const double tagWidth = 100;
    const double tagHeight = 50;
    final double screenWidth = MediaQuery.of(context).size.width;
    const int numColumns = 3; // Number of tags per row
    final double totalPadding =
        screenWidth - (numColumns * tagWidth); // Total horizontal padding
    final double sidePadding = totalPadding / 2; // Padding on each side

    return GridView.builder(
      padding: EdgeInsets.only(
          left: sidePadding, right: sidePadding, top: 25, bottom: 25),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numColumns,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: (tagWidth / tagHeight), // Assuming tag height is 50
      ),
      itemCount: user.tags.length,
      itemBuilder: (context, index) {
        return Tag(
          tagName: user.tags[index],
          tagColor: Colors.purple.shade100,
          textColor: Colors.purple.shade400,
        );
      },
    );
  }

  Widget buildImage(UserProfile user) {
    
    String url = UserProfile.getDefaultImage();
    if (user.images.isNotEmpty) {
      url = user.images[0];
    }

    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        // Rounded corners
        borderRadius: BorderRadius.circular(24.0),
        // Drop shadow
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 5), // Changes position of shadow
          ),
        ],
        image: DecorationImage(image: Image.network(url).image, fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget username = FutureBuilder<UserProfile>(
      builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data);
          return Text(snapshot.data!.username);
        } else if (snapshot.hasError) {
            return DefaultTextStyle(
            style: TextStyles.cardHeaderAge,
            child: Text(
                'An error has occurred...\n\n${snapshot.error}'),
          );
        } else {
          return DefaultTextStyle(
            style: TextStyles.cardHeaderAge,
            child: const Text(
                ''),
          );
        }
      },
      future: userFuture
    );

    Widget bio = FutureBuilder<UserProfile>(
      builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data);
          return Text(snapshot.data!.bio);
        } else if (snapshot.hasError) {
            return DefaultTextStyle(
            style: TextStyles.cardHeaderAge,
            child: Text(
                'An error has occurred...\n\n${snapshot.error}'),
          );
        } else {
          return DefaultTextStyle(
            style: TextStyles.cardHeaderAge,
            child: const Text(
                ''),
          );
        }
      },
      future: userFuture
    );

    Widget tags = FutureBuilder<UserProfile>(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data);
          return buildTags(snapshot.data!);
        } else if (snapshot.hasError) {
            return DefaultTextStyle(
            style: TextStyles.cardHeaderAge,
            child: Text(
                'An error has occurred...\n\n${snapshot.error}'),
          );
        } else {
          return DefaultTextStyle(
            style: TextStyles.cardHeaderAge,
            child: const Text(
                ''),
          );
        }
      },
      future: userFuture
    );

    Widget image = FutureBuilder<UserProfile>(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data);
          return buildImage(snapshot.data!);
        } else if (snapshot.hasError) {
            return DefaultTextStyle(
            style: TextStyles.cardHeaderAge,
            child: Text(
                'An error has occurred...\n\n${snapshot.error}'),
          );
        } else {
          return DefaultTextStyle(
            style: TextStyles.cardHeaderAge,
            child: const Text(
                'Loading user information...'),
          );
        }
      },
      future: userFuture
    );

    return Scaffold(
      appBar: HeaderWidget(title: widget.title, icons: widget.icons),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 50),
              child: image,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: DefaultTextStyle(
                style: GoogleFonts.inter(textStyle: TextStyles.profileNameText),
                child: username//Text(widget.userID.username),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: DefaultTextStyle(
                style: GoogleFonts.inter(textStyle: TextStyles.profileBioText),
                child: bio,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                child: tags,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const Footer(
        page: 'profile',
      ),
    );
  }
}
