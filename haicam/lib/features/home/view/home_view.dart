import 'package:flutter/material.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/app_images.dart';
import 'package:prac_haicam/common/drawer/navigation_drawer_widget.dart';

import 'package:prac_haicam/core/utils/app_routes.dart' as route;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  // This widget is the root of view.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(),
        title: Center(child: bodyDarkText("Devices")),
        actions: [
          Container(),
        ],
      ),
      drawer: NavigationDrawer(),
      body: buildMainView(),
    );
  }

// build main view (using Listview)
  Widget buildMainView() {
    return ListView(
      children: <Widget>[
        displayDevice("Doorbell", "cam_pic_01.png"),
        displayDevice("Garden", "cam_pic_02.png"),
        displayDevice("Gate-02", "cam_pic_03.png"),
      ],
    );
  }

// build to display camera
  Widget displayDevice(String camLocation, String camName) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route.videoPlayerView);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(14),
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('$imagePath$camName'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const ImageIcon(
                    AssetImage(appSettingIcon),
                  ),
                  color: AppColors.white,
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pushNamed(context, route.cameraSettingView);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}//end
