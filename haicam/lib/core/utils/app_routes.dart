import 'package:flutter/material.dart';

// Define Routes
import 'package:prac_haicam/features/onboarding/view/splash_view.dart';
import 'package:prac_haicam/features/auth/view/login_view.dart';
import 'package:prac_haicam/features/player/view/video_player_view.dart';
import 'package:prac_haicam/features/setting/view/app_setting_view.dart';
import 'package:prac_haicam/features/setting/view/cam_setting_view.dart';
import 'package:prac_haicam/features/device/view/device_view.dart';
import 'package:prac_haicam/features/home/view/home_view.dart';
import 'package:prac_haicam/features/war/timeline/timeline_widget.dart';

// Route names
const String splashView = 'splash';
const String loginView = 'login';
const String homeView = 'home';
const String deviceView = 'device';
const String appSettingView = 'appSetting';
const String cameraSettingView = 'cameraSetting';
const String videoPlayerView = 'videoPlayer';
const String worldWarView = 'worldWarView';

// Route controller for view flow.
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case splashView:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case loginView:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case homeView:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case deviceView:
      return MaterialPageRoute(builder: (context) => const DeviceView());
    case appSettingView:
      return MaterialPageRoute(builder: (context) => const AppSettingView());
    case cameraSettingView:
      return MaterialPageRoute(builder: (context) => const CameraSettingView());
    case videoPlayerView:
      return MaterialPageRoute(builder: (context) => const VideoPlayerView());
    case worldWarView:
      return MaterialPageRoute(builder: (context) => TimelineWidget(platform: Theme.of(context).platform));
    default:
      throw ('This route name does not exit');
  }
}
