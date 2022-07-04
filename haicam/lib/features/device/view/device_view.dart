import 'package:flutter/material.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:video_player/video_player.dart';

class DeviceView extends StatefulWidget {
  const DeviceView({Key? key}) : super(key: key);

  @override
  _DeviceViewState createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  late VideoPlayerController videoPlayerController;
  late Future<void> videoPlayerFuture;

  //init state of vie
  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.asset('assets/videos/haicam_intro.mp4')
          ..initialize().then(
            (_) {
              setState(() {});
              videoPlayerController.play();
            },
          );
  }

  // This widget is the root of view.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            // color: Colors.black,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(),
        title: Center(child: appBarTitle("Devices")),
      ),
      body: ListView(
        children: <Widget>[
          videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(videoPlayerController))
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    videoPlayerController.pause();
                  },
                  child: const Icon(Icons.pause)),
              const Padding(padding: EdgeInsets.all(2)),
              ElevatedButton(
                  onPressed: () {
                    videoPlayerController.play();
                  },
                  child: const Icon(Icons.play_arrow))
            ],
          ),
        ],
      ),
    );
  }
//dispose state of view
  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
