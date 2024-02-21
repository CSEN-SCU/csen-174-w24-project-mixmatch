import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'swipe_page.dart'; // Make sure this import points to your SwipePage file

class ProfilePage extends StatefulWidget {
  final String documentId; // Assuming you pass the document ID to this widget

  const ProfilePage({Key? key, required this.documentId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _tagsController; // A single string to simplify, separate tags by commas

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _tagsController = TextEditingController();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    var docSnapshot = await FirebaseFirestore.instance.collection('userProfiles').doc(widget.documentId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      setState(() {
        _usernameController.text = data['username'];
        _tagsController.text = data['tags'].join(', '); // Assuming tags is a List<String>
      });
    }
  }

  Future<void> _saveUserProfile() async {
    // Convert tags from comma-separated string to List<String>
    List<String> tagsList = _tagsController.text.split(',').map((tag) => tag.trim()).toList();

    // Use set with merge: true to update or create the document
    await FirebaseFirestore.instance.collection('userProfiles').doc(widget.documentId).set({
      'username': _usernameController.text,
      'tags': tagsList,
    }, SetOptions(merge: true));

    // Navigate to the SwipePage after saving the profile
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SwipePage(title: "Swipe!")));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tagsController,
                decoration: InputDecoration(labelText: 'Tags (comma separated)'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveUserProfile();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
