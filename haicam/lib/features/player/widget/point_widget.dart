import 'package:flutter/material.dart';

Widget verticlePoints() {
  return Column(
    children: [
      ClipOval(
        child: Material(
          color: Colors.lightGreen, // Button color
          child: InkWell(
            splashColor: Colors.blue, // Splash color
            onTap: () {},
            child: const SizedBox(
              width: 10,
              height: 10,
              // child: Icon(Icons.circle),
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      ClipOval(
        child: Material(
          color: Colors.lightGreen, // Button color
          child: InkWell(
            splashColor: Colors.blue, // Splash color
            onTap: () {},
            child: const SizedBox(
              width: 10,
              height: 10,
              // child: Icon(Icons.circle),
            ),
          ),
        ),
      ),
    ],
  );
}
