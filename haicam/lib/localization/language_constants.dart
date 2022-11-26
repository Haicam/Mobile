import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prac_haicam/localization/localization.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String SPANISH = 'es';
const String TRADITIONAL_CHINESE = 'tw';
const String SIMPLIFIED_CHINESE = 'cn';
const String HINDI = 'hi';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  //String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "ar";

  return _locale(languageCode);
}



Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case SPANISH:
      return Locale(SPANISH, "ES");
    case TRADITIONAL_CHINESE:
      return Locale(TRADITIONAL_CHINESE, "zh");
    case SIMPLIFIED_CHINESE:
      return Locale(SIMPLIFIED_CHINESE, "zh");
    case HINDI:
      return Locale(HINDI, "IN");
    default:
      return Locale(ENGLISH, 'US');
  }
}

String? getTranslated(BuildContext context, String key) {
  return Localization.of(context)!.translate(key);
}