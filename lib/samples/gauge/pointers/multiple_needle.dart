/// Flutter package imports
import 'package:flutter/material.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Local imports
import '../../../model/sample_view.dart';

/// Renders the gauge multiple needle pointers sample
class MultipleNeedleExample extends SampleView {
  /// Creates the gauge multiple needle pointers sample
  const MultipleNeedleExample(Key key) : super(key: key);

  @override
  _MultipleNeedleExampleState createState() => _MultipleNeedleExampleState();
}

class _MultipleNeedleExampleState extends SampleViewState {
  _MultipleNeedleExampleState();

  @override
  Widget build(BuildContext context) {
    return _buildMultipleNeedleExample();
  }

  /// Returns the multiple needle pointers gauge
  SfRadialGauge _buildMultipleNeedleExample() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            showAxisLine: false,
            radiusFactor: model.isWebFullView ? 0.43 : 0.5,
            startAngle: 270,
            endAngle: 270,
            minimum: 0,
            maximum: 60,
            showFirstLabel: false,
            interval: 5,
            labelOffset: 10,
            minorTicksPerInterval: 5,
            axisLabelStyle: GaugeTextStyle(fontSize: 10),
            onLabelCreated: _handleAxisLabelCreated,
            minorTickStyle: MinorTickStyle(
                lengthUnit: GaugeSizeUnit.factor, length: 0.03, thickness: 1),
            majorTickStyle:
                MajorTickStyle(lengthUnit: GaugeSizeUnit.factor, length: 0.1)),
        RadialAxis(
            axisLineStyle: AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor,
                thickness: 0.08,
                color: const Color(0xFFFFCD60)),
            startAngle: 270,
            endAngle: 270,
            minimum: 0,
            maximum: 12,
            radiusFactor: model.isWebFullView ? 0.8 : 0.9,
            showFirstLabel: false,
            interval: 1,
            labelOffset: 10,
            axisLabelStyle: GaugeTextStyle(fontSize: isCardView ? 10 : 12),
            minorTicksPerInterval: 5,
            onLabelCreated: _handleAxisLabelCreated,
            minorTickStyle: MinorTickStyle(
                lengthUnit: GaugeSizeUnit.factor, length: 0.05, thickness: 1),
            majorTickStyle:
                MajorTickStyle(lengthUnit: GaugeSizeUnit.factor, length: 0.1),
            pointers: <GaugePointer>[
              NeedlePointer(
                  value: 8,
                  needleLength: 0.35,
                  needleColor: const Color(0xFFF67280),
                  lengthUnit: GaugeSizeUnit.factor,
                  needleStartWidth: 0,
                  needleEndWidth: isCardView ? 3 : 5,
                  enableAnimation: true,
                  knobStyle: KnobStyle(knobRadius: 0),
                  animationType: AnimationType.ease),
              NeedlePointer(
                  value: 3,
                  needleLength: 0.85,
                  lengthUnit: GaugeSizeUnit.factor,
                  needleColor: const Color(0xFFF67280),
                  needleStartWidth: 0,
                  needleEndWidth: isCardView ? 3 : 5,
                  enableAnimation: true,
                  animationType: AnimationType.ease,
                  knobStyle: KnobStyle(
                      borderColor: const Color(0xFFF67280),
                      borderWidth: 0.015,
                      color: Colors.white,
                      sizeUnit: GaugeSizeUnit.factor,
                      knobRadius: isCardView ? 0.04 : 0.05)),
            ]),
      ],
    );
  }

  /// Appended the hours letter by handling the onLabelCreated callback
  void _handleAxisLabelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '12') {
      args.text = '12h';
    }
  }
}
