/// Flutter package imports
import 'package:flutter/material.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Local imports
import '../../../model/sample_view.dart';

/// Renders the gauge pointer slow middle animation sample
class RadialSlowMiddleAnimation extends SampleView {
  /// Centers gauge with [slowMiddle] animation
  const RadialSlowMiddleAnimation(Key key) : super(key: key);

  @override
  _RadialSlowMiddleAnimationState createState() =>
      _RadialSlowMiddleAnimationState();
}

class _RadialSlowMiddleAnimationState extends SampleViewState {
  _RadialSlowMiddleAnimationState();

  @override
  Widget build(BuildContext context) {
    return _buildRadialSlowMiddleAnimation();
  }

  /// Returns the pointer slow middle animation gauge
  SfRadialGauge _buildRadialSlowMiddleAnimation() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            radiusFactor: model.isWebFullView ? 0.85 : 0.95,
            startAngle: 270,
            endAngle: 270,
            showAxisLine: false,
            ticksPosition: ElementsPosition.outside,
            labelsPosition: ElementsPosition.outside,
            minimum: 0,
            maximum: 12,
            interval: 1,
            canRotateLabels: true,
            majorTickStyle: MajorTickStyle(
                length: 0.15, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
            minorTicksPerInterval: 4,
            showFirstLabel: false,
            axisLabelStyle: GaugeTextStyle(fontSize: 12),
            minorTickStyle: MinorTickStyle(
                length: 0.07, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
            pointers: <GaugePointer>[
              NeedlePointer(
                  needleLength: 0.95,
                  needleStartWidth: 0,
                  lengthUnit: GaugeSizeUnit.factor,
                  needleEndWidth: 5,
                  needleColor: const Color(0xFFC06C84),
                  knobStyle: KnobStyle(knobRadius: 0),
                  value: 11,
                  enableAnimation: true,
                  animationType: AnimationType.slowMiddle),
              NeedlePointer(
                needleLength: 0.7,
                needleStartWidth: 0,
                lengthUnit: GaugeSizeUnit.factor,
                needleEndWidth: 5,
                needleColor: const Color(0xFFF67280),
                value: 2,
                enableAnimation: true,
                animationType: AnimationType.slowMiddle,
                knobStyle: KnobStyle(
                    color: const Color(0xFFF67280),
                    sizeUnit: GaugeSizeUnit.logicalPixel,
                    knobRadius: 10),
              ),
              NeedlePointer(
                  needleLength: 0.8,
                  needleStartWidth: 1,
                  lengthUnit: GaugeSizeUnit.factor,
                  needleEndWidth: 1,
                  needleColor: _slowMiddleNeedleColor,
                  knobStyle: KnobStyle(
                      knobRadius: 5,
                      sizeUnit: GaugeSizeUnit.logicalPixel,
                      color: _slowMiddleNeedleColor),
                  value: 10.4,
                  enableAnimation: true,
                  animationType: AnimationType.slowMiddle),
            ])
      ],
    );
  }

  final Color _slowMiddleNeedleColor = const Color(0xFF355C7D);
}
