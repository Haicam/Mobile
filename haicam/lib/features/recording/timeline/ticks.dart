import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/constants.dart';
import 'timeline.dart';
import 'timeline_utils.dart';

/// This class is used by the [TimelineRenderWidget] to render the ticks on the left side of the screen.
///
/// It has a single [paint()] method that's called within [TimelineRenderObject.paint()].
class Ticks {
  /// The following `const` variables are used to properly align, pad and layout the ticks
  /// on the left side of the timeline.
  static const double Margin = 20.0;
  static const double Width = 40.0;
  static const double LabelPadLeft = 5.0;
  static const double LabelPadRight = 1.0;
  static const int TickDistance = 4; //CHKME unit years
  static const int TextTickDistance =
      40; //CHKME unit years, show TextTick every 10 Tick (TextTickDistance = TickDistance * 10)
  static const double TickSize = 20.0;
  static const double MiddleTickSize =
      10.0; //CHKME add one MiddleTick in the middle (ttt % (textTickDistance/2) == 0)
  static const double SmallTickSize = 5.0;

  /// Other than providing the [PaintingContext] to allow the ticks to paint themselves,
  /// other relevant sizing information is passed to this `paint()` method, as well as
  /// a reference to the [Timeline].
  void paint(PaintingContext context, Offset offset, double translation,
      double scale, double height, Timeline timeline) {
    final Canvas canvas = context.canvas;

    //debugPrint("height -> " + height.toString()); //CHKME 730 pixels - the height of window
    //debugPrint("scale -> " + scale.toString()); //CHKME  scale = size.height(730) / (renderEnd(1955) - renderStart(1930));

    double bottom = height;
    double tickDistance = TickDistance.toDouble();
    double textTickDistance = TextTickDistance.toDouble();

    /// The width of the left panel can expand and contract if the favorites-view is activated,
    /// by pressing the button on the top-right corner of the timeline.
    double gutterWidth = timeline.gutterWidth;

    /// Calculate spacing based on current scale
    double scaledTickDistance = tickDistance * scale;
    if (scaledTickDistance > 2 * TickDistance) {
      while (scaledTickDistance > 2 * TickDistance && tickDistance >= 2.0) {
        scaledTickDistance /= 2.0;
        tickDistance /= 2.0;
        textTickDistance /= 2.0;
      }
    } else {
      while (scaledTickDistance < TickDistance) {
        scaledTickDistance *= 2.0;
        tickDistance *= 2.0;
        textTickDistance *= 2.0;
      }
    }

    /// The number of ticks to draw.
    int numTicks = (height / scaledTickDistance).ceil() + 2;
    if (scaledTickDistance > TextTickDistance) {
      textTickDistance = tickDistance;
    }

    //debugPrint("scaledTickDistance -> " + scaledTickDistance.toString());//CHKME pixels of the height of min tick distance
    //debugPrint("numTicks -> " + numTicks.toString()); //CHKME draw how many tickets

    /// Figure out the position of the top left corner of the screen
    double tickOffset = 0.0;
    double startingTickMarkValue = 0.0;
    double y = ((translation - bottom) / scale);
    startingTickMarkValue = y - (y % tickDistance);
    tickOffset = -(y % tickDistance) * scale - scaledTickDistance;

    /// Move back by one tick.
    tickOffset -= scaledTickDistance;
    startingTickMarkValue -= tickDistance;

    /// Ticks can change color because the timeline background will also change color
    /// depending on the current era. The [TickColors] object, in `timeline_utils.dart`,
    /// wraps this information.
    List<TickColors>? tickColors = timeline.tickColors;
    if (tickColors != null && tickColors.isNotEmpty) {
      /// Build up the color stops for the linear gradient.
      double? rangeStart = tickColors.first.start;
      double range = tickColors.last.start! - tickColors.first.start!;
      List<ui.Color> colors = <ui.Color>[];
      List<double> stops = <double>[];
      for (TickColors bg in tickColors) {
        colors.add(bg.background!);
        stops.add((bg.start! - rangeStart!) / range);
      }
      double s =
          timeline.computeScale(timeline.renderStart, timeline.renderEnd);

      /// y-coordinate for the starting and ending element.
      double y1 = (tickColors.first.start! - timeline.renderStart) * s;
      double y2 = (tickColors.last.start! - timeline.renderStart) * s;

      /// Fill Background.
      ui.Paint paint = ui.Paint()
        ..shader = ui.Gradient.linear(
            ui.Offset(0.0, y1), ui.Offset(0.0, y2), colors, stops)
        ..style = ui.PaintingStyle.fill;

      /// Fill in top/bottom if necessary.
      if (y1 > offset.dy) {
        canvas.drawRect(
            Rect.fromLTWH(
                offset.dx, offset.dy, gutterWidth, y1 - offset.dy + 1.0),
            ui.Paint()..color = tickColors.first.background!);
      }
      if (y2 < offset.dy + height) {
        canvas.drawRect(
            Rect.fromLTWH(
                offset.dx, y2 - 1, gutterWidth, (offset.dy + height) - y2),
            ui.Paint()..color = tickColors.last.background!);
      }

      /// Draw the gutter.
      canvas.drawRect(
          Rect.fromLTWH(offset.dx, y1, gutterWidth, y2 - y1), paint);
    } else {
      canvas.drawRect(Rect.fromLTWH(offset.dx, offset.dy, gutterWidth, height),
          Paint()..color = const Color.fromRGBO(246, 246, 246, 0.95));
    }

    //CHKME add a guild line to show date time for current video
    //TODO print the year text in the guild line in the top right of the timeline
    canvas.drawRect(
      Rect.fromLTWH(
          offset.dx + gutterWidth + TickSize + 50, 200, TickSize * 10, 1.0),
      Paint()..color = const Color.fromARGB(255, 255, 0, 0),
    );

    canvas.drawRect(
      Rect.fromLTWH(
          offset.dx + gutterWidth + TickSize, Constants.timeTopMargin, TickSize * 10, 1.0),
      Paint()..color =  Colors.green,
    );

    double currentTime = timeline.renderStart + (timeline.renderEnd - timeline.renderStart) * 200 / height;

    ui.ParagraphBuilder tBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.end, fontFamily: "Roboto", fontSize: 10.0))
      ..pushStyle(ui.TextStyle(color: Colors.black));

    tBuilder.addText(currentTime.toStringAsFixed(0));
    ui.Paragraph tGuildParagraph = tBuilder.build();

    tGuildParagraph.layout(const ui.ParagraphConstraints(width: 200.0));
    canvas.drawParagraph(
        tGuildParagraph,
        Offset((offset.dx + TickSize)/2, Constants.timeTopMargin-20));




    ui.ParagraphBuilder builder = ui.ParagraphBuilder(ui.ParagraphStyle(
            textAlign: TextAlign.end, fontFamily: "Roboto", fontSize: 10.0))
          ..pushStyle(ui.TextStyle(color: const Color.fromARGB(255, 255, 0, 0)));

    builder.addText(currentTime.toStringAsFixed(2));
    ui.Paragraph guildParagraph = builder.build();

    guildParagraph.layout(const ui.ParagraphConstraints(width: 200.0));
    canvas.drawParagraph(
        guildParagraph,
        Offset(offset.dx + gutterWidth + TickSize + 50, 185));

    Set<String> usedValues = <String>{};

    /// Draw all the ticks.
    for (int i = 0; i < numTicks; i++) {
      tickOffset += scaledTickDistance;

      int tt = startingTickMarkValue.round();
      tt = -tt;
      int o = tickOffset.floor();
      TickColors? colors = timeline.findTickColors(offset.dy + height - o);
      if (tt % textTickDistance == 0) {
        /// Every `textTickDistance`, draw a wider tick with the a label laid on top.
        canvas.drawRect(
            Rect.fromLTWH(offset.dx + gutterWidth - TickSize,
                offset.dy + height - o, TickSize, 1.0),
            Paint()..color = colors!.long!);

        /// Drawing text to [canvas] is done by using the [ParagraphBuilder] directly.
        ui.ParagraphBuilder builder = ui.ParagraphBuilder(ui.ParagraphStyle(
            textAlign: TextAlign.end, fontFamily: "Roboto", fontSize: 10.0))
          ..pushStyle(ui.TextStyle(color: colors.text));

        int value = tt.round().abs();

        /// Format the label nicely depending on how long ago the tick is placed at.
        String label;
        if (value < 9000) {
          label = value.toStringAsFixed(0);
        } else {
          NumberFormat formatter = NumberFormat.compact();
          label = formatter.format(value);
          int? digits = formatter.significantDigits;
          while (usedValues.contains(label) && digits! < 10) {
            formatter.significantDigits = ++digits;
            label = formatter.format(value);
          }
        }
        usedValues.add(label);
        builder.addText(label);
        ui.Paragraph tickParagraph = builder.build();
        tickParagraph.layout(ui.ParagraphConstraints(
            width: gutterWidth - LabelPadLeft - LabelPadRight));
        canvas.drawParagraph(
            tickParagraph,
            Offset(offset.dx + LabelPadLeft - LabelPadRight,
                offset.dy + height - o - tickParagraph.height - 5));
      } else {
        if (tt % (textTickDistance / 2) == 0) {
          canvas.drawRect(
              Rect.fromLTWH(offset.dx + gutterWidth - MiddleTickSize,
                  offset.dy + height - o, MiddleTickSize, 1.0),
              Paint()..color = colors!.short!);
        } else {
          /// If we're within two text-ticks, just draw a smaller line.
          canvas.drawRect(
              Rect.fromLTWH(offset.dx + gutterWidth - SmallTickSize,
                  offset.dy + height - o, SmallTickSize, 1.0),
              Paint()..color = colors!.short!);
        }
      }
      startingTickMarkValue += tickDistance;
    }
  }
}
