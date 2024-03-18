import 'package:flutter/widgets.dart';

abstract class OnboardingWidgetState<T> extends State<StatefulWidget> {
  bool validate();
}