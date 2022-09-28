import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';

class CameraSettingView extends StatefulWidget {
  const CameraSettingView({Key? key}) : super(key: key);

  @override
  State<CameraSettingView> createState() => _CameraSettingViewState();
}

class _CameraSettingViewState extends State<CameraSettingView> {
  // set values on/off
  bool _value_on = false;
  bool _value_audio = false;

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
        title: Center(child: appBarTitle("Camera")),
      ),
      body: _buildMainMenu(),
    );
  }

// Build main view
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

// Build camera row setting view
  Widget buildCameraRow() {
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

// Build IP row setting view
  Widget buildIpRow() {
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

// Build on/off setting row view
  Widget buildOnOffRow() {
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

// Build audio setting row view
  Widget buildAudioRow() {
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
