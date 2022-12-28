import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../blocs/models/camera.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants.dart';
import '../../player/widget/set_dialog.dart';
import '../colors.dart';
import '../menu_data.dart';
import 'timeline.dart';
import 'timeline_entry.dart';
import 'timeline_render_widget.dart';
import 'timeline_utils.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

typedef ShowMenuCallback = Function();
typedef SelectItemCallback = Function(TimelineEntry item);

/// This is the Stateful Widget associated with the Timeline object.
/// It is built from a [focusItem], that is the event the [Timeline] should
/// focus on when it's created.
class TimelineWidget extends StatefulWidget {
  final MenuItemData focusItem = MenuItemData();
  final Timeline? timeline;

  TimelineWidget({Key? key, TargetPlatform? platform = TargetPlatform.iOS})
      : timeline = Timeline(platform!),
        super(key: key) {
    focusItem.label = "World War II";
    focusItem.start = 1930;
    focusItem.end = 1955;

    timeline!
        .loadFromBundle("assets/timeline/timeline.json")
        .then((List<TimelineEntry> entries) {

          timeline!.setViewport(
            start: focusItem.start,
            end: focusItem.end,
            animate: true);

      /// Advance the timeline to its starting position.
      timeline!.advance(0.0, false);
    });
  }

  @override
  TimelineWidgetState createState() => TimelineWidgetState();
}

class TimelineWidgetState extends State<TimelineWidget> {

  //Video Player
  VlcPlayerController? _videoPlayerController;
  Camera? camera;

  DateTime? dateTime;
  //set date formatting
  final DateFormat dateFormat = DateFormat('hh:mm');

  static const String DefaultEraName = "Birth of the Universe";
  static const double TopOverlap = 56.0;

  /// These variables are used to calculate the correct viewport for the timeline
  /// when performing a scaling operation as in [_scaleStart], [_scaleUpdate], [_scaleEnd].
  Offset? _lastFocalPoint;
  double _scaleStartYearStart = -100.0;
  double _scaleStartYearEnd = 100.0;

  /// When touching a bubble on the [Timeline] keep track of which
  /// element has been touched in order to move to the [article_widget].
  TapTarget? _touchedBubble;
  TimelineEntry? _touchedEntry;

  /// Which era the Timeline is currently focused on.
  /// Defaults to [DefaultEraName].
  String? _eraName;

  /// Syntactic-sugar-getter.
  Timeline? get timeline => widget.timeline;

  Color? _headerTextColor;
  Color? _headerBackgroundColor;

  /// This state variable toggles the rendering of the left sidebar
  /// showing the favorite elements already on the timeline.
  bool _showFavorites = false;

  /// The following three functions define are the callbacks used by the
  /// [GestureDetector] widget when rendering this widget.
  /// First gather the information regarding the starting point of the scaling operation.
  /// Then perform the update based on the incoming [ScaleUpdateDetails] data,
  /// and pass the relevant information down to the [Timeline], so that it can display
  /// all the relevant information properly.
  void _scaleStart(ScaleStartDetails details) {
    _lastFocalPoint = details.focalPoint;
    _scaleStartYearStart = timeline!.start;
    _scaleStartYearEnd = timeline!.end;
    timeline!.isInteracting = true;
    timeline!.setViewport(velocity: 0.0, animate: true);
  }

  void _scaleUpdate(ScaleUpdateDetails details) {
    double changeScale = details.scale;
    double scale =
        (_scaleStartYearEnd - _scaleStartYearStart) / context.size!.height;

    double focus = _scaleStartYearStart + details.focalPoint.dy * scale;
    double focalDiff =
        (_scaleStartYearStart + _lastFocalPoint!.dy * scale) - focus;
    timeline!.setViewport(
        start: focus + (_scaleStartYearStart - focus) / changeScale + focalDiff,
        end: focus + (_scaleStartYearEnd - focus) / changeScale + focalDiff,
        height: context.size!.height,
        animate: true);
  }

