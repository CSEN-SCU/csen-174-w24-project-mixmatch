import 'package:flutter/material.dart';
import '../classes/styles.dart';
import '../components/profile_info_step.dart';
import '../components/social_links_step.dart';
import '../components/tags_step.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late int _step;
  late final List<dynamic> _stepWidgets;

  @override
  void initState() {
    _step = 0;
    _stepWidgets = [
      const ProfileInfoStep(),
      const SocialLinksStep(),
      const TagSelectStep(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: const Alignment(0, 0),
        padding: const EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'STEP ${_step + 1} / 3',
              style: TextStyles.bodyText,
            ),
            _stepWidgets[_step],
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                onPressed: () {
                  // _step == 3 ? navigate to fyp
                  setState(() {
                    _step++;
                  });
                },
                style: ButtonStyles.proceedButton,
                child: const Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
