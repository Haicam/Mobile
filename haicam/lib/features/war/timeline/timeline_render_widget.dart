import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../menu_data.dart';
import 'ticks.dart';
import 'timeline.dart';
import 'timeline_entry.dart';
import 'timeline_utils.dart';

/// These two callbacks are used to detect if a bubble or an entry have been tapped.
/// If that's the case, [ArticlePage] will be pushed onto the [Navigator] stack.
typedef TouchBubbleCallback = Function(TapTarget bubble);
typedef TouchEntryCallback = Function(TimelineEntry entry);

/// This couples with [TimelineRenderObject].
///
/// This widget's fields are accessible from the [RenderBox] so that it can
/// be aligned with the current state.
class TimelineRenderWidget extends LeafRenderObjectWidget {
  final double? topOverlap;
  final Timeline? timeline;
  final MenuItemData? focusItem;
  final TouchBubbleCallback? touchBubble;
  final TouchEntryCallback? touchEntry;

  const TimelineRenderWidget(
      {Key? key,
      this.focusItem,
      this.touchBubble,
      this.touchEntry,
      this.topOverlap,
      this.timeline})
      : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return TimelineRenderObject()
      ..timeline = timeline!
      ..touchBubble = touchBubble!
      ..touchEntry = touchEntry!
      ..focusItem = focusItem!
      ..topOverlap = topOverlap!;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant TimelineRenderObject renderObject) {
    renderObject
      ..timeline = timeline!
      ..focusItem = focusItem!
      ..touchBubble = touchBubble!
      ..touchEntry = touchEntry!
      ..topOverlap = topOverlap!;
  }

  @override
  didUnmountRenderObject(covariant TimelineRenderObject renderObject) {
    renderObject.timeline.isActive = false;
  }
}

/// A custom renderer is used for the the timeline object.
/// The [Timeline] serves as an abstraction layer for the positioning and advancing logic.
///
/// The core method of this object is [paint()]: this is where all the elements
/// are actually drawn to screen.
class TimelineRenderObject extends RenderBox {
  static const List<Color> LineColors = [
    Color.fromARGB(255, 125, 195, 184),
    Color.fromARGB(255, 190, 224, 146),
    Color.fromARGB(255, 238, 155, 75),
    Color.fromARGB(255, 202, 79, 63),
    Color.fromARGB(255, 128, 28, 15)
  ];

  double _topOverlap = 0.0;
  final Ticks _ticks = Ticks();
  Timeline? _timeline;
  MenuItemData? _focusItem;
  MenuItemData? _processedFocusItem;
  final List<TapTarget> _tapTargets = <TapTarget>[];

  TouchBubbleCallback? touchBubble;
  TouchEntryCallback? touchEntry;

  @override
  bool get sizedByParent => true;

  double get topOverlap => _topOverlap;

  Timeline get timeline => _timeline!;

  MenuItemData get focusItem => _focusItem!;

  set topOverlap(double value) {
    if (_topOverlap == value) {
      return;
    }
    _topOverlap = value;
    updateFocusItem();
    markNeedsPaint();
    markNeedsLayout();
  }

  set timeline(Timeline value) {
    if (_timeline == value) {
      return;
    }
    _timeline = value;
    updateFocusItem();
    _timeline!.onNeedPaint = markNeedsPaint;
    markNeedsPaint();
    markNeedsLayout();
  }

  set focusItem(MenuItemData value) {
    if (_focusItem == value) {
      return;
    }
    _focusItem = value;
    _processedFocusItem = null;
    updateFocusItem();
  }

  /// If [_focusItem] has been updated with a new value, update the current view.
  void updateFocusItem() {
    if (_processedFocusItem == _focusItem) {
      return;
    }
    if (_focusItem == null || topOverlap == 0.0) {
      return;
    }

    //CHKME select focusItem from the main menu, timeline.setViewport(_focusItem.start & focusItem.end)
    /// Adjust the current timeline padding and consequentely the viewport.
    if (_focusItem!.pad) {
      timeline.padding = EdgeInsets.only(
          top: topOverlap + _focusItem!.padTop + Timeline.Parallax,
          bottom: _focusItem!.padBottom);
      timeline.setViewport(
          start: _focusItem!.start,
          end: _focusItem!.end,
          animate: true,
          pad: true);
    } else {
      timeline.padding = EdgeInsets.zero;
      timeline.setViewport(
          start: _focusItem!.start, end: _focusItem!.end, animate: true);
    }
    _processedFocusItem = _focusItem;
  }

