import 'package:flutter/material.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/common/drawer/navigation_drawer_widget.dart';
import 'package:prac_haicam/features/player/model/events_model.dart';
import 'package:prac_haicam/features/player/widget/image_widget.dart';
import 'package:prac_haicam/features/player/widget/line_generator.dart';
import 'package:prac_haicam/features/player/widget/point_widget.dart';
import 'package:prac_haicam/features/player/widget/set_dialog.dart';
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

  String startTime = "12:00 PM";
  String endTime = "12:00 PM";

  // DateTime date =
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime? dateTime;

  String getDateTime() {
    if (dateTime == null) {
      return 'Select Date and Time';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime!);
    }
  }

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
              // child: textTimeStamp('00/00/0000 00:00:00'),
              child: Row(
                children: [
                  textTimeStamp(getDateTime()),
                ],
              ),
            )
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
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
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
                color: Colors.grey,
                iconSize: iconSize,
                onPressed: () => pickDateTime(context),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.volume_down_alt),
                color: Colors.grey,
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
                color: Colors.grey,
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
                color: Colors.grey,
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
                color: Colors.grey,
                iconSize: iconSize,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (newDate == null) return null;
    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    const initialTime = TimeOfDay(hour: 12, minute: 00);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(
              hour: dateTime!.hour,
              minute: dateTime!.minute,
            )
          : initialTime,
    );
    if (newTime == null) return null;

    return newTime;
  }
}
