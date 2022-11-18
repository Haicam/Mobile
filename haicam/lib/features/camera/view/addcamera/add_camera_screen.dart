import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/core/utils/common_widget_utils.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/local_string.dart';
import '../../../../localization/language_constants.dart';
import 'add_process_dialog.dart';

class AddCameraScreen extends StatefulWidget {

  @override
  State<AddCameraScreen> createState() => _AddCameraScreenState();
}

class _AddCameraScreenState extends State<AddCameraScreen> {

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
        title: CommonWidgetUtils.getLabel(getTranslated(context, LocalString.add_camera)!,
            15, FontWeight.w500, AppColors.black)),
      body: _buildMainMenu(),
    );
  }

// Build main view
  Widget _buildMainMenu() {
    return ListView(
      children: [
        buildCameraRow(),
        CommonWidgetUtils.getSeparator2(AppColors.lightGrey, 1)
      ],
    );
  }

// Build camera row setting view
  Widget buildCameraRow() {
    String label = "";
    label = getTranslated(context, LocalString.add_camera2)!;
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
          startProcess();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 15,),
            Expanded(child: CommonWidgetUtils.getLabel(getTranslated(context, LocalString.add_camera2)!,
                15, FontWeight.w500, AppColors.black)),

            Padding(padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.navigate_next, size: 15),)

          ],
        ),
      ),
    );
  }

   void startProcess(){
    AlertDialog alert=AlertDialog(
      content: AddProcessDialog(),
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
