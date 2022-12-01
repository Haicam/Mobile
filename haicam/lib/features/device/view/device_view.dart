import 'package:flutter/material.dart';
import 'package:prac_haicam/common/widgets/base_widget.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import '../../../blocs/models/camera.dart';

class DeviceView extends StatefulWidget {
  const DeviceView({Key? key}) : super(key: key);

  @override
  _DeviceViewState createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {

  //Video Player
  VlcPlayerController? _videoPlayerController;


  late Future<void> videoPlayerFuture;

  //init state of vie
  @override
  void initState() {
    super.initState();
   initializeVideoPlayer();
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
          getViedoPlayer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _videoPlayerController!.pause();
                  },
                  child: const Icon(Icons.pause)),
              const Padding(padding: EdgeInsets.all(2)),
              ElevatedButton(
                  onPressed: () {
                    _videoPlayerController!.play();
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
    super.dispose();
    stopVideoPlayer();
  }

  /**
   * Video Player
   */

  Widget getViedoPlayer() {
    return Center(
      child: VlcPlayer(
        controller: _videoPlayerController!,
        aspectRatio: getAspectRatio(),
        placeholder: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  double getAspectRatio(){
    Camera camera = Camera();
    camera.videoSize = "1920:1080";
    List<String> ratio = camera.videoSize!.split(":");
    double horizontalRatio = double.parse(ratio[0]);
    double verticalRatio = double.parse(ratio[1]);
    return horizontalRatio/verticalRatio;
  }

  void initializeVideoPlayer() {

    _videoPlayerController = VlcPlayerController.network(
      //'https://media.w3.org/2010/05/sintel/trailer.mp4',
      'http://samples.mplayerhq.hu/MPEG-4/embedded_subs/1Video_2Audio_2SUBs_timed_text_streams_.mp4',
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  void stopVideoPlayer() async {
    await _videoPlayerController!.stopRendererScanning();
    await _videoPlayerController!.dispose();
  }
}
