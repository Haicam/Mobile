import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/common_widget_utils.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/local_string.dart';
import '../../../../localization/language_constants.dart';
import 'factory_default_screen.dart';


class PlugCameraScreen extends StatefulWidget {

  @override
  State<PlugCameraScreen> createState() => _PlugCameraScreenState();
}

class _PlugCameraScreenState extends State<PlugCameraScreen> {

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
          title: CommonWidgetUtils.getLabel(getTranslated(context, LocalString.plug_camera)!,
              15, FontWeight.w500, AppColors.black)),
      body: _buildMainMenu(),
      bottomNavigationBar: getBottomBar(),
    );
  }


  Widget getBottomBar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new FactoryDefaultScren()));
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

          CommonWidgetUtils.getLabel(getTranslated(context, LocalString.unplug_camera_info1)!,
              14, FontWeight.w500, AppColors.black),

          SizedBox(height: 10,),

          Image.network(
            "https://st.depositphotos.com/1042606/3293/i/600/depositphotos_32932189-stock-photo-inserting-power-cord-receptacle-in.jpg",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),

          SizedBox(height: 20,),
          CommonWidgetUtils.getLabel(getTranslated(context, LocalString.unplug_camera_info1)!,
              14, FontWeight.w500, AppColors.black),

          SizedBox(height: 10,),
          getInfoView()
        ],
      ),);
  }





  Widget getInfoView(){
    setDataList();
    return Padding(padding: EdgeInsets.only(top: 15),
      child: ListView.separated(
        itemCount: dataList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var item = dataList.elementAt(index);
          return getRowItem(item);
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.transparent, height: 0, thickness: 0,);
        },
      ),);
  }

  void setDataList() {
    if(dataList.isEmpty){
      dataList.add(getTranslated(context, LocalString.plug_camera_info3)!);

    }
  }

  Widget getRowItem(String text) {
    return Padding(padding: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 9),
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
