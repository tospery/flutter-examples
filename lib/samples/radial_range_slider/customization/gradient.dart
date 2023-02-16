///Package imports
import 'package:flutter/material.dart';

///calendar import
import 'package:syncfusion_flutter_gauges/gauges.dart';

///Local import
import '../../../model/sample_view.dart';

/// Widget of the RadialSlider gradient.
class RadialRangeSliderGradient extends SampleView {
  /// Creates RadialSlider gradient.
  const RadialRangeSliderGradient(Key key) : super(key: key);

  @override
  _RadialRangeSliderGradientState createState() =>
      _RadialRangeSliderGradientState();
}

class _RadialRangeSliderGradientState extends SampleViewState {
  _RadialRangeSliderGradientState();

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      _firstMarkerSize = 30;
      _annotationFontSize = 25;
    } else {
      _firstMarkerSize = model.isWebFullView ? 28 : 15;
      _annotationFontSize = model.isWebFullView ? 25 : 15;
    }
    return Center(
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
            radiusFactor: 0.85,
            axisLineStyle: AxisLineStyle(
                thickness: 0, thicknessUnit: GaugeSizeUnit.factor),
            tickOffset: 0.20,
            labelOffset: 0.10,
            offsetUnit: GaugeSizeUnit.factor,
            minorTicksPerInterval: 5,
            onLabelCreated: (args) {
              final double axisValue = double.parse(args.text);
              final double celsiusValue = (axisValue - 32) / 1.8;
              args.text = celsiusValue.toStringAsFixed(1);
            },
            majorTickStyle:
                MajorTickStyle(length: 0.1, lengthUnit: GaugeSizeUnit.factor),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '$_firstCelsiusAnnotationValue°C'
                        ' to $_secondCelsiusAnnotationValue',
                        style: TextStyle(
                          fontSize: _celsiusAnnotationFontSize,
                          fontFamily: 'Times',
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        '°C',
                        style: TextStyle(
                          fontSize: _celsiusAnnotationFontSize,
                          fontFamily: 'Times',
                          // fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  positionFactor: 0.15,
                  angle: 90)
            ]),
        RadialAxis(
            axisLineStyle: AxisLineStyle(
                thickness: 0.05, thicknessUnit: GaugeSizeUnit.factor),
            showTicks: false,
            showLabels: true,
            labelOffset: 20,
            ranges: <GaugeRange>[
              GaugeRange(
                  endValue: _secondMarkerValue,
                  startValue: _firstMarkerValue,
                  sizeUnit: GaugeSizeUnit.factor,
                  gradient: const SweepGradient(colors: <Color>[
                    Color.fromRGBO(115, 67, 189, 1),
                    Color.fromRGBO(202, 94, 230, 1)
                  ], stops: <double>[
                    0.5,
                    1
                  ]),
                  endWidth: 0.05,
                  startWidth: 0.05)
            ],
            pointers: <GaugePointer>[
              MarkerPointer(
                value: _firstMarkerValue,
                elevation: 5,
                overlayColor: Color.fromRGBO(202, 94, 230, 0.125),
                color: model.currentThemeData!.brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
                borderWidth: 7,
                borderColor:
                    model.currentThemeData!.brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                markerHeight: _firstMarkerSize,
                markerWidth: _firstMarkerSize,
                markerType: MarkerType.circle,
                enableDragging: true,
                onValueChanged: handleFirstPointerValueChanged,
                onValueChanging: handleFirstPointerValueChanging,
              ),
              MarkerPointer(
                value: _secondMarkerValue,
                elevation: 5,
                color: model.currentThemeData!.brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
                borderWidth: 7,
                borderColor:
                    model.currentThemeData!.brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                markerHeight: _firstMarkerSize,
                overlayColor: Color.fromRGBO(202, 94, 230, 0.125),
                markerWidth: _firstMarkerSize,
                markerType: MarkerType.circle,
                enableDragging: true,
                onValueChanged: handleSecondPointerValueChanged,
                onValueChanging: handleSecondPointerValueChanging,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '$_firstAnnotationValue°F to $_secondAnnotationValue',
                        style: TextStyle(
                            fontSize: _annotationFontSize,
                            fontFamily: 'Times',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '°F',
                        style: TextStyle(
                          fontSize: _annotationFontSize,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  positionFactor: 0.05,
                  angle: 0)
            ])
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Dragged pointer new value is updated to pointer and
  /// annotation current value.
  void handleSecondPointerValueChanged(double value) {
    setState(() {
      _secondMarkerValue = value;
      // final int _value =
      //     (_firstMarkerValue - _secondMarkerValue).abs().round().toInt();
      final int _value = _secondMarkerValue.abs().round().toInt();
      _secondAnnotationValue = '$_value';
      final double _celsiusValue = (_value - 32) / 1.8;
      _secondCelsiusAnnotationValue = '${_celsiusValue.toStringAsFixed(1)}';
    });
  }

  /// Pointer dragging is canceled when dragging pointer value is less than 6.
  void handleSecondPointerValueChanging(ValueChangingArgs args) {
    if (args.value <= _firstMarkerValue ||
        (args.value - _secondMarkerValue).abs() > 10) {
      args.cancel = true;
    }
  }

  /// Value changed call back for first pointer
  void handleFirstPointerValueChanged(double value) {
    setState(() {
      _firstMarkerValue = value;
      // final int _value =
      // (_firstMarkerValue - _secondMarkerValue).abs().round().toInt();
      final int _value = _firstMarkerValue.abs().round().toInt();
      _firstAnnotationValue = '$_value';
      final double _celsiusValue = (_value - 32) / 1.8;
      _firstCelsiusAnnotationValue = '${_celsiusValue.toStringAsFixed(1)}';
    });
  }

  /// Value changeing call back for first pointer
  void handleFirstPointerValueChanging(ValueChangingArgs args) {
    if (args.value >= _secondMarkerValue ||
        (args.value - _firstMarkerValue).abs() > 10) {
      args.cancel = true;
    }
  }

  double _secondMarkerValue = 60;
  double _firstMarkerValue = 0;
  double _firstMarkerSize = 30;
  double _annotationFontSize = 25;
  final double _celsiusAnnotationFontSize = 18;
  String _firstAnnotationValue = '0';
  String _secondAnnotationValue = '60';
  String _firstCelsiusAnnotationValue = '-${17.7778.toStringAsFixed(1)}';
  String _secondCelsiusAnnotationValue = '${15.5556.toStringAsFixed(1)}';
}
