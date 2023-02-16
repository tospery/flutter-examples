///flutter package import
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

///Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

///Slider import
import 'package:syncfusion_flutter_sliders/sliders.dart';

///Local imports
import '../../../../model/sample_view.dart';
import '../../slider_utils.dart';

/// Renders default range slider widget
class DefaultRangeSliderPage extends SampleView {
  /// Creates default range slider widget
  const DefaultRangeSliderPage(Key key) : super(key: key);

  @override
  _DefaultRangeSliderPageState createState() => _DefaultRangeSliderPageState();
}

class _DefaultRangeSliderPageState extends SampleViewState {
  _DefaultRangeSliderPageState();
  late Widget rangeSlider;

  @override
  void initState() {
    super.initState();
    rangeSlider = _DefaultRangeSlider();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait ||
            model.isWebFullView
        ? rangeSlider
        : SingleChildScrollView(
            child: Container(height: 300, child: rangeSlider),
          );
  }
}

class _DefaultRangeSlider extends SampleView {
  @override
  _DefaultRangeSliderState createState() => _DefaultRangeSliderState();
}

class _DefaultRangeSliderState extends SampleViewState {
  final SfRangeValues _inactiveRangeSliderValue = SfRangeValues(20.0, 80.0);
  SfRangeValues _activeRangeSliderValue = SfRangeValues(20.0, 80.0);

  SfRangeSlider _inactiveRangeSlider() {
    //ignore: missing_required_param
    return SfRangeSlider(
      min: 0.0,
      max: 100.0,
      values: _inactiveRangeSliderValue,
      onChanged: null,
    );
  }

  SfRangeSliderTheme _activeRangeSliderSlider() {
    return SfRangeSliderTheme(
        data: SfRangeSliderThemeData(
            tooltipBackgroundColor: model.backgroundColor),
        child: SfRangeSlider(
          min: 0.0,
          max: 100.0,
          onChanged: (dynamic values) {
            setState(() {
              _activeRangeSliderValue = values;
            });
          },
          values: _activeRangeSliderValue,
          enableTooltip: true,
          numberFormat: NumberFormat('#'),
        ));
  }

  Widget _buildWebLayout() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width >= 1000 ? 550 : 440,
        child: _getMobileLayout(),
      ),
    );
  }

  Widget _getMobileLayout() {
    final double padding = MediaQuery.of(context).size.width / 20.0;
    return Container(
        padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            title('Enabled'),
            _activeRangeSliderSlider(),
            columnSpacing40,
            title('Disabled'),
            _inactiveRangeSlider(),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return model.isWebFullView ? _buildWebLayout() : _getMobileLayout();
  }
}
