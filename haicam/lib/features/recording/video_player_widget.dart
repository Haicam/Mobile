import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:prac_haicam/blocs/models/camera.dart';
import 'package:prac_haicam/common/drawer/navigation_drawer_widget.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/features/player/model/frame_events_model.dart';
import 'package:prac_haicam/features/player/widget/image_widget.dart';
import 'package:prac_haicam/features/player/widget/line_generator.dart';
import 'package:prac_haicam/features/player/widget/point_widget.dart';
import 'package:prac_haicam/features/player/widget/set_dialog.dart';
import 'package:prac_haicam/features/recording/timeline/timeline_widget.dart';

import '../../core/utils/constants.dart';

class VideoPlayerWidget extends StatefulWidget {

  Camera? camera;
  VideoPlayerWidget(Camera? camera){
    this.camera = camera;
  }

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState(camera);
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  // initialize required controller and other variable
  bool alterText = false;
  //double? width;
  //double? height;
  DateTime? dateTime;

  VlcPlayerController? _videoPlayerController;
  Camera? camera;

  _VideoPlayerWidgetState(Camera? camera){
    this.camera = camera;
  }

  // init state of view
  @override
  initState() {
    super.initState();
    initializeVideoPlayer();
  }



// dispose state of view
  @override
  void dispose() {
    super.dispose();
    stopVideoPlayer();
  }


  //on Tap calendar icon
  onTapCalendarTab() {
    pickDateAndTime(context);
  }

  //on Tap Speaker icon
  onTapSpeakerTab() {}

  //on Tap Mic icon
  onTapMicTab() {}

  //on Tap timelapse forward icon
  onTapForwardITab() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ShowTimelapseBox();
      },
    );
  }

  //on Tap Circle icon
  void onTapCircleTab() {}

// This widget is the root of view.
  @override
  Widget build(BuildContext context) {
    //width = MediaQuery.of(context).size.width;
    //height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(),
        centerTitle: true,
        title: Center(child: appBarTitle("Video Player")),
      ),
      body: _buildMainView(),
      bottomNavigationBar: _buildBottomTabActions(),
    );
  }

  // build main view scrollable
  Widget _buildMainView() {
    //return TimelineWidget(platform: Theme.of(context).platform);
    //return SizedBox(height: 500, child: TimelineWidget(platform: Theme.of(context).platform),);
    //return Stack(children: _buildCamView());
    return Column(
      children: _buildCamView2(),
    );
  }

  List<Widget> _buildCamView2() {
    double playerHeight = getPlayerHeight();
    //double timeLineHeight = MediaQuery.of(context).size.height-playerHeight-60-60;
     return <Widget>[
       LimitedBox(
         maxHeight: playerHeight,
         maxWidth: double.infinity,
         child: getViedoPlayer(),
       ),
       Expanded(child: TimelineWidget(platform: Theme.of(context).platform)),

    ];
  }

  //build came view
  List<Widget> _buildCamView() {
    double playerHeight = getPlayerHeight();
    return <Widget>[
      Positioned(left:0, top:0,child: SizedBox(height: playerHeight,
      child: getViedoPlayer(),)),
      //Positioned(left:0, top:playerHeight, child: TimelineWidget(platform: Theme.of(context).platform))
      //Positioned(left:0, top:playerHeight, child: Text("Hello world"))
      Positioned(left:0, top:playerHeight, child: SizedBox(height: 500, child: TimelineWidget(platform: Theme.of(context).platform),))
    ];
  }

  double getPlayerHeight(){
    double calculatedHeight = 200;
    if(camera != null){
      List<String> ratio = camera!.videoSize!.split(":");
      double horizontalRatio = double.parse(ratio[0]);
      double verticalRatio = double.parse(ratio[1]);
      calculatedHeight = MediaQuery.of(context).size.width *(verticalRatio/horizontalRatio);
    }
    Constants.timeTopMargin = 2*calculatedHeight;
    return calculatedHeight;

  }

// build bottom tab
  Widget _buildBottomTabActions() {
    double iconSize = 32;
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.calendar_month),
                  color: AppColors.darkGrey,
                  iconSize: iconSize,
                  onPressed: onTapCalendarTab),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.volume_down_alt),
                color: AppColors.darkGrey,
                iconSize: iconSize,
                onPressed: onTapSpeakerTab,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.mic_outlined),
                  color: AppColors.darkGrey,
                  iconSize: iconSize,
                  onPressed: onTapMicTab),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.forward_10),
                color: AppColors.darkGrey,
                iconSize: iconSize,
                onPressed: onTapForwardITab,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.circle_sharp),
                color: AppColors.darkGrey,
                iconSize: iconSize,
                onPressed: onTapCircleTab,
              ),
            ],
          ),
        ],
      ),
    );
  }

// build time and date picker
  Future pickDateAndTime(BuildContext context) async {
    final initialDate = DateTime.now().toUtc().add(const Duration(hours: -11));
    DateTime? newdateTime = await showOmniDateTimePicker(
      context: context,
      is24HourMode: false,
      isShowSeconds: false,
      startInitialDate: dateTime ?? initialDate,
      startFirstDate:
      DateTime.now().toUtc().subtract(const Duration(days: 365)),
      startLastDate: DateTime.now().toUtc(),
      borderRadius: const Radius.circular(16),
    );
    if (newdateTime == null) return;
    setState(() => dateTime = newdateTime);
    DateTime selectTime = newdateTime;
    // String selectedFormattedTime = DateFormat.jm().format(selectTime);
    selectTime = DateTime(
      selectTime.year,
      selectTime.month,
      selectTime.day,
      selectTime.hour,
      selectTime.minute,
    );
    // print(selectTime);
    // final index =
    //     events.indexWhere((element) => element.dateTime == selectTime);
    // if (index >= 0) {
    //   goToItemIndex(index);
    // }
  }


  /**
   * Video Player
   */

  Widget getViedoPlayer() {
    return VlcPlayer(
      controller: _videoPlayerController!,
      aspectRatio: getAspectRatio(),
      placeholder: Center(child: CircularProgressIndicator()),
    );
  }

  double getAspectRatio(){
    List<String> ratio = camera!.videoSize!.split(":");
    double horizontalRatio = double.parse(ratio[0]);
    double verticalRatio = double.parse(ratio[1]);
    return horizontalRatio/verticalRatio;
  }

  void initializeVideoPlayer() {

    _videoPlayerController = VlcPlayerController.network(
      //'https://media.w3.org/2010/05/sintel/trailer.mp4',
      'http://samples.mplayerhq.hu/MPEG-4/embedded_subs/1Video_2Audio_2SUBs_timed_text_streams_.mp4',
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );
  }

  void stopVideoPlayer() async {
    await _videoPlayerController!.stopRendererScanning();
    await _videoPlayerController!.dispose();
  }
}