  void _scaleEnd(ScaleEndDetails details) {
    timeline!.isInteracting = false;
    timeline!.setViewport(
        velocity: details.velocity.pixelsPerSecond.dy, animate: true);
  }

  /// The following two callbacks are passed down to the [TimelineRenderWidget] so
  /// that it can pass the information back to this widget.
  onTouchBubble(TapTarget bubble) {
    _touchedBubble = bubble;
  }

  onTouchEntry(TimelineEntry entry) {
    _touchedEntry = entry;
  }

  void _tapDown(TapDownDetails details) {
    timeline!.setViewport(velocity: 0.0, animate: true);
  }

  /// If the [TimelineRenderWidget] has set the [_touchedBubble] to the currently
  /// touched bubble on the timeline, upon removing the finger from the screen,
  /// the app will check if the touch operation consists of a zooming operation.
  ///
  /// If it is, adjust the layout accordingly.
  /// Otherwise trigger a [Navigator.push()] for the tapped bubble. This moves
  /// the app into the [ArticleWidget].
  void _tapUp(TapUpDetails details) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    if (_touchedBubble != null) {
      if (_touchedBubble!.zoom) {
        MenuItemData target = MenuItemData.fromEntry(_touchedBubble!.entry);

        timeline!.padding = EdgeInsets.only(
            top: TopOverlap +
                devicePadding.top +
                target.padTop +
                Timeline.Parallax,
            bottom: target.padBottom);
        timeline!.setViewport(
            start: target.start, end: target.end, animate: true, pad: true);
      } else {
        /*widget.timeline.isActive = false;

        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    ArticleWidget(article: _touchedBubble.entry)))
            .then((v) => widget.timeline.isActive = true);*/
      }
    } else if (_touchedEntry != null) {
      MenuItemData target = MenuItemData.fromEntry(_touchedEntry!);

      timeline!.padding = EdgeInsets.only(
          top: TopOverlap +
              devicePadding.top +
              target.padTop +
              Timeline.Parallax,
          bottom: target.padBottom);
      timeline!.setViewport(
          start: target.start, end: target.end, animate: true, pad: true);
    }
  }

  /// When performing a long-press operation, the viewport will be adjusted so that
  /// the visible start and end times will be updated according to the [TimelineEntry]
  /// information. The long-pressed bubble will float to the top of the viewport,
  /// and the viewport will be scaled appropriately.
  void _longPress() {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    if (_touchedBubble != null) {
      MenuItemData target = MenuItemData.fromEntry(_touchedBubble!.entry);

      timeline!.padding = EdgeInsets.only(
          top: TopOverlap +
              devicePadding.top +
              target.padTop +
              Timeline.Parallax,
          bottom: target.padBottom);
      timeline!.setViewport(
          start: target.start, end: target.end, animate: true, pad: true);
    }
  }

  @override
  initState() {
    super.initState();
    if (timeline != null) {
      widget.timeline!.isActive = true;
      _eraName = timeline!.currentEra != null
          ? timeline!.currentEra!.label
          : DefaultEraName;
      timeline!.onHeaderColorsChanged = (Color background, Color text) {
        setState(() {
          _headerTextColor = text;
          _headerBackgroundColor = background;
        });
      };

      /// Update the label for the [Timeline] object.
      timeline!.onEraChanged = (TimelineEntry? entry) {
        setState(() {
          _eraName = entry != null ? entry.label : DefaultEraName;
        });
      };

      _headerTextColor = timeline!.headerTextColor;
      _headerBackgroundColor = timeline!.headerBackgroundColor;
      _showFavorites = timeline!.showFavorites;
    }
    //initializeVideoPlayer();
  }

  // dispose state of view
  @override
  void dispose() {
    super.dispose();
    //stopVideoPlayer();
  }

  /// Update the current view and change the timeline header, color and background color,
  @override
  void didUpdateWidget(covariant TimelineWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (timeline != oldWidget.timeline && timeline != null) {
      setState(() {
        _headerTextColor = timeline!.headerTextColor;
        _headerBackgroundColor = timeline!.headerBackgroundColor;
      });

      timeline!.onHeaderColorsChanged = (Color background, Color text) {
        setState(() {
          _headerTextColor = text;
          _headerBackgroundColor = background;
        });
      };
      timeline!.onEraChanged = (TimelineEntry? entry) {
        setState(() {
          _eraName = entry != null ? entry.label : DefaultEraName;
        });
      };
      setState(() {
        _eraName = (timeline!.currentEra ?? DefaultEraName) as String?;
        _showFavorites = timeline!.showFavorites;
      });
    }
  }

  /// This is a [StatefulWidget] life-cycle method. It's being overridden here
  /// so that we can properly update the [Timeline] widget.
  @override
  deactivate() {
    super.deactivate();
    if (timeline != null) {
      timeline!.onHeaderColorsChanged = null;
      timeline!.onEraChanged = null;
    }
  }

  /// This widget is wrapped in a [Scaffold] to have the classic Material Design visual layout structure.
  /// Then the body of the app is made of a [GestureDetector] to properly handle all the user-input events.
  /// This widget then lays down a [Stack]:
  ///   - [TimelineRenderWidget] renders the actual contents of the timeline such as the currently visible
  ///   bubbles with their corresponding [FlareWidget]s, the left bar with the ticks, etc.
  ///   - [BackdropFilter] that wraps the top header bar, with the back button, the favorites button, and its coloring.
  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    if (timeline != null) {
      timeline!.devicePadding = devicePadding;
    }

    return GestureDetector(
        onLongPress: _longPress,
        onTapDown: _tapDown,
        onScaleStart: _scaleStart,
        onScaleUpdate: _scaleUpdate,
        onScaleEnd: _scaleEnd,
        onTapUp: _tapUp,
        child: TimelineRenderWidget(
            timeline: timeline,
            //topOverlap: TopOverlap + devicePadding.top,
            topOverlap: devicePadding.top,
            focusItem: widget.focusItem,
            touchBubble: onTouchBubble,
            touchEntry: onTouchEntry));

    /*return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomTabActions(),
      body: GestureDetector(
          onLongPress: _longPress,
          onTapDown: _tapDown,
          onScaleStart: _scaleStart,
          onScaleUpdate: _scaleUpdate,
          onScaleEnd: _scaleEnd,
          onTapUp: _tapUp,
          child: Stack(children: <Widget>[
            Padding(padding: EdgeInsets.only(top:0 ),
              child: TimelineRenderWidget(
                  timeline: timeline,
                  topOverlap: TopOverlap + devicePadding.top,
                  focusItem: widget.focusItem,
                  touchBubble: onTouchBubble,
                  touchEntry: onTouchEntry),),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[

              Container(
                  height: devicePadding.top,
                  color: _headerBackgroundColor ??
                      const Color.fromRGBO(238, 240, 242, 0.81)),
              Container(
                  color: _headerBackgroundColor ??
                      const Color.fromRGBO(238, 240, 242, 0.81),
                  height: 56.0,
                  width: double.infinity,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          color:
                              _headerTextColor ?? Colors.black.withOpacity(0.5),
                          alignment: Alignment.centerLeft,
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            widget.timeline!.isActive = false;
                            Navigator.of(context).pop();
                            // return true;
                          },
                        ),
                        Text(
                          _eraName!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "RobotoMedium",
                              fontSize: 20.0,
                              color: _headerTextColor ??
                                  darkText
                                      .withOpacity(darkText.opacity * 0.75)),
                        ),
                        Expanded(
                            child: GestureDetector(
                                child: Transform.translate(
                                    offset: const Offset(0.0, 0.0),
                                    child: Container(
                                        height: 60.0,
                                        width: 60.0,
                                        padding: const EdgeInsets.all(18.0),
                                        color: Colors.white.withOpacity(0.0))),
                                onTap: () {
                                  timeline!.showFavorites =
                                      !timeline!.showFavorites;
                                  setState(() {
                                    _showFavorites = timeline!.showFavorites;
                                  });
                                })),
                      ])),
              //getViedoPlayer(),
            ]),
          ])),
    );*/
  }

  // build bottom tab
  Widget _buildBottomTabActions() {
    double iconSize = 32;
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.calendar_month),
                  color: AppColors.darkGrey,
                  iconSize: iconSize,
                  onPressed: onTapCalendarTab),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.volume_down_alt),
                color: AppColors.darkGrey,
                iconSize: iconSize,
                onPressed: onTapSpeakerTab,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.mic_outlined),
                  color: AppColors.darkGrey,
                  iconSize: iconSize,
                  onPressed: onTapMicTab),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.forward_10),
                color: AppColors.darkGrey,
                iconSize: iconSize,
                onPressed: onTapForwardITab,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.circle_sharp),
                color: AppColors.darkGrey,
                iconSize: iconSize,
                onPressed: onTapCircleTab,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // set get Date for timestamp view
  String getDate(String string) {
    if (dateTime == null) {
      return string;
    } else {
      return dateFormat.format(DateTime.parse(dateTime.toString()));
    }
  }

  //on Tap calendar icon
  onTapCalendarTab() {
    pickDateAndTime(context);
  }

  //on Tap Speaker icon
  onTapSpeakerTab() {}

  //on Tap Mic icon
  onTapMicTab() {}

  //on Tap timelapse forward icon
  onTapForwardITab() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ShowTimelapseBox();
      },
    );
  }

  //on Tap Circle icon
  void onTapCircleTab() {}

  // build time and date picker
  Future pickDateAndTime(BuildContext context) async {
    final initialDate = DateTime.now().toUtc().add(const Duration(hours: -11));
    DateTime? newdateTime = await showOmniDateTimePicker(
      context: context,
      is24HourMode: false,
      isShowSeconds: false,
      startInitialDate: dateTime ?? initialDate,
      startFirstDate:
      DateTime.now().toUtc().subtract(const Duration(days: 365)),
      startLastDate: DateTime.now().toUtc(),
      borderRadius: const Radius.circular(16),
    );
    if (newdateTime == null) return;
    setState(() => dateTime = newdateTime);
    DateTime selectTime = newdateTime;
    // String selectedFormattedTime = DateFormat.jm().format(selectTime);
    selectTime = DateTime(
      selectTime.year,
      selectTime.month,
      selectTime.day,
      selectTime.hour,
      selectTime.minute,
    );
    // print(selectTime);
    // final index =
    //     events.indexWhere((element) => element.dateTime == selectTime);
    // if (index >= 0) {
    //   goToItemIndex(index);
    // }
  }

  double getTopMargin(double deviceTopPadding){
    double calculatedHeight = 200;
    if(camera != null){
      List<String> ratio = camera!.videoSize!.split(":");
      double horizontalRatio = double.parse(ratio[0]);
      double verticalRatio = double.parse(ratio[1]);
      calculatedHeight = (MediaQuery.of(context).size.width * verticalRatio/horizontalRatio);
    }
    Constants.timeTopMargin = 2*calculatedHeight;
    return calculatedHeight+deviceTopPadding/4;

  }


  /**
   * Video Player
   */

  Widget getViedoPlayer() {
    return VlcPlayer(
      controller: _videoPlayerController!,
      aspectRatio: getAspectRatio(),
      placeholder: Center(child: CircularProgressIndicator()),
    );
  }

  double getAspectRatio(){
    List<String> ratio = camera!.videoSize!.split(":");
    double horizontalRatio = double.parse(ratio[0]);
    double verticalRatio = double.parse(ratio[1]);
    return horizontalRatio/verticalRatio;
  }

  void initializeVideoPlayer() {

    camera = Camera();
    camera!.videoSize = "1920:1080";
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