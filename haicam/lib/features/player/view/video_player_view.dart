import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/common/drawer/navigation_drawer_widget.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/features/player/model/events_model.dart';
import 'package:prac_haicam/features/player/widget/image_widget.dart';
import 'package:prac_haicam/features/player/widget/line_generator.dart';
import 'package:prac_haicam/features/player/widget/point_widget.dart';
import 'package:prac_haicam/features/player/widget/set_dialog.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:prac_haicam/features/player/widget/timeline_card_view.dart';
import 'package:timeline_tile/timeline_tile.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key? key}) : super(key: key);

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late int _indexValue;
  late String _indexTime;
  final double _height = 100.0;
  ScrollController? _scrollController;
  bool alterText = false;
  int _number = 20;
  String timeStampText = '';
  String newTimeStampText = '';
  late double position = 0.0;
  DateTime? dateTime;
  late DateTime _minDate, _maxDate;
  double? width;
  double? height;

  var menuItems = [];

  final List<Events> listOfEvents = [
    Events(time: "12:00 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "12:10 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "12:20 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "12:30 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "12:40 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "12:50 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "13:00 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "13:10 PM", image: "assets/images/cam_pic_01.png"),
  ];

  // final DateFormat workerHistoryDateTimeFormat =
  //     DateFormat('dd MMMM yyyy - h:mm a');
  final DateFormat dateFormat = DateFormat('hh:mm a');

  String getDate(String string) {
    if (dateTime == null) {
      return string;
    } else {
      return dateFormat.format(DateTime.parse(dateTime.toString()));
    }
  }

  @override
  void initState() {
    _minDate = DateTime(2020, 3, 5, 9, 0, 0);
    _maxDate = DateTime(2020, 3, 25, 9, 0, 0);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController!.dispose();
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

  //goto index item
  void goToItemIndex(int index) {
    _scrollController!.animateTo(
      index * _height,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          //IconButton
          IconButton(
            icon: const Icon(Icons.settings),
            // tooltip: 'Setting Icon',
            onPressed: () {},
          ), //IconButton
        ],
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(),
        title: Center(child: appBarTitle("Video Player")),
      ),
      drawer: NavigationDrawer(),
      body: _buildMainView(),
      bottomNavigationBar: _buildBottomTabActions(),
    );
  }

  // build main view scrollable
  Widget _buildMainView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 19, bottom: 0, right: 15),
        child: _buildContentView(),
      ),
    );
  }

  // add all widgets
  Widget _buildContentView() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildCamView() + _buildCamPlayerView(),
      ),
    );
  }

  //build came view
  List<Widget> _buildCamView() {
    return <Widget>[
      Container(
        height: height! * 0.25,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          image: DecorationImage(
            image: ExactAssetImage('assets/images/cam_pic_01.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ];
  }

  // build title, detail and next
  List<Widget> _buildCamPlayerView() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              textTimeStamp('$position'),
              addWidth(40),
              textTimeStamp(
                getDate(
                  listOfEvents[0].time.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(height: 400, child: _timeTileCustomModel()),
    ];
  }

  //build Custom timeline model
  Widget _timeTileCustomModel() {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        setState(() {
          if (_scrollController!.position.userScrollDirection ==
              ScrollDirection.reverse) {
            position++;
            // position = _scrollController!.position.pixels;
            print(_scrollController!.position.pixels);

            // _controller.forward();
          }
          if (_scrollController!.position.userScrollDirection ==
              ScrollDirection.forward) {
            position--;

            // _controller.reverse();
          }
        });
        return true;
      },
      child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: listOfEvents.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 6, left: 5, right: 0, bottom: 16),
                  child: Row(
                    children: [
                      SizedBox(width: width! * 0.1),
                      SizedBox(
                        width: width! * 0.18,
                        child: verticlePoints(),
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            eventImage(listOfEvents[index].image),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        Text(listOfEvents[index].time),
                        // Text('$index'),
                        const LineGenerator(
                          lines: [20.0, 10.0, 10.0, 10.0],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  // build builtin timeline model
  Widget _timeTileModel() {
    return Container(
      child: ListView.builder(
        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.2,
            beforeLineStyle: const LineStyle(
              color: AppColors.black,
              thickness: 0.5,
            ),
            afterLineStyle: const LineStyle(
              color: AppColors.black,
              thickness: 0.5,
            ),
            indicatorStyle: const IndicatorStyle(
              color: AppColors.black,
              width: 7,
              height: 7,
              indicatorXY: 0.22, //responsive for everything but tablet
            ),
            endChild: InkWell(
              onTap: () {}, //ontap is defined in card itself
              child: TimeLineCard(
                height: height,
                width: width,
              ),
            ),
            startChild: Text('02:00 PM'),
            isFirst: index == 2,
            //Makes sure no line is drawn before
            isLast: index == 3,
          );
        },
        // itemCount: 13,
      ),
    );
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
                onPressed: () {},
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
    String selectedFormattedTime = DateFormat.jm().format(selectTime);
    print(selectedFormattedTime);
    final index = listOfEvents
        .indexWhere((element) => element.time == selectedFormattedTime);
    if (index >= 0) {
      goToItemIndex(index);
    }
  }
}
