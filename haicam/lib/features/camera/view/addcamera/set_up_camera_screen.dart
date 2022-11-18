import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/common_widget_utils.dart';
import 'package:prac_haicam/features/camera/view/addcamera/unplug_camera_screen.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/local_string.dart';
import '../../../../core/utils/utils.dart';
import '../../../../localization/language_constants.dart';


class SetUpCameraScreen extends StatefulWidget {

  @override
  State<SetUpCameraScreen> createState() => _SetUpCameraScreenState();
}

class _SetUpCameraScreenState extends State<SetUpCameraScreen> {

  List<String> dataList = [];

  final int ACTION_TYPE_WIFI_NAME = 1,
      ACTION_TYPE_WIFI_PWD = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(),
          centerTitle: true,
          title: CommonWidgetUtils.getLabel(getTranslated(context, LocalString.setup_camera)!,
              15, FontWeight.w500, AppColors.black)),
      body: _buildMainMenu(),
      bottomNavigationBar: getBottomBar(),
    );
  }


  Widget getBottomBar() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Utils.sendBroadcast(Constants.CAMERA_SETUP_FINISHED_BROADCASTE_RECEIVER_ACTION);
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
          getTranslated(context, LocalString.next)!,
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
        children: [
          buildRowItem(getTranslated(context, LocalString.camera_name)!, "E21-687667786",
              ACTION_TYPE_WIFI_NAME),
          CommonWidgetUtils.getSeparator2(AppColors.black70, 1),
          buildRowItem2(getTranslated(context, LocalString.ip)!, "192.234.122.106"),
          CommonWidgetUtils.getSeparator2(AppColors.black70, 1),
          buildRowItem(getTranslated(context, LocalString.monitoring)!, "Preimeter",
              ACTION_TYPE_WIFI_PWD),
          CommonWidgetUtils.getSeparator2(AppColors.black70, 1),
          buildRowItem2(getTranslated(context, LocalString.video_bandwidth)!, "Auto"),
          CommonWidgetUtils.getSeparator2(AppColors.black70, 1),
          buildRowItem(getTranslated(context, LocalString.level)!, "High", ACTION_TYPE_WIFI_PWD),
          CommonWidgetUtils.getLabel(getTranslated(context, LocalString.level_info)!,
              14, FontWeight.w500, AppColors.black),

        ],
      ),);
  }

  Widget buildRowItem(String label, String rightLabel, int actionType) {
    return Container(
      height: 50,
      child: InkWell(
        onTap: () {
          if(actionType == ACTION_TYPE_WIFI_NAME){
          }else if(actionType == ACTION_TYPE_WIFI_PWD){
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 15,),
            Expanded(child: CommonWidgetUtils.getLabel(label,
                15, FontWeight.w500, AppColors.black)),

            CommonWidgetUtils.getLabel(rightLabel,
                15, FontWeight.w500, AppColors.black),

            Padding(padding: EdgeInsets.only(right: 5),
              child: Icon(
                Icons.navigate_next, size: 20),)

          ],
        ),
      ),
    );
  }

  Widget buildRowItem2(String label, String rightLabel) {
    return Container(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15,),
          Expanded(child: CommonWidgetUtils.getLabel(label,
              15, FontWeight.w500, AppColors.black)),

          CommonWidgetUtils.getLabel(rightLabel,
              15, FontWeight.w500, AppColors.black),
          SizedBox(width: 25,)
        ],
      ),
    );
  }

}
