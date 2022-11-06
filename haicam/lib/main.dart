import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';
import 'my_app.dart';

// Build main of app(start) including device preview multiple devices.
void main() {
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

