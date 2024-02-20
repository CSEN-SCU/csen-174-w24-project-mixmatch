import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  final String username;
  final String email;
  // Assuming tags is an array of strings. Adjust if the data type is different.
  final List<dynamic> tags;

  UserProfile({required this.username, required this.email, required this.tags});

  factory UserProfile.fromDocument(DocumentSnapshot doc) {
    // Cast the tags as List<dynamic> to ensure compatibility with Firestore arrays.
    // If you're certain that tags will always be a list of strings, you can cast to List<String>.
    // However, be cautious as this can cause runtime errors if the data types don't match.
    return UserProfile(
        username: doc.get('username'),
        email: doc.get('email'),
        tags: List.from(doc.get('tags'))
    );
  }

  static void ensure() async {
    User? currUser = FirebaseAuth.instance.currentUser;

    if (currUser == null) return;

    var userProfile = await FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).get();

    if (!userProfile.exists) {
      await FirebaseFirestore.instance.collection('userProfiles').doc(FirebaseAuth.instance.currentUser?.uid).set({
        'username': currUser.displayName,
        'email': currUser.email
      }, SetOptions(merge: true));
    }
  }
}