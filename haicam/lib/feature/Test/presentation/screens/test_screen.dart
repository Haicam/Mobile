import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          child: Column(
            children: const <Widget>[
              Text(
                "In Progress",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                // textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
