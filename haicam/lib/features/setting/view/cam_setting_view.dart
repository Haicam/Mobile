import 'package:flutter/material.dart';
import 'package:prac_haicam/common/utils/app_colors.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';

class CamSettingView extends StatefulWidget {
  const CamSettingView({Key? key}) : super(key: key);

  @override
  State<CamSettingView> createState() => _CamSettingViewState();
}

class _CamSettingViewState extends State<CamSettingView> {
  bool _value_on = false;
  bool _value_audio = false;

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
        title: bodyDarkText("Camera"),
      ),
      body: _buildMainMenu(),
    );
  }

  Widget _buildMainMenu() {
    return ListView(
      children: [
        buildCameraRow(),
        buildIpRow(),
        buildOnOffRow(),
        buildAudioRow(),
      ],
    );
  }

  Widget buildCameraRow() {
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
      height: 50,
      child: InkWell(
        onTap: () {
          () {};
        },
        child: const ListTile(
          tileColor: AppColors.lightGrey,
          title: Text('Camera'),
          trailing: Icon(Icons.navigate_next),
        ),
      ),
    );
  }

  Widget buildIpRow() {
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
      height: 50,
      child: InkWell(
        onTap: () {
          () {};
        },
        child: const ListTile(
          tileColor: AppColors.lightGrey,
          title: Text('IP'),
          trailing: Text('123.34.3.0'),
        ),
      ),
    );
  }

  Widget buildOnOffRow() {
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
      height: 50,
      child: SwitchListTile(
        tileColor: AppColors.lightGrey,
        value: _value_on,
        onChanged: (value) {
          setState(() {
            _value_on = value;
          });
        },
        title: const Text("On/Off"),
      ),
    );
  }

  Widget buildAudioRow() {
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
      height: 50,
      child: SwitchListTile(
        tileColor: AppColors.lightGrey,
        value: _value_audio,
        onChanged: (value) {
          setState(() {
            _value_audio = value;
          });
        },
        title: const Text("Audio"),
      ),
    );
  }
}
