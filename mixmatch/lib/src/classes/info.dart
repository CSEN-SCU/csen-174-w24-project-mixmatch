import 'package:flutter/material.dart';
import '../widgets/tag.dart';

class Profile {
  const Profile(this.name, this.age, this.about, this.tags, this.images);
  final String name;
  final int age;
  final String about;
  final List<Tag> tags;
  final List<ImageProvider> images;
}
