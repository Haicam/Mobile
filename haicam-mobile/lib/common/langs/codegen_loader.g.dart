// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> zh = {
  "title": "欢迎来到海康",
  "mobile_application": "移动应用",
  "end_to_end": "端到端加密",
  "look": "看"
};
static const Map<String,dynamic> en = {
  "title": "Welcome To HaiCams",
  "mobile_application": "Mobile Application",
  "end_to_end": "End-to-End Encryption",
  "look": "LOOK"
};
static const Map<String,dynamic> fr = {
  "title": "Bienvenue sur haicam",
  "mobile_application": "Application mobile",
  "end_to_end": "crypté de bout en bout",
  "look": "REGARDER"
};
static const Map<String,dynamic> ar = {
  "title": "مرحبا بكم في",
  "mobile_application": "تطبيق الهاتف المحمول",
  "end_to_end": "من طرف إلى طرف",
  "look": "بحث"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"zh": zh, "en": en, "fr": fr, "ar": ar};
}
