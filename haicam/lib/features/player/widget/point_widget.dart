import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';

Widget verticlePoints() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ClipOval(
        child: Material(
          color: AppColors.darkGrey, // Button color
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
          color: AppColors.darkGrey, // Button color
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
}//end verticlePoints
