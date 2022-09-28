import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac_haicam/features/theme/bloc/theme_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:prac_haicam/core/utils/app_routes.dart' as route;

import 'package:haicam_ffi/haicam_ffi.dart' as haicam_ffi;

// Build main of app(start) including device preview multiple devices.
void main() {
  haicam_ffi.hello_world();
  runApp(
    DevicePreview(
      enabled: false,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const MyApp(),
    ),
  );
}

// Build MyApp class
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Haicam',
            theme: state.theme,
            onGenerateRoute: route.controller,
            initialRoute: route.splashView,
          );
        },
      ),
    );
  }
}//end
