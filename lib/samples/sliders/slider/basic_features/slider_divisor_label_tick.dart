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

///Render Slider with customized labels
class SliderLabelCustomizationPage extends SampleView {
  ///Render Slider with customized labels
  const SliderLabelCustomizationPage(Key key) : super(key: key);

  @override
  _SliderLabelCustomizationPageState createState() =>
      _SliderLabelCustomizationPageState();
}

class _SliderLabelCustomizationPageState extends SampleViewState {
  _SliderLabelCustomizationPageState();
  late Widget slider;

  @override
  void initState() {
    super.initState();
    slider = _SliderLabelCustomization();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait ||
            model.isWebFullView
        ? slider
        : SingleChildScrollView(
            child: Container(height: 300, child: slider),
          );
  }
}

class _SliderLabelCustomization extends SampleView {
  @override
  _SliderLabelCustomizationState createState() =>
      _SliderLabelCustomizationState();
}

class _SliderLabelCustomizationState extends SampleViewState {
  double _labelSliderValue = 50;
  double _tickSliderValue = 0;
  double _divisorSliderValue = 50;

  SfSliderTheme _sliderWithLabelCustomization() {
    return SfSliderTheme(
        data: SfSliderThemeData(tooltipBackgroundColor: model.backgroundColor),
        child: SfSlider(
          showLabels: true,
          interval: 20,
          min: 0.0,
          max: 100.0,
          value: _labelSliderValue,
          onChanged: (dynamic values) {
            setState(() {
              _labelSliderValue = values;
            });
          },
          enableTooltip: true,
          numberFormat: NumberFormat('#'),
        ));
  }

  SfSliderTheme _sliderWithTickCustomization() {
    return SfSliderTheme(
        data: SfSliderThemeData(tooltipBackgroundColor: model.backgroundColor),
        child: SfSlider(
          showLabels: true,
          showTicks: true,
          interval: 25,
          min: -50.0,
          max: 50.0,
          value: _tickSliderValue,
          onChanged: (dynamic values) {
            setState(() {
              _tickSliderValue = values;
            });
          },
          enableTooltip: true,
          numberFormat: NumberFormat('#'),
        ));
  }

  SfSliderTheme _sliderWithDivisorCustomization() {
    return SfSliderTheme(
        data: SfSliderThemeData(tooltipBackgroundColor: model.backgroundColor),
        child: SfSlider(
          interval: 25,
          showDivisors: true,
          min: 0.0,
          max: 100.0,
          value: _divisorSliderValue,
          onChanged: (dynamic values) {
            setState(() {
              _divisorSliderValue = values;
            });
          },
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
            title('Divisors'),
            _sliderWithDivisorCustomization(),
            columnSpacing30,
            title('Labels'),
            _sliderWithLabelCustomization(),
            columnSpacing30,
            title('Ticks'),
            _sliderWithTickCustomization(),
            columnSpacing30,
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return model.isWebFullView ? _buildWebLayout() : _buildMobileLayout();
  }
}
