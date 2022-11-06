import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Localization {

  Localization(this.locale);

  final Locale locale;
  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  Map<String, String>? _localizedValues;

  Future<void> load() async {
    String jsonStringValues =
    await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return _localizedValues![key];
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<Localization> delegate =
  _LocalizationsDelegate();
}

class _LocalizationsDelegate
    extends LocalizationsDelegate<Localization> {
  const _LocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es','hi','cn','tw'].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) async {
    Localization localization = new Localization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}