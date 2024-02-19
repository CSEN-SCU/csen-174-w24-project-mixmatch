import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String username;
  // Assuming tags is an array of strings. Adjust if the data type is different.
  final List<dynamic> tags;

  UserProfile({required this.username, required this.tags});

  factory UserProfile.fromDocument(DocumentSnapshot doc) {
    // Cast the tags as List<dynamic> to ensure compatibility with Firestore arrays.
    // If you're certain that tags will always be a list of strings, you can cast to List<String>.
    // However, be cautious as this can cause runtime errors if the data types don't match.
    return UserProfile(
        username: doc.get('username'),
        tags: List.from(doc.get('tags'))
    );
  }
}