import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haicam/common/langs/codegen_loader.g.dart';
import 'package:haicam/common/langs/supported_locale.dart';
import 'package:haicam/features/home/view/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      supportedLocales: LangSupported.all,
      assetLoader: const CodegenLoader(),
      child: Main(),
    ),
  );
}

class Main extends StatelessWidget {
  // This widget is the Main of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
