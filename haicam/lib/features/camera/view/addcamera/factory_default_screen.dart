import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/common_widget_utils.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/local_string.dart';
import '../../../../localization/language_constants.dart';
import 'audio_volume_screen.dart';


class FactoryDefaultScren extends StatefulWidget {

  @override
  State<FactoryDefaultScren> createState() => _FactoryDefaultScrenState();
}

class _FactoryDefaultScrenState extends State<FactoryDefaultScren> {

  List<String> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerEventListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(),
          centerTitle: true,
          title: CommonWidgetUtils.getLabel(getTranslated(context, LocalString.factory_defalut)!,
              15, FontWeight.w500, AppColors.black)),
      body: _buildMainMenu(),
      bottomNavigationBar: getBottomBar(),
    );
  }

  Widget getBottomBar() {
    return Row(
      children: [
        SizedBox(width: 10,),
        Expanded(child: getActionBtn(getTranslated(context, LocalString.reset)!, 1)),
        SizedBox(width: 10,),
        Expanded(child: getActionBtn(getTranslated(context, LocalString.next)!, 2)),
        SizedBox(width: 10,),
      ],
    );
  }

  Widget getActionBtn(String label, int actionType) {
    return GestureDetector(
      onTap: () {
        if(actionType == 1){ //reset

        }else if(actionType == 2){ //Continue
          Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new AudioVolumeScreen()));
        }

      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: new LinearGradient(
              colors: [
                AppColors.primary, //start
                AppColors.primary, //center
                AppColors.primary, //end
              ],
            )),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

// Build main view
  Widget _buildMainMenu() {
    return Padding(padding: EdgeInsets.only(left: 15, right: 15),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: getDataFields(),
      ),);


  }

  List<Widget> getDataFields() {

    List<Widget> list = [];
    list.add(CommonWidgetUtils.getLabel(getTranslated(context, LocalString.factory_defalut_info1)!,
        16, FontWeight.w500, AppColors.black));
    list.add(SizedBox(height: 20,));
    list.add(getRowItem(getTranslated(context, LocalString.factory_defalut_info2)!));
    list.add(getRowItem(getTranslated(context, LocalString.factory_defalut_info3)!));

    list.add(Padding(padding: EdgeInsets.only(top: 10),
      child: CommonWidgetUtils.getLabel(getTranslated(context, LocalString.factory_defalut_info4)!,
          14, FontWeight.w600, AppColors.black),));
    list.add(getRowItem(getTranslated(context, LocalString.factory_defalut_info5)!));

    list.add(SizedBox(height: 10,));
    return list;
  }

  Widget getRowItem(String text) {
    return Padding(padding: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 9,),
          SizedBox(width: 10,),
          Expanded(child: Container(
            child: CommonWidgetUtils.getLabel(text,
                14, FontWeight.w500, AppColors.black),
          ))
        ],
      ),);
  }

  /**
   * Broadcaste event listener
   */

  StreamSubscription? receiver;

  @override
  void dispose() {
    unRegisterEventListener();
    super.dispose();
  }

  void registerEventListener() {

    receiver = Constants.eventBus!.on().listen((event) {
      print("home::event.toString() = " + event.toString());
      // Print the runtime type. Such a set up could be used for logging.
      if (event.toString().indexOf(Constants.CAMERA_SETUP_FINISHED_BROADCASTE_RECEIVER_ACTION) >=0) {
        Navigator.pop(context);
      }
    });
  }

  void unRegisterEventListener() {
    try {
      if (receiver != null) {
        receiver!.cancel();
      }
    } catch (myemailError) {}
  }
}