  /// Check if the current tap on the screen has hit a bubble.
  @override
  bool hitTestSelf(Offset screenOffset) {
    // touchEntry(null);
    for (TapTarget bubble in _tapTargets.reversed) {
      if (bubble.rect.contains(screenOffset)) {
        if (touchBubble != null) {
          touchBubble!(bubble);
        }
        return true;
      }
    }
    // touchBubble(null);

    return true;
  }

  @override
  void performResize() {
    size = constraints.biggest;
  }

  /// Adjust the viewport when needed.
  @override
  void performLayout() {
    if (_timeline != null) {
      _timeline!.setViewport(height: size.height, animate: true);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    if (_timeline == null) {
      return;
    }

    /// Fetch the background colors from the [Timeline] and compute the fill.
    List<TimelineBackgroundColor>? backgroundColors = timeline.backgroundColors;
    ui.Paint backgroundPaint;
    if (backgroundColors != null && backgroundColors.isNotEmpty) {
      double? rangeStart = backgroundColors.first.start;
      double range =
          backgroundColors.last.start! - backgroundColors.first.start!;
      List<ui.Color> colors = <ui.Color>[];
      List<double> stops = <double>[];
      for (TimelineBackgroundColor bg in backgroundColors) {
        colors.add(bg.color!);
        stops.add((bg.start! - rangeStart!) / range);
      }
      double s =
          timeline.computeScale(timeline.renderStart, timeline.renderEnd);
      double y1 = (backgroundColors.first.start! - timeline.renderStart) * s;
      double y2 = (backgroundColors.last.start! - timeline.renderStart) * s;

      /// Fill Background.
      backgroundPaint = ui.Paint()
        ..shader = ui.Gradient.linear(
            ui.Offset(0.0, y1), ui.Offset(0.0, y2), colors, stops)
        ..style = ui.PaintingStyle.fill;

      if (y1 > offset.dy) {
        canvas.drawRect(
            Rect.fromLTWH(
                offset.dx, offset.dy, size.width, y1 - offset.dy + 1.0),
            ui.Paint()..color = backgroundColors.first.color!);
      }

      /// Draw the background on the canvas.
      canvas.drawRect(
          Rect.fromLTWH(offset.dx, y1, size.width, y2 - y1), backgroundPaint);
    }

    _tapTargets.clear();
    double renderStart = _timeline!.renderStart;
    double renderEnd = _timeline!.renderEnd;
    double scale = size.height / (renderEnd - renderStart);

    if (timeline.renderAssets != null) {
      canvas.save();
      canvas.clipRect(offset & size);
      for (TimelineAsset asset in timeline.renderAssets!) {
        if (asset.opacity > 0) {
          double rs = 0.2 + asset.scale * 0.8;

          double w = asset.width * Timeline.AssetScreenScale;
          double h = asset.height * Timeline.AssetScreenScale;

          /// Draw the correct asset.
          if (asset is TimelineImage) {
            canvas.drawImageRect(
                asset.image,
                Rect.fromLTWH(0.0, 0.0, asset.width, asset.height),
                Rect.fromLTWH(
                    offset.dx + size.width - w, asset.y, w * rs, h * rs),
                Paint()
                  ..isAntiAlias = true
                  ..filterQuality = ui.FilterQuality.low
                  ..color = Colors.white.withOpacity(asset.opacity));
          }
        }
      }
      canvas.restore();
    }

    /// Paint the [Ticks] on the left side of the screen.
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(
        offset.dx, offset.dy + topOverlap, size.width, size.height));
    _ticks.paint(
        context, offset, -renderStart * scale, scale, size.height, timeline);
    canvas.restore();

    /// And then draw the rest of the timeline.
    if (_timeline!.entries != null) {
      canvas.save();
      canvas.clipRect(Rect.fromLTWH(offset.dx + _timeline!.gutterWidth,
          offset.dy, size.width - _timeline!.gutterWidth, size.height));
      drawItems(
          context,
          offset,
          _timeline!.entries!,
          _timeline!.gutterWidth +
              Timeline.LineSpacing -
              Timeline.DepthOffset * _timeline!.renderOffsetDepth,
          scale,
          0);
      canvas.restore();
    }

    /// After a few moments of inaction on the timeline, if there's enough space,
    /// an arrow pointing to the next event on the timeline will appear on the bottom of the screen.
    /// Draw it, and add it as another [TapTarget].
    if (_timeline!.nextEntry != null && _timeline!.nextEntryOpacity > 0.0) {
      double x = offset.dx + _timeline!.gutterWidth - Timeline.GutterLeft;
      double opacity = _timeline!.nextEntryOpacity;
      Color color = Color.fromRGBO(69, 211, 197, opacity);
      double pageSize = (_timeline!.renderEnd - _timeline!.renderStart);
      double pageReference = _timeline!.renderEnd;

      /// Use a Paragraph to draw the arrow's label and page scrolls on canvas:
      /// 1. Create a [ParagraphBuilder] that'll be initialized with the correct styling information;
      /// 2. Add some text to the builder;
      /// 3. Build the [Paragraph];
      /// 4. Lay out the text with custom [ParagraphConstraints].
      /// 5. Draw the Paragraph at the right offset.
      const double maxLabelWidth = 1200.0;
      ui.ParagraphBuilder builder = ui.ParagraphBuilder(ui.ParagraphStyle(
          textAlign: TextAlign.start, fontFamily: "Roboto", fontSize: 20.0))
        ..pushStyle(ui.TextStyle(color: color));

      builder.addText(_timeline!.nextEntry!.label);
      ui.Paragraph labelParagraph = builder.build();
      labelParagraph
          .layout(const ui.ParagraphConstraints(width: maxLabelWidth));

      double y = offset.dy + size.height - 200.0;
      double labelX =
          x + size.width / 2.0 - labelParagraph.maxIntrinsicWidth / 2.0;
      canvas.drawParagraph(labelParagraph, Offset(labelX, y));
      y += labelParagraph.height;

      /// Calculate the boundaries of the arrow icon.
      Rect nextEntryRect = Rect.fromLTWH(labelX, y,
          labelParagraph.maxIntrinsicWidth, offset.dy + size.height - y);

      const double radius = 25.0;
      labelX = x + size.width / 2.0;
      y += 15 + radius;

      /// Draw the background circle.
      canvas.drawCircle(
          Offset(labelX, y),
          radius,
          Paint()
            ..color = color
            ..style = PaintingStyle.fill);
      nextEntryRect.expandToInclude(Rect.fromLTWH(
          labelX - radius, y - radius, radius * 2.0, radius * 2.0));
      Path path = Path();
      double arrowSize = 6.0;
      double arrowOffset = 1.0;

      /// Draw the stylized arrow on top of the circle.
      path.moveTo(x + size.width / 2.0 - arrowSize,
          y - arrowSize + arrowSize / 2.0 + arrowOffset);
      path.lineTo(x + size.width / 2.0, y + arrowSize / 2.0 + arrowOffset);
      path.lineTo(x + size.width / 2.0 + arrowSize,
          y - arrowSize + arrowSize / 2.0 + arrowOffset);
      canvas.drawPath(
          path,
          Paint()
            ..color = Colors.white.withOpacity(opacity)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0);
      y += 15 + radius;

      builder = ui.ParagraphBuilder(ui.ParagraphStyle(
          textAlign: TextAlign.center,
          fontFamily: "Roboto",
          fontSize: 14.0,
          height: 1.3))
        ..pushStyle(ui.TextStyle(color: color));

      double timeUntil = _timeline!.nextEntry!.start - pageReference;
      double pages = timeUntil / pageSize;
      NumberFormat formatter = NumberFormat.compact();
      String pagesFormatted = formatter.format(pages);
      String until =
          "in ${TimelineEntry.formatYears(timeUntil).toLowerCase()}\n($pagesFormatted page scrolls)";
      builder.addText(until);
      labelParagraph = builder.build();
      labelParagraph.layout(ui.ParagraphConstraints(width: size.width));

      /// Draw the Paragraph beneath the circle.
      canvas.drawParagraph(labelParagraph, Offset(x, y));
      y += labelParagraph.height;

      /// Add this to the list of *tappable* elements.
      _tapTargets.add(TapTarget()
        ..entry = _timeline!.nextEntry!
        ..rect = nextEntryRect
        ..zoom = true);
    }

    /// Repeat the same procedure as above for the arrow pointing to the previous event on the timeline.
    if (_timeline!.prevEntry != null && _timeline!.prevEntryOpacity > 0.0) {
      double x = offset.dx + _timeline!.gutterWidth - Timeline.GutterLeft;
      double opacity = _timeline!.prevEntryOpacity;
      Color color = Color.fromRGBO(69, 211, 197, opacity);
      double pageSize = (_timeline!.renderEnd - _timeline!.renderStart);
      double pageReference = _timeline!.renderEnd;

      const double maxLabelWidth = 1200.0;
      ui.ParagraphBuilder builder = ui.ParagraphBuilder(ui.ParagraphStyle(
          textAlign: TextAlign.start, fontFamily: "Roboto", fontSize: 20.0))
        ..pushStyle(ui.TextStyle(color: color));

      builder.addText(_timeline!.prevEntry!.label);
      ui.Paragraph labelParagraph = builder.build();
      labelParagraph
          .layout(const ui.ParagraphConstraints(width: maxLabelWidth));

      double y = offset.dy + topOverlap + 20.0;
      double labelX =
          x + size.width / 2.0 - labelParagraph.maxIntrinsicWidth / 2.0;
      canvas.drawParagraph(labelParagraph, Offset(labelX, y));
      y += labelParagraph.height;

      Rect prevEntryRect = Rect.fromLTWH(labelX, y,
          labelParagraph.maxIntrinsicWidth, offset.dy + size.height - y);

      const double radius = 25.0;
      labelX = x + size.width / 2.0;
      y += 15 + radius;
      canvas.drawCircle(
          Offset(labelX, y),
          radius,
          Paint()
            ..color = color
            ..style = PaintingStyle.fill);
      prevEntryRect.expandToInclude(Rect.fromLTWH(
          labelX - radius, y - radius, radius * 2.0, radius * 2.0));
      Path path = Path();
      double arrowSize = 6.0;
      double arrowOffset = 1.0;
      path.moveTo(
          x + size.width / 2.0 - arrowSize, y + arrowSize / 2.0 + arrowOffset);
      path.lineTo(x + size.width / 2.0, y - arrowSize / 2.0 + arrowOffset);
      path.lineTo(
          x + size.width / 2.0 + arrowSize, y + arrowSize / 2.0 + arrowOffset);
      canvas.drawPath(
          path,
          Paint()
            ..color = Colors.white.withOpacity(opacity)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0);
      y += 15 + radius;

      builder = ui.ParagraphBuilder(ui.ParagraphStyle(
          textAlign: TextAlign.center,
          fontFamily: "Roboto",
          fontSize: 14.0,
          height: 1.3))
        ..pushStyle(ui.TextStyle(color: color));

      double timeUntil = _timeline!.prevEntry!.start - pageReference;
      double pages = timeUntil / pageSize;
      NumberFormat formatter = NumberFormat.compact();
      String pagesFormatted = formatter.format(pages.abs());
      String until =
          "${TimelineEntry.formatYears(timeUntil).toLowerCase()} ago\n($pagesFormatted page scrolls)";
      builder.addText(until);
      labelParagraph = builder.build();
      labelParagraph.layout(ui.ParagraphConstraints(width: size.width));
      canvas.drawParagraph(labelParagraph, Offset(x, y));
      y += labelParagraph.height;

      _tapTargets.add(TapTarget()
        ..entry = _timeline!.prevEntry!
        ..rect = prevEntryRect
        ..zoom = true);
    }
  }

