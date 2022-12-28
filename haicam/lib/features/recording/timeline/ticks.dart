import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prac_haicam/core/utils/utils.dart';
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

    debugPrint("height -> " + height.toString()); //CHKME 730 pixels - the height of window
    debugPrint("scale -> " + scale.toString()); //CHKME  scale = size.height(730) / (renderEnd(1955) - renderStart(1930));

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

    //double lineY = 200;
    double lineY = Constants.timeTopMargin;
    canvas.drawRect(
      Rect.fromLTWH(
          offset.dx + gutterWidth + TickSize + 50, lineY, TickSize * 10, 1.0),
      Paint()..color = const Color.fromARGB(255, 255, 0, 0),
    );


    //double currentTime = timeline.renderStart + (timeline.renderEnd - timeline.renderStart) * 200 / height;
    double currentTime = timeline.renderStart + (timeline.renderEnd - timeline.renderStart) * (lineY-lineY/2-80) / height;


    ui.ParagraphBuilder builder = ui.ParagraphBuilder(ui.ParagraphStyle(
            textAlign: TextAlign.end, fontFamily: "Roboto", fontSize: 10.0))
          ..pushStyle(ui.TextStyle(color: const Color.fromARGB(255, 255, 0, 0)));

    builder.addText(currentTime.toStringAsFixed(2));
    ui.Paragraph guildParagraph = builder.build();

    guildParagraph.layout(const ui.ParagraphConstraints(width: 200.0));
    /*canvas.drawParagraph(
        guildParagraph,
        Offset(offset.dx + gutterWidth + TickSize + 50, 185));*/
    canvas.drawParagraph(
        guildParagraph,
        Offset(offset.dx + gutterWidth + TickSize + 50, lineY-20));

    Set<String> usedValues = <String>{};

    /// Format the label nicely depending on how long ago the tick is placed at.
    String? label;

    /// Draw all the ticks.
    print("numTicks = $numTicks");
    if(scale >= height){
      numTicks++;
    }
    for (int i = 0; i < numTicks; i++) {
      tickOffset += scaledTickDistance;

      int tt = startingTickMarkValue.round();
      tt = -tt;
      int o = tickOffset.floor();
      TickColors? colors = timeline.findTickColors(offset.dy + height - o);

      if (tt % textTickDistance == 0) {
        print("*****Match 1*****");
        /*print("tt = $tt");
        print("textTickDistance = $textTickDistance");
        print("scaledTickDistance = $scaledTickDistance");*/

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
        //String label;
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
        print("label = $label");
        usedValues.add(label!);
        builder.addText(label!);
        ui.Paragraph tickParagraph = builder.build();
        tickParagraph.layout(ui.ParagraphConstraints(
            width: gutterWidth - LabelPadLeft - LabelPadRight));
        canvas.drawParagraph(
            tickParagraph,
            Offset(offset.dx + LabelPadLeft - LabelPadRight,
                offset.dy + height - o - tickParagraph.height - 2));





      } else {
        //print("*****Match 2*****");
        if (tt % (textTickDistance / 2) == 0) {
          //print("*****Match 3*****");
          canvas.drawRect(
              Rect.fromLTWH(offset.dx + gutterWidth - MiddleTickSize,
                  offset.dy + height - o, MiddleTickSize, 1.0),
              Paint()..color = colors!.short!);
        } else {
          //print("*****Match 4*****");
          /// If we're within two text-ticks, just draw a smaller line.
          canvas.drawRect(
              Rect.fromLTWH(offset.dx + gutterWidth - SmallTickSize,
                  offset.dy + height - o, SmallTickSize, 1.0),
              Paint()..color = colors!.short!);
        }
      }


      //Draw month
      //double monthzdis = scaledTickDistance/13;
      //print("textTickDistance = $textTickDistance");
      //print("monthzdis = $monthzdis");
      //if(textTickDistance < 2.0 && monthzdis >=26 )
      bool result = false;
      double val = (70*height)/100;
      double timeLineHeight = 0;
      if(scale >= val){
        result = true;
      }
      //if(scale > height)
      {
        timeLineHeight = scaledTickDistance;
      }/*else {
        timeLineHeight = height;
      }*/

      if(result) {
        //timeLineHeight = 600;
        print("scaledTickDistance = $scaledTickDistance");
        print("timeLineHeight = ${timeLineHeight})");
        print("timeLineHeight/12 = ${timeLineHeight/12})");
        double lastMonthYCor = 0;
        for(int i = 1; i < 12; i++){
          print("i = $i");
          double monthYCor = getMonthYCordinate1(label!, i, timeLineHeight);
          print("monthYCor = $monthYCor");
          //print("getMonthYCordinate = ${getMonthYCordinate(label!, i, timeLineHeight  )}");
          lastMonthYCor = lastMonthYCor+monthYCor;
          //double yCor = offset.dy + height + (i*monthzdis) - o;
          double yCor = offset.dy + height + (lastMonthYCor) - o;

          print("lastMonthYCor = $lastMonthYCor");
          canvas.drawRect(
              Rect.fromLTWH(offset.dx + gutterWidth - SmallTickSize,
                  yCor, SmallTickSize, 1.0),
              Paint()..color = colors!.short!);

          ui.ParagraphBuilder monthBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
              textAlign: TextAlign.end, fontFamily: "Roboto", fontSize: 7.0, fontWeight: FontWeight.w500))
            ..pushStyle(ui.TextStyle(color: colors.text));


          monthBuilder.addText(Utils.monthAaryy.elementAt(i));
          ui.Paragraph monthParagraph = monthBuilder.build();
          monthParagraph.layout(ui.ParagraphConstraints(
              width: gutterWidth - LabelPadLeft - LabelPadRight));
          canvas.drawParagraph(
              monthParagraph,
              Offset(offset.dx- LabelPadRight,
                  yCor - monthParagraph.height/2));

          //Draw days of month
          /*if(monthzdis >= 250){
              int numDays = DateUtils.getDaysInMonth(int.parse(label), i);
              //print("numDays = $numDays");
              double dayDistance = monthzdis/(numDays+1);
              //print("dayDistance = $dayDistance");
              for(int j = 1; j<=numDays; j++){

                double yDayCor = yCor + (j*dayDistance);
                canvas.drawRect(
                    Rect.fromLTWH(offset.dx + gutterWidth - SmallTickSize,
                        yDayCor, SmallTickSize, 1.0),
                    Paint()..color = colors!.short!);

                ui.ParagraphBuilder daysBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
                    textAlign: TextAlign.end, fontFamily: "Roboto", fontSize: 7.0))
                  ..pushStyle(ui.TextStyle(color: colors.text));

                daysBuilder.addText(j.toString());
                ui.Paragraph dayParagraph = daysBuilder.build();
                dayParagraph.layout(ui.ParagraphConstraints(
                    width: gutterWidth - LabelPadLeft - LabelPadRight));
                canvas.drawParagraph(
                    dayParagraph,
                    Offset(offset.dx- LabelPadRight,
                        yDayCor - dayParagraph.height/2));
              }
            }*/
        }
      }


      startingTickMarkValue += tickDistance;
    }
  }


  double getMonthYCordinate1(String year, int month, double timelineHeight){



    int yearInt = int.parse(year);
    int numDays = DateUtils.getDaysInMonth(yearInt, month);
    print("numDays = $numDays");
    int currentMonthMilli =   numDays*24*60*60*1000;

    int totalYearMilliSeconds = convertDaysToMilliseconds(getTotalNumberOfDaysInYear(yearInt));

    return ((currentMonthMilli*timelineHeight)/totalYearMilliSeconds);
  }

  int getTotalNumberOfDaysInYear(int year){
      int numDays = 0;
      for(int i = 1; i <=12;i++){
        numDays = numDays + DateUtils.getDaysInMonth(year, 1);
      }
      return numDays;
  }

  int convertDaysToMilliseconds(int numDays){
    return numDays*24*60*60*1000;
  }

}
