import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/app_images.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/features/home/view/home_view.dart';
import 'package:prac_haicam/common/drawer/navigation_drawer_widget.dart';
import 'package:prac_haicam/features/player/model/events_model.dart';
import 'package:prac_haicam/features/player/model/video_player_item.dart';
import 'package:prac_haicam/features/player/widget/image_widget.dart';
import 'package:prac_haicam/features/player/widget/line_generator.dart';
import 'package:prac_haicam/features/player/widget/point_widget.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key? key}) : super(key: key);

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  int _currentTabIndex = 0;

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

  @override
  void initState() {
    menuItems = [
      BottomViedoPlayerItem(title: "Calender", view: const HomeView()),
      BottomViedoPlayerItem(title: "Audio On/Off", view: const HomeView()),
      BottomViedoPlayerItem(title: "Recording", view: const HomeView()),
      BottomViedoPlayerItem(title: "Play", view: const HomeView()),
      BottomViedoPlayerItem(title: "Export", view: const HomeView())
    ];
    super.initState();
  }

  String startTime = "12:00 PM";
  String endTime = "12:00 PM";
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
      bottomNavigationBar: prepareBottomTabs(),
    );
  }

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
              child: textTimeStamp('06/05/2022 13:00:35'),
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

  Widget displayDevice(String camLocation, String camName) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('$imagePath$camName'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                camLocation,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget prepareBottomTabs() {
    double size = 24;
    return CupertinoTabBar(
      activeColor: AppColors.primary,
      inactiveColor: Colors.grey,
      backgroundColor: const Color(0xB3FFFFFF),
      onTap: onTabTapped,
      currentIndex: _currentTabIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.calendar_month,
            size: size,
          ),
          icon: Icon(
            Icons.calendar_month_outlined,
            size: size,
          ),
          label: menuItems[0].title,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.volume_down_alt,
            size: size,
          ),
          icon: Icon(
            Icons.volume_down_outlined,
            size: size,
          ),
          label: menuItems[1].title,
        ),
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.mic,
              size: size,
            ),
            icon: Icon(
              Icons.mic_outlined,
              size: size,
            ),
            label: menuItems[2].title),
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.forward_10,
              size: size,
            ),
            icon: Icon(
              Icons.forward_10_outlined,
              size: size,
            ),
            label: menuItems[3].title),
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.circle_sharp,
              size: size,
            ),
            icon: Icon(
              Icons.circle_sharp,
              size: size,
            ),
            label: menuItems[4].title),
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }
}
