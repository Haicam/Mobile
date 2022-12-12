import 'package:flutter/material.dart';
import 'package:prac_haicam/blocs/models/account.dart';
import 'package:prac_haicam/blocs/models/camera.dart';
import 'package:prac_haicam/blocs/patterns/account_bloc.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:prac_haicam/core/utils/app_colors.dart';
import 'package:prac_haicam/core/utils/app_images.dart';
import 'package:prac_haicam/common/drawer/navigation_drawer_widget.dart';

import 'package:prac_haicam/core/utils/app_routes.dart' as route;
import 'package:prac_haicam/features/player/view/video_player_view.dart';

import '../../recording/video_player_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  Account account = Account();
  AccountBloc accountBloc = AccountBloc();
  @override
  initState() {
    super.initState();
    accountBloc.eventSink.add(AccountAction .GetData);
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


// build main view (using Listview)
  Widget buildMainView() {
    return StreamBuilder(
        initialData: Account(),
        stream: accountBloc.accountStream,
        builder: (context, snapshot){
          account = snapshot.data as Account;
          return ListView(
            children: getDataFields(),
          );
        }
    );
  }

  List<Widget> getDataFields(){
    List<Widget> list = [];
    for(Camera pi in account!.cameras){
      list.add(displayDevice(pi));
    }
    return list;
  }

// build to display camera
  Widget displayDevice(Camera pi) {

    String camName = pi.lastImage.toString();

    return InkWell(
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new VideoPlayerWidget(pi)));
        //Navigator.pushNamed(context, route.worldWarView);

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
                  pi.name.toString(),
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
