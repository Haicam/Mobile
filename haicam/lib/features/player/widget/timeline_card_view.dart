import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/app_fonts.dart';
import 'package:prac_haicam/core/utils/app_images.dart';
import 'package:prac_haicam/features/player/widget/image_widget.dart';
import 'package:prac_haicam/features/player/widget/point_widget.dart';

class TimeLineCard extends StatelessWidget {
  final double? width;
  final double? height;

  TimeLineCard({
    @required this.width,
    @required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return buildSimpleCard(context);
  }

  Container buildSimpleCard(BuildContext context) {
    double barCardHeight = 90;
    //white cards
    return Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 16, 8, 8),
                        child: Text(''),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: width! * 0.05,
                        height: barCardHeight,
                        // color: AppColors.darkGreen,
                        child: verticlePoints(),
                      ),
                      Container(
                        width: width! * 0.5,
                        height: barCardHeight,
                        padding: const EdgeInsets.only(left: 10),
                        child: eventImage(
                          appCamOneIcon,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}