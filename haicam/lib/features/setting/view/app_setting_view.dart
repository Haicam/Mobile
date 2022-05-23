import 'package:flutter/material.dart';
import 'package:prac_haicam/common/utils/app_colors.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/features/home/view/home_view.dart';
import 'package:prac_haicam/features/setting/model/app_setting_model.dart';

class AppSettingView extends StatefulWidget {
  const AppSettingView({Key? key}) : super(key: key);

  @override
  State<AppSettingView> createState() => _AppSettingViewState();
}

class _AppSettingViewState extends State<AppSettingView> {
  bool _isThemeSwitch = false;
  List<Menu> data = [];

  @override
  void initState() {
    for (var element in dataList) {
      data.add(Menu.fromJson(element));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: bodyDarkText("App Setting"),
      ),
      body: buildMainView(),
    );
  }

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

  Widget buildThemeRow() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            //                   <--- left side
            color: AppColors.darkGrey,
            width: 0.2,
          ),
          top: BorderSide(
            //                    <--- top side
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
        },
        title: const Text("Theme Dark/Light"),
      ),
    );
  }

  ListView buildMoreRow() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => _buildList(data[index]),
    );
  }

  Widget _buildList(Menu list) {
    if (list.subMenu!.isEmpty) {
      return Builder(builder: (context) {
        return Container(
          height: 50,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                //                   <--- left side
                color: AppColors.darkGrey,
                width: 0.2,
              ),
              top: BorderSide(
                //                    <--- top side
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
            //                   <--- left side
            color: AppColors.darkGrey,
            width: 0.2,
          ),
          top: BorderSide(
            //                    <--- top side
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
}
