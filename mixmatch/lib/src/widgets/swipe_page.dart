import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/user.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    // Adjust the collection name and document ID as necessary
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc('QFFg6KUkPdrGDbZSmJl2') // Specify the document ID
        .get();

    if (docSnapshot.exists) {
      setState(() {
        userProfile = UserProfile.fromDocument(docSnapshot);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: userProfile == null
            ? CircularProgressIndicator() // Display a loading indicator while data is fetching
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        //userProfile!.imageUrl
                        "https://www.careersinmusic.com/wp-content/uploads/2019/11/what-does-a-music-producer-do.jpg", // Use a real image URL,
                        height: 400.0,
                        width: 300.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      userProfile!.username,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 10),
                    Text(
                      userProfile!.tags[0],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          child: Text("X"),
                          onPressed: () {
                            // Implement dislike action
                          },
                        ),
                        ElevatedButton(
                          child: Text("✓"),
                          onPressed: () {
                            // Implement like action
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
