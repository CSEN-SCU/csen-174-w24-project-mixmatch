import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mixmatch/src/widgets/card.dart';
import 'package:mixmatch/src/widgets/tag.dart';

class UserProfile {
  final String username;
  final String email;
  final String bio;
  final String trackLink;
  // Assuming tags is an array of strings. Adjust if the data type is different.
  final List<String> tags;
  final List<String> images;

  UserProfile({required this.username, required this.email, required this.bio, required this.tags, required this.images, required this.trackLink});

  factory UserProfile.fromDocument(DocumentSnapshot doc) {
    // Cast the tags as List<dynamic> to ensure compatibility with Firestore arrays.
    // If you're certain that tags will always be a list of strings, you can cast to List<String>.
    // However, be cautious as this can cause runtime errors if the data types don't match.
    return UserProfile(
        username: doc.get('username'),
        email: doc.get('email'),
        bio: doc.get('bio'),
        tags: List.from(doc.get('tags')),
        images: List.from(doc.get('images')),
        trackLink: doc.get('trackLink')
    );
  }

  static List<String> defaultImages = [
    "https://i.imgur.com/5z47dAF.png",
    "https://i.imgur.com/KYYm2zf.png",
    "https://i.imgur.com/8G6COCN.png"
  ];

  static String getDefaultImage() {
    return defaultImages[Random(DateTime.now().millisecondsSinceEpoch).nextInt(defaultImages.length)];
  }

  String getImage() {
    if (images.isEmpty) return getDefaultImage();

    return images[0];
  }

  static Future<Map<String, UserProfile>> getMatches() async {
    Map<String, UserProfile> matches = <String, UserProfile>{};

    var swipes = (await FirebaseFirestore.instance.collection('swipes').where("swiper", isEqualTo: UserProfile.currentID()).get()).docs;
    for (int i = 0; i < swipes.length; i++) {
      Map<String, dynamic> swipe = swipes[i].data();
      var other = (await FirebaseFirestore.instance.collection('swipes').where("swiper", isEqualTo: swipe["swipee"]).where("swipee", isEqualTo: UserProfile.currentID()).get()).docs;
      if (other.isNotEmpty) {
        matches[swipe["swipee"]] = await UserProfile.profileFromID(swipe["swipee"]);
      }
    }

    return matches;
  }

  static Future<UserProfile> profileFromID(String id) async {
    var document = await FirebaseFirestore.instance.collection('userProfiles').doc(id).get();

    return UserProfile.fromDocument(document);
  }

  static bool loggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<void> ensure() async {
    if (!loggedIn()) return;

    var userProfile = await FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).get();

    if (!userProfile.exists) {
      await FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).set({
        'username': FirebaseAuth.instance.currentUser?.displayName,
        'email': FirebaseAuth.instance.currentUser?.email,
        'bio': "",
        'tags': List<String>.empty(),
        'images': List<String>.empty()
      }, SetOptions(merge: true));
    }
  }

  static Future<UserProfile?> currentProfile() async {
    if (!loggedIn()) return null;

    ensure();

    return UserProfile.fromDocument(await FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).get());
  }

  static String currentID() {
    if (!loggedIn()) return "";

    return FirebaseAuth.instance.currentUser!.uid;
  }

  static Future<String?> idFromUsername(String username) async {
    var query = await FirebaseFirestore.instance.collection('userProfiles').where("username", isEqualTo: username).get();

    if (query.docs.isEmpty) return null;

    return query.docs[0].id;
  }

  static Future<String> usernameFromID(String id) async {
    var user = await FirebaseFirestore.instance.collection('userProfiles').doc(id).get();

    if (!user.exists) return "";

    return user["username"];
  }

  List<Tag> buildTags() {
    List<Tag> tagObjs = [];

    List<Color> tagColors = [
      Colors.red.shade100,
      Colors.orange.shade100,
      Colors.yellow.shade100,
      Colors.green.shade100,
      Colors.blue.shade100,
      Colors.purple.shade100,
      Colors.pink.shade100
    ];

    for (int i = 0; i < tags.length && i < 3; i++) {
      int colorIndex = Random(tags[i].hashCode).nextInt(tagColors.length);
      tagObjs.add(Tag(tagName: tags[i], textColor: Colors.black, tagColor: tagColors.elementAt(colorIndex)));
    }

    return tagObjs;
  }

  Future<CardWidget> buildCard() async {
    return CardWidget(uid: (await UserProfile.idFromUsername(username))!, profileData: this, likeAction: UserProfile.like, dislikeAction: UserProfile.dislike);
  }

  static void like(BuildContext context, String targetUserID) async {
    if (!loggedIn()) return;

    await FirebaseFirestore.instance.collection('swipes').add({
      'swiper': UserProfile.currentID(),
      'swipee': targetUserID,
      'liked': true
    });

    if (await UserProfile.liked(targetUserID, UserProfile.currentID())) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Matched with ${await usernameFromID(targetUserID)}"),
        duration: const Duration(milliseconds: 2500),
      ));
    }
  }

  static void dislike(BuildContext context, String targetUserID) async {
    if (!loggedIn()) return;

    await FirebaseFirestore.instance.collection('swipes').add({
      'swiper': UserProfile.currentID(),
      'swipee': targetUserID,
      'liked': false
    });
  }

  static Future<bool> liked(String swiper, String swipee) async {
      var query = await FirebaseFirestore.instance.collection('swipes').where("swiper", isEqualTo: swiper).where("swipee", isEqualTo: swipee).get();

      return (query.docs.isNotEmpty);
  }
}