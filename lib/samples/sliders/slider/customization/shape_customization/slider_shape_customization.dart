///Dart import
import 'dart:ui';

///flutter package import
import 'package:flutter/material.dart';

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Slider import
import 'package:syncfusion_flutter_sliders/sliders.dart';

///Local imports
import '../../../../../model/sample_view.dart';
import '../../../slider_utils.dart';
import 'slider_divisor_customization.dart';
import 'slider_thumb_customization.dart';
import 'slider_tick_customization.dart';

///Renders slider with customized shapes
class ShapeCustomizedSliderPage extends SampleView {
  ///Renders slider with customized shapes
  const ShapeCustomizedSliderPage(Key key) : super(key: key);

  @override
  _ShapeCustomizedSliderPageState createState() =>
      _ShapeCustomizedSliderPageState();
}

class _ShapeCustomizedSliderPageState extends SampleViewState {
  _ShapeCustomizedSliderPageState();
  late Widget slider;

  @override
  void initState() {
    super.initState();
    slider = _ShapeCustomizedSlider();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait ||
            model.isWebFullView
        ? slider
        : SingleChildScrollView(
            child: Container(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 50),
                  child: Container(child: slider),
                )));
  }
}

class _ShapeCustomizedSlider extends SampleView {
  @override
  _ShapeCustomizedSliderState createState() => _ShapeCustomizedSliderState();
}

class _ShapeCustomizedSliderState extends SampleViewState {
  _ShapeCustomizedSliderState();
  double _value = 60.0;
  final double _min = 0.0;
  final double _max = 100.0;

  Widget _buildWebLayout() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width >= 1000 ? 550 : 440,
        child: _buildMobileLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    final double padding = MediaQuery.of(context).size.width / 20.0;
    return Container(
        padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              title('Track'),
              SfSliderTheme(
                  data: SfSliderThemeData(
                    overlayColor: Colors.transparent,
                  ),
                  child: SfSlider(
                    min: _min,
                    max: _max,
                    value: _value,
                    interval: 20.0,
                    showLabels: true,
                    showTicks: true,
                    trackShape: _SfTrackShape(_min, _max),
                    thumbShape: _SfThumbShape(_min, _max),
                    onChanged: (dynamic value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  )),
              columnSpacing40,
              title('Divisor'),
              DivisorCustomizedSlider(),
              columnSpacing40,
              ThumbCustomizedSlider(),
              title('Tick'),
              columnSpacing10,
              TickCustomizedSlider(),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return model.isWebFullView ? _buildWebLayout() : _buildMobileLayout();
  }
}

class _SfTrackShape extends SfTrackShape {
  _SfTrackShape(dynamic min, dynamic max) {
    this.min = min.runtimeType == DateTime
        ? min.millisecondsSinceEpoch.toDouble()
        : min;
    this.max = max.runtimeType == DateTime
        ? max.millisecondsSinceEpoch.toDouble()
        : max;
  }

  late double min;
  late double max;
  double? trackIntermediatePos;

  @override
  void paint(PaintingContext context, Offset offset, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Animation<double> enableAnimation,
      required Paint? inactivePaint,
      required Paint? activePaint,
      required TextDirection textDirection}) {
    final Rect trackRect = getPreferredRect(parentBox, themeData, offset);
    final double actualValue = currentValue.runtimeType == DateTime
        ? currentValue.millisecondsSinceEpoch.toDouble()
        : currentValue;
    final double actualValueInPercent =
        ((actualValue - min) * 100) / (max - min);
    trackIntermediatePos = _getTrackIntermediatePosition(trackRect);

    // low volume track.
    final Paint trackPaint = Paint();
    trackPaint.color = actualValueInPercent <= 80.0 ? Colors.green : Colors.red;
    final Rect lowVolumeRect = Rect.fromLTRB(
        trackRect.left, trackRect.top, thumbCenter!.dx, trackRect.bottom);
    context.canvas.drawRect(lowVolumeRect, trackPaint);

    if (actualValueInPercent <= 80.0) {
      trackPaint.color = Colors.green.withOpacity(0.40);
      final Rect lowVolumeRectWithLessOpacity = Rect.fromLTRB(thumbCenter.dx,
          trackRect.top, trackIntermediatePos!, trackRect.bottom);
      context.canvas.drawRect(lowVolumeRectWithLessOpacity, trackPaint);
    }

    trackPaint.color = Colors.red.withOpacity(0.40);
    final double highTrackLeft =
        actualValueInPercent >= 80.0 ? thumbCenter.dx : trackIntermediatePos!;
    final Rect highVolumeRectWithLessOpacity = Rect.fromLTRB(highTrackLeft,
        trackRect.top, trackRect.width + trackRect.left, trackRect.bottom);
    context.canvas.drawRect(highVolumeRectWithLessOpacity, trackPaint);
  }

  double _getTrackIntermediatePosition(Rect trackRect) {
    final double actualValue = ((80 * (max - min)) + min) / 100;
    return (((actualValue - min) / (max - min)) * trackRect.width) +
        trackRect.left;
  }
}

class _SfThumbShape extends SfThumbShape {
  _SfThumbShape(dynamic min, dynamic max) {
    this.min = min.runtimeType == DateTime
        ? min.millisecondsSinceEpoch.toDouble()
        : min;
    this.max = max.runtimeType == DateTime
        ? max.millisecondsSinceEpoch.toDouble()
        : max;
  }

  late double min;
  late double max;

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required RenderBox? child,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required SfThumb? thumb}) {
    final double actualValue = currentValue.runtimeType == DateTime
        ? currentValue.millisecondsSinceEpoch.toDouble()
        : currentValue;

    final double actualValueInPercent =
        ((actualValue - min) * 100) / (max - min);

    paint = Paint();
    paint.color = actualValueInPercent <= 80 ? Colors.green : Colors.red;

    super.paint(context, center,
        parentBox: parentBox,
        themeData: themeData,
        currentValue: currentValue,
        paint: paint,
        enableAnimation: enableAnimation,
        textDirection: textDirection,
        thumb: thumb,
        child: child);
  }
}
