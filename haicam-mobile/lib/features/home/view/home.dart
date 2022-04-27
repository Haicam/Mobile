import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:haicam/common/langs/lang_item.dart';
import 'package:haicam/common/langs/locale_keys.g.dart';
import 'package:haicam/common/utils/app_font.dart';
import 'package:haicam/common/utils/helper_widgets.dart';

class Home extends StatefulWidget {
  int findSquare(int number) {
    return number * number;
  }

  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: non_constant_identifier_names
  LangPopupItem selected_item = choice[0];

  void _select(LangPopupItem item) {
    setState(() {
      selected_item = item;
    });
    //LangSwitcher.changeLangByItem(context, item);

    switch (selected_item.title) {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: state.theme,
      home: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.blue,
          title: Text(
            LocaleKeys.title.tr(),
          ),
          actions: <Widget>[
            Switch(value: false, onChanged: (val) {}),
            PopupMenuButton<LangPopupItem>(
              elevation: 3.0,
              initialValue: selected_item,
              onSelected: _select,
              icon: const Icon(Icons.language),
              itemBuilder: (BuildContext context) {
                return choice.map((LangPopupItem choice) {
                  return PopupMenuItem<LangPopupItem>(
                    value: choice,
                    child: Text(choice.title.toString()),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: _buildMainView(),
      ),
    );
  }
}

Widget _buildMainView() {
  return Center(
    child: ListView(
      children: <Widget>[
        lookBuildContainer(),
        addVerticalSpace(20),
        mobBildContainer(),
        addVerticalSpace(20),
        endBuildContainer(),
      ],
    ),
  );
}

Widget lookBuildContainer() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(10),
    child: Text(
      LocaleKeys.look.tr(),
      style: const TextStyle(
          // color: AppColors.primary,
          fontWeight: FontWeight.w500,
          fontSize: AppFonts.headlineSize),
    ),
  );
}

Widget mobBildContainer() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(10),
    child: Text(
      LocaleKeys.mobile_application.tr(),
      style: const TextStyle(
        // color: AppColors.primary,
        fontSize: AppFonts.titleSize,
      ),
    ),
  );
}

Widget endBuildContainer() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(10),
    child: Text(
      LocaleKeys.end_to_end.tr(),
      style: const TextStyle(
        fontSize: AppFonts.subHeaderSize,
      ),
    ),
  );
}
