import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/features/home/view/home_view.dart';

import 'package:prac_haicam/features/setting/model/app_setting_model.dart';
import 'package:prac_haicam/features/theme/bloc/theme_bloc.dart';
import 'package:prac_haicam/features/theme/theme.dart';

class AppSettingView extends StatefulWidget {
  const AppSettingView({Key? key}) : super(key: key);

  @override
  State<AppSettingView> createState() => _AppSettingViewState();
}

class _AppSettingViewState extends State<AppSettingView> {
  bool _isThemeSwitch = false;
  List<Menu> data = [];

//init state of view
  @override
  void initState() {
    for (var element in dataList) {
      data.add(Menu.fromJson(element));
    }
    super.initState();
  }

// This widget is the root of view.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            // color: Colors.black,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(),
        title: Center(child: appBarTitle("App Setting")),
      ),
      body: buildMainView(),
    );
  }

// Build main view
  Widget buildMainView() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            buildThemeRow(),
            buildMoreRow(),
          ],
        ),
      ),
    );
  }

//  build theme setting row view
  Widget buildThemeRow() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.darkGrey,
            width: 0.2,
          ),
          top: BorderSide(
            color: AppColors.darkGrey,
            width: 0.2,
          ),
        ),
      ),
      child: SwitchListTile(
        tileColor: AppColors.lightGrey,
        value: _isThemeSwitch,
        onChanged: (value) {
          _isThemeSwitch = value;
          setState(() {});
          if (_isThemeSwitch) {
            BlocProvider.of<ThemeBloc>(context)
                .add(ThemeEvent(theme: AppTheme.darkTheme));
          } else {
            BlocProvider.of<ThemeBloc>(context)
                .add(ThemeEvent(theme: AppTheme.lightTheme));
          }
        },
        title: const Text("Theme Dark/Light"),
      ),
    );
  }

// Build more row view
  ListView buildMoreRow() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => _buildList(data[index]),
    );
  }

// Build list of more item list view
  Widget _buildList(Menu list) {
    if (list.subMenu!.isEmpty) {
      return Builder(builder: (context) {
        return Container(
          height: 50,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.darkGrey,
                width: 0.2,
              ),
              top: BorderSide(
                color: AppColors.darkGrey,
                width: 0.2,
              ),
            ),
          ),
          child: ListTile(
              tileColor: AppColors.lightGrey,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeView())),
              leading: const SizedBox(),
              title: Text(list.name.toString())),
        );
      });
    }
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.darkGrey,
            width: 0.2,
          ),
          top: BorderSide(
            color: AppColors.darkGrey,
            width: 0.2,
          ),
        ),
      ),
      child: ExpansionTile(
        backgroundColor: AppColors.lightGrey,
        textColor: AppColors.black,
        trailing: const Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.black,
        ),
        // leading: Icon(list.icon),
        title: Text(
          list.name.toString(),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        children: list.subMenu!.map(_buildList).toList(),
      ),
    );
  }
}//end
