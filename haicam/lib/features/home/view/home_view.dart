import 'package:flutter/material.dart';
import 'package:prac_haicam/blocs/models/camera.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/app_images.dart';
import 'package:prac_haicam/common/drawer/navigation_drawer_widget.dart';

import 'package:prac_haicam/core/utils/app_routes.dart' as route;
import 'package:prac_haicam/features/player/view/video_player_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<Camera> dataList = [];

  @override
  initState() {
    super.initState();
    setDataList();
  }

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

  void setDataList(){
    Camera pi = Camera();
    pi.name = "Doorbell";
    pi.lastImage = "cam_pic_01.png";
    pi.videoSize = "1920:1080";
    dataList.add(pi);

    pi = Camera();
    pi.name = "Garden";
    pi.lastImage = "cam_pic_02.png";
    pi.videoSize = "1080:1920";
    dataList.add(pi);

    pi = Camera();
    pi.name = "Gate-02";
    pi.lastImage = "cam_pic_03.png";
    pi.videoSize = "1920:1080";
    dataList.add(pi);

  }
// build main view (using Listview)
  Widget buildMainView() {
    return ListView(
      children: getDataFields(),
    );
  }

  List<Widget> getDataFields(){
    List<Widget> list = [];
    for(Camera pi in dataList){
      list.add(displayDevice(pi));
    }
    return list;
  }

// build to display camera
  Widget displayDevice(Camera pi) {

    String camName = pi!.lastImage.toString();

    return InkWell(
      onTap: () {
        //Navigator.pushNamed(context, route.);
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new VideoPlayerView(pi)));
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
                  pi!.name.toString(),
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