  /// Given a list of [entries], draw the label with its bubble beneath.
  /// Draw also the dots&lines on the left side of the timeline. These represent
  /// the starting/ending points for a given event and are meant to give the idea of
  /// the timespan encompassing that event, as well as putting the vent into context
  /// relative to the other events.
  void drawItems(PaintingContext context, Offset offset,
      List<TimelineEntry> entries, double x, double scale, int depth) {
    final Canvas canvas = context.canvas;

    for (TimelineEntry item in entries) {
      if (!item.isVisible ||
          item.y > size.height + Timeline.BubbleHeight ||
          item.endY < -Timeline.BubbleHeight) {
        /// Don't paint this item.
        continue;
      }

      double legOpacity = item.legOpacity * item.opacity;
      Offset entryOffset = Offset(x + Timeline.LineWidth / 2.0, item.y);

      /// Draw the small circle on the left side of the timeline.
      canvas.drawCircle(entryOffset, Timeline.EdgeRadius,
          Paint()..color = (item.accent != null
                    ? item.accent!
                    : LineColors[depth % LineColors.length])
                .withOpacity(item.opacity));
      if (legOpacity > 0.0) {
        Paint legPaint = Paint()..color = (item.accent != null
                  ? item.accent!
                  : LineColors[depth % LineColors.length])
              .withOpacity(legOpacity);

        /// Draw the line connecting the start&point of this item on the timeline.
        canvas.drawRect(
            Offset(x, item.y) & Size(Timeline.LineWidth, item.length),
            legPaint);
        canvas.drawCircle(
            Offset(x + Timeline.LineWidth / 2.0, item.y + item.length),
            Timeline.EdgeRadius,
            legPaint);
      }

      const double maxLabelWidth = 1200.0;
      const double bubblePadding = 20.0;

      /// Let the timeline calculate the height for the current item's bubble.
      double bubbleHeight = timeline.bubbleHeight(item);

      /// Use [ui.ParagraphBuilder] to construct the label for canvas.
      ui.ParagraphBuilder builder = ui.ParagraphBuilder(ui.ParagraphStyle(
          textAlign: TextAlign.start, fontFamily: "Roboto", fontSize: 20.0))
        ..pushStyle(
            ui.TextStyle(color: const Color.fromRGBO(255, 255, 255, 1.0)));

      builder.addText(item.label);
      ui.Paragraph labelParagraph = builder.build();
      labelParagraph
          .layout(const ui.ParagraphConstraints(width: maxLabelWidth));

      double textWidth =
          labelParagraph.maxIntrinsicWidth * item.opacity * item.labelOpacity;
      double bubbleX = _timeline!.renderLabelX -
          Timeline.DepthOffset * _timeline!.renderOffsetDepth;
      double bubbleY = item.labelY - bubbleHeight / 2.0;

      canvas.save();
      canvas.translate(bubbleX, bubbleY);

      /// Get the bubble's path based on its width&height, draw it, and then add the label on top.
      Path bubble =
          makeBubblePath(textWidth + bubblePadding * 2.0, bubbleHeight);

      canvas.drawPath(
          bubble,
          Paint()
            ..color = (item.accent != null
                    ? item.accent!
                    : LineColors[depth % LineColors.length])
                .withOpacity(item.opacity * item.labelOpacity));
      canvas
          .clipRect(Rect.fromLTWH(bubblePadding, 0.0, textWidth, bubbleHeight));
      _tapTargets.add(TapTarget()
        ..entry = item
        ..rect = Rect.fromLTWH(
            bubbleX, bubbleY, textWidth + bubblePadding * 2.0, bubbleHeight));

      canvas.drawParagraph(
          labelParagraph,
          Offset(
              bubblePadding, bubbleHeight / 2.0 - labelParagraph.height / 2.0));
      canvas.restore();
      if (item.children != null) {
        /// Draw the other elements in the hierarchy.
        drawItems(context, offset, item.children!, x + Timeline.DepthOffset,
            scale, depth + 1);
      }
    }
  }

