import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/common/drawer/navigation_drawer_widget.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/features/player/model/frame_events_model.dart';
import 'package:prac_haicam/features/player/widget/image_widget.dart';
import 'package:prac_haicam/features/player/widget/line_generator.dart';
import 'package:prac_haicam/features/player/widget/point_widget.dart';
import 'package:prac_haicam/features/player/widget/set_dialog.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key? key}) : super(key: key);

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  // initialize required controller and other variable
  ScrollController? _scrollController;
  String timeStampText = '';
  String newTimeStampText = '';
  bool alterText = false;
  double? width;
  double? height;
  DateTime? dateTime;

  // set initial values for date and indexes
  DateTime startDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime endDate = DateTime.now();
  final int _indexPosition = 0;
  String imageSample = "assets/images/cam_pic_01.png";

  //set date formatting
  final DateFormat dateFormat = DateFormat('hh:mm');

  List<FrameEvent> events = [];
  late int _indexTimeLine;
  late double setPosition = 52704;

  // init state of view
  @override
  initState() {
    _scrollController = ScrollController();
    endDate = endDate.add(const Duration(days: 1));
    while (startDate.isBefore(endDate)) {
      FrameEvent event = FrameEvent(dateTime: startDate);
      events.add(event);
      startDate = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        startDate.hour,
        startDate.minute + 10,
      );
    }
    super.initState();
  }

// dispose state of view
  @override
  void dispose() {
    super.dispose();
    _scrollController!.dispose();
  }

  // set get Date for timestamp view
  String getDate(String string) {
    if (dateTime == null) {
      return string;
    } else {
      return dateFormat.format(DateTime.parse(dateTime.toString()));
    }
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
              textDateStamp(
                  '${events[_indexPosition].dateTime!.day.toString()}/${events[_indexPosition].dateTime!.month.toString()}/${events[_indexPosition].dateTime!.year.toString()}'),
              addWidth(30),
              textTimeStamp(
                getDate(
                    '${events[_indexPosition].dateTime!.hour.toString()}:${events[_indexPosition].dateTime!.minute.toString()}'),
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
          // if (_scrollController!.position.userScrollDirection ==
          //     ScrollDirection.reverse) {
          //   // _indexPosition++;
          //   textDateTimeStamp(
          //       '${events[_indexPosition].dateTime!.day.toString()}/${events[_indexPosition].dateTime!.month.toString()}/${events[_indexPosition].dateTime!.year.toString()}');
          //   textTimeStamp(getDate(
          //       '${events[_indexPosition].dateTime!.hour.toString()}:${events[_indexPosition].dateTime!.minute.toString()}'));
          // }
          // if (_scrollController!.position.userScrollDirection ==
          //     ScrollDirection.forward) {
          //   _indexPosition--;
          //   print(_indexPosition);
          //   textDateTimeStamp(
          //       '${events[_indexPosition].dateTime!.day.toString()}/${events[_indexPosition].dateTime!.month.toString()}/${events[_indexPosition].dateTime!.year.toString()}');
          //   textTimeStamp(getDate(
          //       '${events[_indexPosition].dateTime!.hour.toString()}:${events[_indexPosition].dateTime!.minute.toString()}'));
          //   // _indexPosition--;
          //
          // }
        });
        return true;
      },
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: events.length,
        scrollDirection: Axis.vertical,
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
                          eventImage(imageSample),
                          // Text('$index'),
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
                      Text(
                          '${events[index].dateTime!.hour.toString()}:${events[index].dateTime!.minute.toString()}'),
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
        },
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
}
