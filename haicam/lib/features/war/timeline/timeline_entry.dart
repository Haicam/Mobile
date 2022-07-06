import 'dart:ui' as ui;
import 'dart:ui';

class TimelineAsset {
  double? width;
  double? height;
  double opacity = 0.0;
  double scale = 0.0;
  double scaleVelocity = 0.0;
  double y = 0.0;
  double velocity = 0.0;
  String? filename;
  TimelineEntry? entry;
}

/// A renderable image.
class TimelineImage extends TimelineAsset {
  ui.Image? image;
}

/// A label for [TimelineEntry].
enum TimelineEntryType { Era, Incident }

class TimelineEntry {
  TimelineEntryType? type;

  /// Used to calculate how many lines to draw for the bubble in the timeline.
  int lineCount = 1;
}