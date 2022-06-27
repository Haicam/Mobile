import 'package:flutter/material.dart';
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

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key? key}) : super(key: key);

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  var menuItems = [];

  final List<Events> listOfEvents = [
    Events(time: "12:00 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "12:10 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "12:20 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "12:30 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "12:40 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "12:50 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "01:00 PM", image: "assets/images/cam_pic_01.png"),
    Events(time: "01:10 PM", image: "assets/images/cam_pic_01.png"),
  ];

  DateTime date = DateTime.now().toUtc().add(const Duration(hours: -11));
  final DateFormat workerHistoryDateTimeFormat =
      DateFormat('dd MMMM yyyy - h:mm a');

  @override
  Widget build(BuildContext context) {
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
      body: buildMainView(),
      bottomNavigationBar: _builBottomTab(),
    );
  }

// build camera. timestamp and timeline view
  Widget buildMainView() {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * 0.25,
                width: double.infinity,
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
            ),
            Positioned(
              bottom: -20,
              right: 15,
              child: textTimeStamp(
                '00/00/0000 00:00:00',
              ),
              // child: textTimeStamp(workerHistoryDateTimeFormat.format(date)),
            ),
          ],
        ),
        Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: listOfEvents.length,
              itemBuilder: (context, i) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 5, right: 0, bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(width: size.width * 0.1),
                          SizedBox(
                            width: size.width * 0.18,
                            child: verticlePoints(),
                          ),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                eventImage(listOfEvents[i].image),
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
                        child: NotificationListener<ScrollNotification>(
                          child: Column(
                            children: [
                              Text(listOfEvents[i].time),
                              const LineGenerator(
                                lines: [20.0, 10.0, 10.0, 10.0],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }

// build bottom tab actions
  Widget _builBottomTab() {
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
                onPressed: () => pickDateAndTime(context),
                // onPressed: () => textTimeStamp(getDateTime()),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.volume_down_alt),
                color: AppColors.darkGrey,
                iconSize: iconSize,
                onPressed: () {},
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
                onPressed: () {},
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.forward_10),
                color: AppColors.darkGrey,
                iconSize: iconSize,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ShowTimelapseBox();
                      });
                },
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
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      is24HourMode: false,
      isShowSeconds: false,
      startInitialDate: initialDate,
      startFirstDate:
          DateTime.now().toUtc().subtract(const Duration(days: 365)),
      startLastDate: DateTime.now().toUtc(),
      borderRadius: const Radius.circular(16),
    );
  }
}
