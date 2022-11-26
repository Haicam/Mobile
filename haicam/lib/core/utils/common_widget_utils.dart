import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonWidgetUtils {

  static Widget getSeparator(double paddingTop, double paddingLeft,
      double PaddingRight, double paddingBottom,
        Color color, double height) {
    return new Padding(
        padding: EdgeInsets.only(top: paddingTop, left: paddingLeft, right: PaddingRight),
        child: new Divider(
          color: color,
          thickness: height,
        ));
  }

  static Widget getSeparator2(Color color, double height) {
    return Divider(
      //color: color,
      height: height,
    );
  }

  static Widget getLabel(String text, double
  fontsize,
      FontWeight fontWeight,
      Color textColor) {
    return Text(
      text,
      softWrap: true,
      style: new TextStyle(
          fontSize: fontsize,
          //color: textColor,
          fontWeight: fontWeight),
    );
  }


  static Widget getImageView(String path, double imgWidth, double imgHeight) {
    if(path.toLowerCase().startsWith("http")) {
      return new Image.network(
        path,
        fit: BoxFit.contain,
        width: imgWidth,
        height: imgHeight,
      );
    }
    return new Image.asset(
      path,
      width: imgWidth,
      height: imgHeight,
    );
  }

}