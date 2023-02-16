/// Flutter package imports
import 'package:flutter/material.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Local imports
import '../../../model/sample_view.dart';
import '../utils.dart';

/// Renders the task tracking showcase sample.
class TaskTracking extends SampleView {
  /// Creates the task tracking showcase sample.
  const TaskTracking(Key key) : super(key: key);

  @override
  _TaskTrackingState createState() => _TaskTrackingState();
}

/// State class of task tracking sample.
class _TaskTrackingState extends SampleViewState {
  _TaskTrackingState();
  double _pointerValue = 60;

  @override
  Widget build(BuildContext context) {
    return isWebOrDesktop
        ? Container(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width >= 1000 ? 550 : 440,
              child: _buildTaskTracker(context),
            ))
        : _buildTaskTracker(context);
  }

  /// Returns the task tracker.
  Widget _buildTaskTracker(BuildContext context) {
    final Brightness _brightness = Theme.of(context).brightness;

    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SfLinearGauge(
              interval: 20,
              animateAxis: true,
              animateRange: true,
              labelPosition: LinearLabelPosition.outside,
              tickPosition: LinearElementPosition.outside,
              onGenerateLabels: () {
                return <LinearAxisLabel>[
                  LinearAxisLabel(text: 'Mar 19', value: 0),
                  LinearAxisLabel(text: 'Jul 19', value: 20),
                  LinearAxisLabel(text: 'Oct 19', value: 40),
                  LinearAxisLabel(text: 'Jan 20', value: 60),
                  LinearAxisLabel(text: 'Apr 20', value: 80),
                  LinearAxisLabel(text: 'Jul 20', value: 100),
                ];
              },
              axisTrackStyle: LinearAxisTrackStyle(
                  thickness: 16, color: Colors.transparent),
              markerPointers: [
                LinearShapePointer(
                    value: _pointerValue,
                    onValueChanged: (value) => {
                          setState(() => {_pointerValue = value})
                        },
                    color: _brightness == Brightness.light
                        ? Color(0xff06589C)
                        : Color(0xffFFFFFF),
                    width: 24,
                    position: LinearElementPosition.cross,
                    shapeType: LinearShapePointerType.triangle,
                    height: 16),
              ],
              ranges: <LinearGaugeRange>[
                LinearGaugeRange(
                  startValue: 0.0,
                  midValue: 0,
                  endValue: 80,
                  startWidth: 16,
                  midWidth: 16,
                  endWidth: 16,
                  position: LinearElementPosition.cross,
                  color: Color(0xff0DC9AB),
                ),
                LinearGaugeRange(
                  startValue: 80.0,
                  midValue: 0,
                  endValue: 100,
                  startWidth: 16,
                  midWidth: 16,
                  endWidth: 16,
                  position: LinearElementPosition.cross,
                  color: Color(0xffF45656),
                )
              ])
        ]));
  }
}
