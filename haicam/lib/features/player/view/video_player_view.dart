import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prac_haicam/common/utils/app_colors.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/features/home/view/home_view.dart';
import 'package:prac_haicam/features/menu/widget/navigation_drawer_widget.dart';
import 'package:prac_haicam/features/player/model/video_player_item.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key? key}) : super(key: key);

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  int _currentTabIndex = 0;

  var menuItems = [];

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
        title: Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: bodyDarkText("Vedio Player"),
        ),
      ),
      drawer: NavigationDrawer(),
      body: buildMainView(),
      bottomNavigationBar: prepareBottomTabs(),
    );
  }

  Widget buildMainView() {
    return ListView(
      children: <Widget>[
        displayDevice("Doorbell", "cam_pic_01.png"),
      ],
    );
  }

  Widget displayDevice(String camLocation, String camName) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(14),
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/$camName'),
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
                  fontWeight: FontWeight.bold,
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
