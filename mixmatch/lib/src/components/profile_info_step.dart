import 'package:flutter/material.dart';
import '../classes/styles.dart';

class ProfileInfoStep extends StatefulWidget {
  const ProfileInfoStep({super.key});

  @override
  State<ProfileInfoStep> createState() => _ProfileInfoStepState();
}

class _ProfileInfoStepState extends State<ProfileInfoStep> {
  late final String firstName;
  late final String lastName;
  late final String bio;
  final _formKey = GlobalKey<FormState>();
  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  final _bioController = TextEditingController();

  void _updateFirst() {
    setState(() {
      firstName = _firstController.text;
    });
  }

  void _updateLast() {
    setState(() {
      lastName = _lastController.text;
    });
  }

  void _updateBio() {
    setState(() {
      bio = _bioController.text;
    });
  }

  @override
  void initState() {
    _firstController.addListener(_updateFirst);
    _firstController.addListener(_updateLast);
    _bioController.addListener(_updateBio);
    super.initState();
  }

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Theme(
              data: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                    selectionColor: Colors.purple.shade50),
                inputDecorationTheme: InputDecorationTheme(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25),
                width: 300,
                child: TextFormField(
                  controller: _firstController,
                  cursorColor: Colors.purple.shade200,
                  style: TextStyles.inputText,
                  textCapitalization: TextCapitalization.words,
                  cursorHeight: 26,
                  decoration: InputDecoration(
                    hintStyle: TextStyles.inputText,
                    hintText: "First",
                  ),
                ),
              ),
            ),
            Theme(
              data: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                    selectionColor: Colors.purple.shade50),
                inputDecorationTheme: InputDecorationTheme(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25),
                width: 300,
                child: TextFormField(
                  controller: _lastController,
                  cursorColor: Colors.purple.shade200,
                  style: TextStyles.inputText,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintStyle: TextStyles.inputText,
                    hintText: "Last",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                  ),
                ),
              ),
            ),
            Theme(
              data: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                    selectionColor: Colors.purple.shade50),
                inputDecorationTheme: InputDecorationTheme(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25),
                width: 300,
                child: TextFormField(
                  controller: _bioController,
                  cursorColor: Colors.purple.shade200,
                  style: TextStyles.inputText,
                  minLines: 2,
                  maxLines: 3,
                  maxLength: 50,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