  /// Given a width and a height, design a path for the bubble that lies behind events' labels
  /// on the timeline, and return it.
  Path makeBubblePath(double width, double height) {
    const double arrowSize = 19.0;
    const double cornerRadius = 10.0;

    const double circularConstant = 0.55;
    const double icircularConstant = 1.0 - circularConstant;

    Path path = Path();

    path.moveTo(cornerRadius, 0.0);
    path.lineTo(width - cornerRadius, 0.0);
    path.cubicTo(width - cornerRadius + cornerRadius * circularConstant, 0.0,
        width, cornerRadius * icircularConstant, width, cornerRadius);
    path.lineTo(width, height - cornerRadius);
    path.cubicTo(
        width,
        height - cornerRadius + cornerRadius * circularConstant,
        width - cornerRadius * icircularConstant,
        height,
        width - cornerRadius,
        height);
    path.lineTo(cornerRadius, height);
    path.cubicTo(cornerRadius * icircularConstant, height, 0.0,
        height - cornerRadius * icircularConstant, 0.0, height - cornerRadius);

    path.lineTo(0.0, height / 2.0 + arrowSize / 2.0);
    path.lineTo(-arrowSize / 2.0, height / 2.0);
    path.lineTo(0.0, height / 2.0 - arrowSize / 2.0);

    path.lineTo(0.0, cornerRadius);

    path.cubicTo(0.0, cornerRadius * icircularConstant,
        cornerRadius * icircularConstant, 0.0, cornerRadius, 0.0);

    path.close();

    return path;
  }
}
