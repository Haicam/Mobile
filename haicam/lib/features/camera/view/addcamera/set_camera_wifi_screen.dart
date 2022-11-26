import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/common_widget_utils.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:prac_haicam/features/camera/view/addcamera/set_up_camera_screen.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/local_string.dart';
import '../../../../localization/language_constants.dart';


class SetCameraWiFiScreen extends StatefulWidget {

  @override
  State<SetCameraWiFiScreen> createState() => _SetCameraWiFiScreenState();
}

class _SetCameraWiFiScreenState extends State<SetCameraWiFiScreen> {


  final int time = 5;//120;
  Timer? countdownTimer;
  Duration? myDuration = null;
  int totalTimeInSeconds = 0, counter = 0;
  double percentCompleted = 0;
  bool isAutoCancel = true,
      processApi = false,
      timeout = false;

  @override
  void initState() {
    // TODO: implement initState
    totalTimeInSeconds = time;
    myDuration = Duration(seconds: totalTimeInSeconds);
    super.initState();
    registerEventListener();
    startTimer();
  }
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  void stopTimer() {
    setState((){
      if(countdownTimer != null){
        countdownTimer!.cancel();
        countdownTimer = null;
        myDuration = Duration(seconds: 0);
        percentCompleted = 0;
      }
    });
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration!.inSeconds - reduceSecondsBy;
      percentCompleted  = (seconds/totalTimeInSeconds)*100;
      if(percentCompleted < 0){
        percentCompleted = 0;
      }
      if(percentCompleted > 10){
        percentCompleted = double.parse("0."+percentCompleted.toStringAsFixed(0));
      }else {
        percentCompleted = double.parse("0.0"+percentCompleted.toStringAsFixed(0));
      }


      if (seconds <= 0) {
        percentCompleted = 0;
        countdownTimer!.cancel();
        countdownTimer = null;
        onEnd();
      } else {
        if(counter == 5){
          //fetchOrderStatus();
          counter = 0;
        }else {
          counter++;
        }
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void onEnd() {
    setState(() {
      timeout = true;
      Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new SetUpCameraScreen()));
    });
  }

  Future<bool> _onWillPop() async {
    //Utils.sendBroadcast(Constants.BACK_HOME_BROADCASTE_RECEIVER_ACTION);
    print("***_onWillPop()***");
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: const IconThemeData(),
            centerTitle: true,
            title: CommonWidgetUtils.getLabel(getTranslated(context, LocalString.set_camera_wifi)!,
                15, FontWeight.w500, AppColors.black)),
        body: _buildMainMenu(),
      ),);
  }



// Build main view
  Widget _buildMainMenu() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: getDataFields(),
      ),
    );
  }


  List<Widget> getDataFields() {

    List<Widget> list = [];
    list.add(Center(child: _getTimerText(),));

    return list;
  }

  Widget _getTimerText() {

    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration!.inMinutes.remainder(60));
    final seconds = strDigits(myDuration!.inSeconds.remainder(60));
    String timerStr = minutes+":"+seconds;
    if(timeout){
      timerStr = "Timeout";
    }
    return Container(
      child: CircularPercentIndicator(
        radius: 60.0,
        lineWidth: 5.0,
        percent: percentCompleted,
        center: Text(timerStr),
        progressColor: AppColors.primary,
      ),
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
