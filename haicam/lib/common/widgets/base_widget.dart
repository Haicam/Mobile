import 'package:flutter/material.dart';
import 'package:prac_haicam/common/utils/app_colors.dart';
import 'package:prac_haicam/common/utils/app_font.dart';

Text logoText(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: AppFonts.logoSize,
      fontWeight: FontWeight.w900,
      color: AppColors.primary,
    ),
  );
}

Text bodyLightText(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: AppColors.regularLightFont,
      fontSize: AppFonts.smallSize,
      fontWeight: FontWeight.w400,
    ),
  );
}

Text bodyDarkText(String title) {
  return Text(
    title,
    style: const TextStyle(
        color: AppColors.regularDarkFont,
        fontSize: AppFonts.bodySizePrimary,
        fontWeight: FontWeight.w400),
  );
}

Text headerTitleText(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: AppColors.darkGreen,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text subHeadingMediumText(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: AppColors.primary,
      fontSize: AppFonts.subHeadingSmallSize,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget appPrimaryButton(String title, Function function) {
  return Padding(
    key: Key(title),
    padding: const EdgeInsets.all(8),
    child: SizedBox(
      height: 40, //height of button
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColors.primary, //background color of button
            side: const BorderSide(
              width: 1,
              color: AppColors.primary,
            ), //border width and color
            elevation: 3, //elevation of button
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(10) //content padding inside button
            ),
        onPressed: () {
          //code to execute when this button is pressed.
        },
        child: Text(
          title,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    ),
  );
}

Widget regularSpace() {
  return const SizedBox(
    height: 10,
  );
}

Widget addHeight(double value) {
  return SizedBox(
    height: value,
  );
}

Widget addWidth(double value) {
  return SizedBox(
    width: value,
  );
}

Widget appPrimaryTextField(
    String title, bool obscureText, IconData prefixIcon, String key) {
  return SizedBox(
    width: 350,
    child: TextField(
      key: Key(key),
      obscureText: obscureText,
      style: const TextStyle(fontSize: 12, height: 0.5),
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: AppColors.lightGrey2),
        labelText: title,
        prefixIcon: Icon(
          prefixIcon,
          size: 18,
          color: AppColors.lightGrey2,
        ),
        suffixIconColor: AppColors.lightGrey2,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.lightGrey2,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightGrey2, width: 0.5),
        ),
      ),
    ),
  );
}

Widget horizentalBar() {
  return Container(
    height: 2,
    width: 380,
    // margin: const EdgeInsets.all(15.0),
    // padding: const EdgeInsets.all(3.0),
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.grey,
      ),
    ),
  );
}
