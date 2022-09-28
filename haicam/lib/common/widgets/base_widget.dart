import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/app_fonts.dart';

//To set padding all sides
Widget addPadding({required Widget child}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: child,
  );
}

//To set custom padding values
Widget addCustomPadding({
  required Widget child,
  required double top,
  required double left,
  required double right,
  required double bottom,
}) {
  return Padding(
    padding:
        EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
    child: child,
  );
}

//To set logo text
Text logoText(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: AppFonts.logoSize,
      fontWeight: FontWeight.w900,
    ),
  );
}

//To set body light text
Text bodyLightText(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: AppColors.lightGrey2,
      fontSize: AppFonts.bodySizePrimary,
      fontWeight: FontWeight.w400,
    ),
  );
}

//To set app bar title
Text appBarTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
        // color: AppColors.regularDarkFont,
        fontSize: AppFonts.appBarTitle,
        fontWeight: FontWeight.w400),
  );
}

// To set body dark text
Text bodyDarkText(String title) {
  return Text(
    title,
    style: const TextStyle(
        // color: AppColors.regularDarkFont,
        fontSize: AppFonts.appBarTitle,
        fontWeight: FontWeight.w400),
  );
}

// To set header title
Text headerTitleText(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: AppFonts.headingSize,
      fontWeight: FontWeight.bold,
    ),
  );
}

// To set header medium text
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

// To set primary button
Widget appPrimaryButton(String title, Function function) {
  return Padding(
    key: Key(title),
    padding: const EdgeInsets.all(8),
    child: SizedBox(
      height: 50, //height of button
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColors.primary,
            //background color of button
            side: const BorderSide(
              width: 1,
              color: AppColors.primary,
            ),
            //border width and color
            elevation: 3,
            //elevation of button
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(10) //content padding inside button
            ),
        onPressed: () {
          function();
        },
        child: Text(
          title,
          style: const TextStyle(fontSize: AppFonts.buttonTextSize),
        ),
      ),
    ),
  );
}

// To set regular space
Widget regularSpace() {
  return const SizedBox(
    height: 10,
  );
}

// To set width
Widget addHeight(double value) {
  return SizedBox(
    height: value,
  );
}

// To set width
Widget addWidth(double value) {
  return SizedBox(
    width: value,
  );
}

// To set primary text field
Widget appPrimaryTextField(
    String title, bool obscureText, IconData prefixIcon, String key) {
  return SizedBox(
    width: 350,
    child: TextField(
      minLines: 1,
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

// To set horizontal bar
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

// To set menu normal text
Text menuNormalText(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: AppColors.black,
      fontSize: AppFonts.regularSize,
      fontWeight: FontWeight.w400,
    ),
  );
}

// To set timestamp
Text textTimeStamp(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: AppFonts.smallSize,
      fontWeight: FontWeight.w400,
    ),
  );
}

// To set datetamp date
Text textDateStamp(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: AppFonts.smallSize,
      fontWeight: FontWeight.w400,
    ),
  );
}
