/// Package imports
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import '../../../../model/model.dart';
import '../../../../model/sample_view.dart';

/// Renders the dashed stepline chart sample.
class StepLineDashed extends SampleView {
  const StepLineDashed(Key key) : super(key: key);

  @override
  _StepLineDashedState createState() => _StepLineDashedState();
}

/// State class of the dashed stepline chart.
class _StepLineDashedState extends SampleViewState {
  _StepLineDashedState();

  @override
  Widget build(BuildContext context) {
    return getDashedStepLineChart();
  }

  /// Returns the dashed cartesian stepline chart.
  SfCartesianChart getDashedStepLineChart() {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(text: isCardView ? '' : 'CO2 - Intensity analysis'),
    primaryXAxis: NumericAxis(
      interval: 1,
      majorGridLines: MajorGridLines(width: 0),
      title: AxisTitle(text: isCardView ? '' : 'Year'),
    ),
    primaryYAxis: NumericAxis(
      axisLine: AxisLine(width: 0),
      minimum: 360,
      maximum: 600,
      interval: 30,
      majorTickLines: MajorTickLines(size: 0),
      title: AxisTitle(text: isCardView ? '' : 'Intensity (g/kWh)'),
    ),
    legend: Legend(isVisible: isCardView ? false : true),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: getDashedStepLineSeries(),
  );
}

/// Returns the list of chart series which need to render on the stepline chart.
List<StepLineSeries<ChartSampleData, num>> getDashedStepLineSeries() {
  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 2006, y: 378, yValue: 463, yValue2: 519, yValue3: 570),
    ChartSampleData(x: 2007, y: 416, yValue: 449, yValue2: 508, yValue3: 579),
    ChartSampleData(x: 2008, y: 404, yValue: 458, yValue2: 502, yValue3: 563),
    ChartSampleData(x: 2009, y: 390, yValue: 450, yValue2: 495, yValue3: 550),
    ChartSampleData(x: 2010, y: 376, yValue: 425, yValue2: 485, yValue3: 545),
    ChartSampleData(x: 2011, y: 365, yValue: 430, yValue2: 470, yValue3: 525)
  ];
  return <StepLineSeries<ChartSampleData, num>>[
    StepLineSeries<ChartSampleData, num>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.y,
        name: 'USA',
        width: 2,
        dashArray: kIsWeb ? <double>[0, 0] : <double>[10, 5]),
    StepLineSeries<ChartSampleData, num>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.yValue,
        name: 'UK',
        width: 2,
        dashArray: kIsWeb ? <double>[0, 0] : <double>[10, 5]),
    StepLineSeries<ChartSampleData, num>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.yValue2,
        name: 'Korea',
        width: 2,
        dashArray: kIsWeb ? <double>[0, 0] : <double>[10, 5]),
    StepLineSeries<ChartSampleData, num>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.yValue3,
        name: 'Japan',
        width: 2,
        dashArray: kIsWeb ? <double>[0, 0] : <double>[10, 5])
  ];
}
}