
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/features/camera/view/addcamera/plug_camera_screen.dart';
import 'package:prac_haicam/features/camera/view/addcamera/qr_code_info_screen.dart';
import 'package:prac_haicam/features/camera/view/addcamera/scan_qr_code_screen.dart';

import '../../../../core/utils/common_widget_utils.dart';
import '../../../../core/utils/local_string.dart';
import '../../../../localization/language_constants.dart';

class AskUnplugDialog extends StatefulWidget {

  AskUnplugDialog(){}

  @override
  _AskUnplugDialogState createState() =>
      _AskUnplugDialogState();
}

class _AskUnplugDialogState extends State<AskUnplugDialog> {

  _AskUnplugDialogState(){}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement b
    return Container(
      //color: Colors.white,
      width: double.infinity,
      child: setUpViewPage(),
    );
  }

  Widget setUpViewPage() {
    return Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ListView(
          shrinkWrap: true,
          children: getDataFields(),
        ));
  }



  List<Widget> getDataFields(){
    List<Widget> list = [];
    list.add(CommonWidgetUtils.getLabel(getTranslated(context, LocalString.unplug_camera_ask_msg)!, 14, FontWeight.w400, AppColors.black));

    list.add(SizedBox(height: 20,));
    list.add(Row(children: [
      Expanded(child: Container()),
      getActionBtn(getTranslated(context, LocalString.ok)!, 1),
      SizedBox(width: 10,),
      getActionBtn(getTranslated(context, LocalString.cancel)!, 2),
      Expanded(child: Container()),
    ],));

    return list;
  }

  Widget getActionBtn(String label, int actionType){
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if(actionType == 1){
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new PlugCameraScreen()));
        }

      },
      child: Container(
        width: 100,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: new LinearGradient(
              colors: [
                AppColors.primary, //start
                AppColors.primary, //center
                AppColors.primary, //end
              ],
            )),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}


