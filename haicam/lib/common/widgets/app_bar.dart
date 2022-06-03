import 'package:flutter/material.dart';

Widget buildAppBar() {
  return AppBar(
    toolbarHeight: 100,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        // color: Colors.black,
        size: 18,
      ),
      // onPressed: () => Navigator.of(context).pop(),
      onPressed: () {},
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    iconTheme: const IconThemeData(),
    // title: Center(child: bodyDarkText("")),
  );
}
