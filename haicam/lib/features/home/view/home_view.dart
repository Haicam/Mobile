import 'package:flutter/material.dart';
import 'package:prac_haicam/common/utils/app_colors.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/features/menu/widget/navigation_drawer_widget.dart';
import 'package:prac_haicam/features/setting/view/cam_setting_view.dart';
import 'package:video_player/video_player.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(),
        title: Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: bodyDarkText("Devices"),
        ),
      ),
      drawer: NavigationDrawer(),
      body: mainBuildView(),
    );
  }

  Widget mainBuildView() {
    return ListView(
      children: <Widget>[
        camDisplay("Doorbell", "cam_pic_01.png"),
        camDisplay("Garden", "cam_pic_02.png"),
        camDisplay("Gate-02", "cam_pic_03.png"),
      ],
    );
  }

  Widget camDisplay(String camLocation, String camName) {
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
                  fontSize: 18,
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
                  AssetImage('assets/icons/cam_setting.png'),
                ),
                color: AppColors.white,
                iconSize: 50,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CamSettingView(),
                  ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
