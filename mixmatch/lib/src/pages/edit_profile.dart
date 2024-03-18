import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mixmatch/src/classes/styles.dart';
import 'package:mixmatch/src/classes/user.dart';
import 'package:mixmatch/src/components/header.dart';
import 'package:mixmatch/src/widgets/tag.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage(
      {super.key,
      required this.title,
      required this.icons,
      required this.userID});
  final String title;
  final List<String> icons;
  final String userID;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  late final Future<UserProfile> userFuture = UserProfile.profileFromID(widget.userID);

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

  late final String bio;

  List<String> valid_tags = [
      "Producer",
      "DJ",
      "A&R",
      "LookingForWork",
      "Singer",
      "Hip-Hop",
      "R&B",
      "Country",
      "Rap",
    ];

  void _toggleTag(int index) {
      List<bool> selectedTags = List.generate(valid_tags.length, (index) => false);

      FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
        UserProfile prof = UserProfile.fromDocument(value);
        List<String> tags = prof.tags;
        if (selectedTags[index]) {
          tags.add(valid_tags[index]);
        }
        else {
          tags.remove(valid_tags[index]);
        }
        
        FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).set({
          'tags': tags,
        }, SetOptions(merge: true));
      });
      
      setState(() {
        //TODO: Make changes visible.
        selectedTags[index] = !selectedTags[index];
      });
    }

  @override
  Widget build(BuildContext context) {
    /*Widget username = FutureBuilder<UserProfile>(
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
    );*/

    Widget current_bio = FutureBuilder<UserProfile>(
      builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data);
          return Column(children: [
            DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.profileBioText),
              child: const Text(
                "Bio",
                textAlign: TextAlign.center,
              )
            ),
            const Padding(padding: EdgeInsets.only(top: 25)),
            TextFormField(
              cursorColor: Colors.purple.shade200,
              style: TextStyles.inputText,
              minLines: 3,
              maxLines: 5,
              maxLength: 150,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintStyle: TextStyles.inputText,
                hintText: "Bio",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: ((newValue) async {
                await FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).set({
                  'bio': newValue,
                }, SetOptions(merge: true));
              }),
              initialValue: snapshot.data!.bio,
            )
          ]);
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

      final List<bool> selectedTags = List.generate(valid_tags.length, (index) => false);

    Widget tags = FutureBuilder<UserProfile>(
      builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
        if (snapshot.hasData) {
          for (int i = 0; i < selectedTags.length; i++) {
            selectedTags[i] = snapshot.data!.tags.contains(valid_tags[i]);
          }
          //print(snapshot.data);
          return Container(
            height: 300,
            width: 500,
            //padding: const EdgeInsets.symmetric(vertical: 100),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 30.0, // gap between adjacent chips
              runSpacing: 30.0, // gap between lines
              children: List<Widget>.generate(valid_tags.length, (int index) {
                return ChoiceChip(
                  label: Text(valid_tags[index]),
                  selected: selectedTags[index],
                  selectedColor: Colors.purple.shade200,
                  onSelected: (bool selected) {
                    _toggleTag(index);
                  },
                );
              }),
            ),
          );
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
      builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data);
          return Column(children: [
            buildImage(snapshot.data!),
            const Padding(padding: EdgeInsets.only(top: 25)),
            DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.profileBioText),
              child: const Text(
                "Image URL",
                textAlign: TextAlign.center,
              )
            ),
            const Padding(padding: EdgeInsets.only(top: 25)),
            TextFormField(
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
                onSaved: ((newValue) async {
                  await FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).set({
                    'images': [ newValue ],
                  }, SetOptions(merge: true));
                }),
                initialValue: snapshot.data!.images[0],
              )
          ]);
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

    Widget track = FutureBuilder<UserProfile>(
      builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data);
          return Column(children: [
            DefaultTextStyle(
              style: GoogleFonts.inter(textStyle: TextStyles.profileBioText),
              child: const Text(
                "Top Track URL",
                textAlign: TextAlign.center,
              )
            ),
            const Padding(padding: EdgeInsets.only(top: 25)),
            TextFormField(
              cursorColor: Colors.purple.shade200,
              style: TextStyles.inputText,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintStyle: TextStyles.inputText,
                hintText: "Track",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
              ),
              onSaved: ((newValue) async {
                await FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).set({
                  'trackLink': newValue,
                }, SetOptions(merge: true));
              }),
              initialValue: snapshot.data!.trackLink,
            )
          ]);
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

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: HeaderWidget(title: widget.title, icons: widget.icons),
      body: Form(
        key: _formKey,
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 50),
                child: image,
              ),
              /*Center(child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: DefaultTextStyle(
                  style: GoogleFonts.inter(textStyle: TextStyles.profileNameText),
                  child: username//Text(widget.userID.username),
                ),
              )),*/
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: current_bio
                /*DefaultTextStyle(
                  style: GoogleFonts.inter(textStyle: TextStyles.profileBioText),
                  child: bio,
                ),*/
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: track
                /*DefaultTextStyle(
                  style: GoogleFonts.inter(textStyle: TextStyles.profileBioText),
                  child: bio,
                ),*/
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                  child: tags,
                ),
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              /*Navigator.pushNamed(context, ProfileArgumentsScreen.routeName,
                arguments: ProfileArguments(UserProfile.currentID())
              );*/
              //Navigator.pushNamed(context, '/fyp');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Your changes have been saved."),
                duration: const Duration(milliseconds: 2500),
              ));
            }
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.7)
              ],
              stops: const [0.3, 1.0],
            ),
          ),
          child: Icon(
            Icons.save,
            color: Colors.grey.shade900,
            size: 25.0,
            semanticLabel: 'save',
          )
        )
      )
    );
  }
}
