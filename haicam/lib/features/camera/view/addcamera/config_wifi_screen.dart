import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/common_widget_utils.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/local_string.dart';
import '../../../../localization/language_constants.dart';
import 'ask_config_dialog.dart';


class ConfigWiFiScreen extends StatefulWidget {

  @override
  State<ConfigWiFiScreen> createState() => _ConfigWiFiScreenState();
}

class _ConfigWiFiScreenState extends State<ConfigWiFiScreen> {

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
          title: CommonWidgetUtils.getLabel(getTranslated(context, LocalString.config_wifi)!,
              15, FontWeight.w500, AppColors.black)),
      body: _buildMainMenu(),
      bottomNavigationBar: getBottomBar(),
    );
  }


  Widget getBottomBar() {
    return Row(
      children: [
        SizedBox(width: 10,),
        Expanded(child: getActionBtn(getTranslated(context, LocalString.qr_code_mode)!, 1)),
        SizedBox(width: 10,),
        Expanded(child: getActionBtn(getTranslated(context, LocalString.next)!, 2)),
        SizedBox(width: 10,),
      ],
    );
  }

  Widget getActionBtn(String label, int actionType) {
    return GestureDetector(
      onTap: () {
        if(actionType == 1){ //QR code mode

        }else if(actionType == 2){ //Continue
          doNext();
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
    list.add(getRowItem(getTranslated(context, LocalString.config_wifi_info1)!));
    list.add(getRowItem(getTranslated(context, LocalString.config_wifi_info2)!));
    list.add(SizedBox(height: 20,));
    list.add(Image.network(
      "https://media.istockphoto.com/id/1261027671/vector/wifi-icon.jpg?s=612x612&w=0&k=20&c=cILPmAhltJetlunXkfIIef-PvPwSkZd5710ofXBsstY=",
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
    ));
    list.add(SizedBox(height: 10,));
    list.add(Row(
      children: [
        Expanded(child: getActionBtn(getTranslated(context, LocalString.play)!, 1)),
        Expanded(child: Container()),
        Expanded(child: Container())
      ],
    ));
    list.add(SizedBox(height: 10,));
    list.add(getRowItem(getTranslated(context, LocalString.config_wifi_info3)!));
    list.add(getRowItem(getTranslated(context, LocalString.config_wifi_info4)!));
    list.add(getRowItem(getTranslated(context, LocalString.config_wifi_info5)!));
    list.add(SizedBox(height: 30,));

    return list;
  }


  Widget getRowItem(String text) {
    return Padding(padding: EdgeInsets.only(top: 10),
      child: CommonWidgetUtils.getLabel(text,
          14, FontWeight.w500, AppColors.black),);
  }


  void doNext(){
    AlertDialog alert=AlertDialog(
      content: AskConfigDialog(),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
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
