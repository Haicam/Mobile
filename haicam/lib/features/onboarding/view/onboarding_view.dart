import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  validateAndSubmit() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: const Image(
          image: AssetImage('assets/images/haicam_logo.png'),
        ),
      ),
    );
  }
}
