import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mixmatch/src/classes/user.dart';
// import '../classes/styles.dart';

class TagSelectStep extends StatefulWidget {
  const TagSelectStep({super.key});

  @override
  State<TagSelectStep> createState() => _TagSelectStepState();
}

class _TagSelectStepState extends State<TagSelectStep> {
  static const List<String> valid_tags = [
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
  final List<bool> selectedTags = List.generate(valid_tags.length, (index) => false);

  void _toggleTag(int index) {
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
      selectedTags[index] = !selectedTags[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 500,
      padding: const EdgeInsets.symmetric(vertical: 100),
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
  }
}
