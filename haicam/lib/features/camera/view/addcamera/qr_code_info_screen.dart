import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/common_widget_utils.dart';
import 'package:prac_haicam/features/camera/view/addcamera/scan_qr_code_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/local_string.dart';
import '../../../../localization/language_constants.dart';


class QrCodeInfoScreen extends StatefulWidget {

  @override
  State<QrCodeInfoScreen> createState() => _QrCodeInfoScreenState();
}

class _QrCodeInfoScreenState extends State<QrCodeInfoScreen> {

  List<String> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerEventListener();
    iniitalizeComp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(),
          centerTitle: true,
          title: CommonWidgetUtils.getLabel(getTranslated(context, LocalString.scan_camera_qr)!,
              15, FontWeight.w500, AppColors.black)),
      body: _buildMainMenu()
    );
  }

  void iniitalizeComp() {
    dataList.add("http://sc04.alicdn.com/kf/H17669b69f95143ae823147b59e8234bb8.jpg");
    dataList.add("https://www.boxify.co.in/pub/media/catalog/product/cache/f7ac6ad24a0aa968b63fcbea3a8c934a/i/m/img_20190115_211119.jpg");
    dataList.add("https://www.techfinder.in/ecom_images/products/product-22-3044.jpg");
  }

  Widget getBottomBar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new ScanQrCodeScreen()));
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
          getTranslated(context, LocalString.scan_here)!,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

// Build main view
  Widget _buildMainMenu() {

    return Column(
      children: [
        CommonWidgetUtils.getLabel(getTranslated(context, LocalString.scan_camera_qr_info)!,
            13, FontWeight.w500, AppColors.black),
        SizedBox(height: 20,),
        Expanded(child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: List.generate(dataList.length, (index) {
                  return CommonWidgetUtils.getImageView(dataList.elementAt(index),
                      100, 100);
                })
            )
          ],
        )),
        getBottomBar(),
        SizedBox(height: 10,)
      ],
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
