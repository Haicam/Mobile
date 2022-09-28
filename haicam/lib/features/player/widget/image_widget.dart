import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';

Widget eventImage(String image) {
  return Column(
    children: [
      Row(
        children: [
          ClipPath(
            clipper: ArrowClipper(10, 0, Edge.LEFT),
            child: Container(
              height: 20,
              color: AppColors.darkGrey,
              child: const Center(
                  child: Text(
                "H",
                style: TextStyle(
                  color: AppColors.darkGrey,
                ),
              )),
            ),
          ),
          Container(
            height: 90.0,
            width: 140.0,
            color: AppColors.darkGrey,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(40.0),
                  //   topRight: Radius.circular(40.0),
                  // ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: ExactAssetImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Center(
                    // child: Text("test"),
                    ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
