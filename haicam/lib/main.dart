import 'package:flutter/material.dart';
import 'package:prac_haicam/features/onboarding/view/onboarding_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haicam-App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Onboarding(),
    );
  }
}
