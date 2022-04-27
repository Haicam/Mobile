import 'package:flutter/material.dart';

class LangPopupItem {
  LangPopupItem({this.title, this.icon});

  String? title;
  IconData? icon;
}

List<LangPopupItem> choice = <LangPopupItem>[
  LangPopupItem(title: 'ENGLISH', icon: Icons.language),
  LangPopupItem(title: '中国人', icon: Icons.language),
  LangPopupItem(title: 'FRANÇAISE', icon: Icons.language),
  LangPopupItem(title: 'العربية', icon: Icons.language),
];
