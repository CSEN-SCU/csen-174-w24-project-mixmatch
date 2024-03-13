import 'package:flutter/material.dart';
// import '../classes/styles.dart';

class TagSelectStep extends StatefulWidget {
  const TagSelectStep({super.key});

  @override
  State<TagSelectStep> createState() => _TagSelectStepState();
}

class _TagSelectStepState extends State<TagSelectStep> {
  static const List<String> tags = [
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
  final List<bool> selectedTags = List.generate(tags.length, (index) => false);

  void _toggleTag(int index) {
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
        children: List<Widget>.generate(tags.length, (int index) {
          return ChoiceChip(
            label: Text(tags[index]),
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
