import 'package:flutter/material.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: const <Widget>[
          Text('timeline widget'),
        ],
      ),
    );
  }
}
