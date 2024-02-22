import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mixmatch/card.dart';
import 'package:mixmatch/tag.dart';

class UserProfile {
  final String username;
  final String email;
  final String bio;
  // Assuming tags is an array of strings. Adjust if the data type is different.
  final List<String> tags;
  final List<String> images;

  UserProfile({required this.username, required this.email, required this.bio, required this.tags, required this.images});

  factory UserProfile.fromDocument(DocumentSnapshot doc) {
    // Cast the tags as List<dynamic> to ensure compatibility with Firestore arrays.
    // If you're certain that tags will always be a list of strings, you can cast to List<String>.
    // However, be cautious as this can cause runtime errors if the data types don't match.
    return UserProfile(
        username: doc.get('username'),
        email: doc.get('email'),
        bio: doc.get('bio'),
        tags: List.from(doc.get('tags')),
        images: List.from(doc.get('images'))
    );
  }

  static bool loggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  static void ensure() async {
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

    for (int i = 0; i < tags.length; i++) {
      int colorIndex = Random(tags[i].hashCode).nextInt(tagColors.length);
      tagObjs.add(Tag(tagName: tags[i], textColor: Colors.black, tagColor: tagColors.elementAt(colorIndex)));
    }

    return tagObjs;
  }

  CardWidget buildCard() {
    return CardWidget(profileData: this);
  }
}