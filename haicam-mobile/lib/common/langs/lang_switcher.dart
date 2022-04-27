import 'package:flutter/material.dart';
import 'package:haicam/common/langs/lang_item.dart';

class LangSwitcher {
  static changeLangByItem(context, LangPopupItem item) {
    switch (item.title) {
      case "ENGLISH":
        context.setLocale(const Locale('en'));
        break;
      case "中国人":
        context.setLocale(const Locale('zh'));
        break;
      case "FRANÇAISE":
        context.setLocale(const Locale('fr'));
        break;
      case "العربية":
        context.setLocale(const Locale('ar'));
        break;
      default:
        context.setLocale(const Locale('en'));
    }
  }
}
