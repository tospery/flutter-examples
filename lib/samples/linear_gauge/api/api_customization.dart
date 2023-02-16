// Flutter package imports
import 'package:flutter/material.dart';
import 'package:flutter_examples/samples/linear_gauge/utils.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Local imports
import '../../../model/sample_view.dart';
import '../../../widgets/custom_button.dart';
import '../utils.dart';

/// Renders the linear gauge api customization sample.
class ApiCustomization extends SampleView {
  /// Creates the linear gauge api customization sample.
  const ApiCustomization(Key key) : super(key: key);

  @override
  _ApiCustomizationState createState() => _ApiCustomizationState();
}

/// State class of api customization sample.
class _ApiCustomizationState extends SampleViewState {
  LinearElementPosition _shapePosition = LinearElementPosition.outside;
  LinearElementPosition _barPosition = LinearElementPosition.outside;
  LinearElementPosition _rangePosition = LinearElementPosition.outside;
  final _scrollController = ScrollController();

  String _shapePointerPosition = 'Outside';
  String _barPointerPosition = 'Outside';
  String _rangePointerPosition = 'Outside';
  bool _isMirror = false;
  bool _isInverse = false;
  bool _isHorizontalOrientation = false;
  double _barOffset = 5;

  final List<String> _pointerPositions = <String>['Outside', 'Cross', 'Inside'];

  void shapePosition(String item) {
    _shapePointerPosition = item;
    if (_shapePointerPosition == 'Inside') {
      _shapePosition = LinearElementPosition.inside;
    }
    if (_shapePointerPosition == 'Outside') {
      _shapePosition = LinearElementPosition.outside;
    }
    if (_shapePointerPosition == 'Cross') {
      _shapePosition = LinearElementPosition.cross;
    }
  }

  void barPosition(String item) {
    _barPointerPosition = item;
    if (_barPointerPosition == 'Inside') {
      _barPosition = LinearElementPosition.inside;
    }
    if (_barPointerPosition == 'Outside') {
      _barPosition = LinearElementPosition.outside;
    }
    if (_barPointerPosition == 'Cross') {
      _barPosition = LinearElementPosition.cross;
    }
  }

  void rangePosition(String item) {
    _rangePointerPosition = item;
    if (_rangePointerPosition == 'Inside') {
      _rangePosition = LinearElementPosition.inside;
    }
    if (_rangePointerPosition == 'Outside') {
      _rangePosition = LinearElementPosition.outside;
    }
    if (_rangePointerPosition == 'Cross') {
      _rangePosition = LinearElementPosition.cross;
    }
  }

  Widget _buildLinearGauge(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: model.isWebFullView
              ? MediaQuery.of(context).size.height / 2
              : MediaQuery.of(context).size.height /
                  (MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 3),
          child: SfLinearGauge(
            maximum: 50,
            isMirrored: _isMirror,
            isAxisInversed: _isInverse,
            interval: 10,
            orientation: _isHorizontalOrientation
                ? LinearGaugeOrientation.horizontal
                : LinearGaugeOrientation.vertical,
            barPointers: <LinearBarPointer>[
              LinearBarPointer(
                value: 30,
                position: _barPosition,
                offset: _barOffset,
                edgeStyle: LinearEdgeStyle.endCurve,
              ),
            ],
            markerPointers: [
              LinearShapePointer(
                value: 40,
                position: _shapePosition,
              ),
            ],
            ranges: [
              LinearGaugeRange(
                startValue: 0,
                endValue: 20,
                color: Colors.red,
                position: _rangePosition,
              ),
              LinearGaugeRange(
                startValue: 20,
                endValue: 35,
                color: Colors.orange,
                position: _rangePosition,
              ),
              LinearGaugeRange(
                startValue: 35,
                endValue: 50,
                color: Colors.green,
                position: _rangePosition,
              )
            ],
          ),
        ),
        SizedBox(height: 5),
        Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: _barPosition == LinearElementPosition.cross ? true : false,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.lightbulb_outline, color: Colors.orange, size: 24.0),
              SizedBox(width: 5),
              Flexible(
                child: Text(
                  'Offset positioning is not possible for cross aligned elements.',
                  style: TextStyle(fontSize: 12),
                ),
              )
            ])),
      ],
    );
  }

  Widget _buildPropertiesPanel(BuildContext context) {
    return Scrollbar(
        controller: _scrollController,
        isAlwaysShown: model.isMobile
            ? true
            : MediaQuery.of(context).size.width >= 550
                ? false
                : true,
        child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Properties : ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isInverse = !_isInverse;
                      });
                    },
                    child: Container(
                      height: 40,
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 30,
                            child: Checkbox(
                                value: _isInverse,
                                splashRadius: 15,
                                activeColor: model.backgroundColor,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value != null) {
                                      _isInverse = value;
                                    }
                                  });
                                }),
                          ),
                          Text('Inverse Axis', style: TextStyle(fontSize: 14))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isMirror = !_isMirror;
                        });
                      },
                      child: Container(
                        height: 40,
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 30,
                              child: Checkbox(
                                  splashRadius: 15,
                                  value: _isMirror,
                                  activeColor: model.backgroundColor,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value != null) {
                                        _isMirror = value;
                                      }
                                    });
                                  }),
                            ),
                            Text('Mirror', style: TextStyle(fontSize: 14))
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isHorizontalOrientation = !_isHorizontalOrientation;
                        });
                      },
                      child: Container(
                        height: 40,
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 30,
                              child: Checkbox(
                                  value: _isHorizontalOrientation,
                                  splashRadius: 15,
                                  activeColor: model.backgroundColor,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value != null) {
                                        _isHorizontalOrientation = value;
                                      }
                                    });
                                  }),
                            ),
                            Text('Horizontal Orientation',
                                style: TextStyle(fontSize: 14))
                          ],
                        ),
                      )),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 5),
                        child: Text('Shape Pointer Position',
                            style: TextStyle(fontSize: 14)),
                      ),
                      Text(':'),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                                value: _shapePointerPosition,
                                items: _pointerPositions.map((String value) {
                                  return DropdownMenuItem<String>(
                                      value:
                                          (value != null) ? value : 'Outside',
                                      child: Text('$value',
                                          style: TextStyle(fontSize: 14)));
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      shapePosition(value.toString());
                                    }
                                  });
                                })),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 5),
                        child: Text('Bar Pointer Position',
                            style: TextStyle(fontSize: 14)),
                      ),
                      Text(':'),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                                value: _barPointerPosition,
                                items: _pointerPositions.map((String value) {
                                  return DropdownMenuItem<String>(
                                      value:
                                          (value != null) ? value : 'Outside',
                                      child: Text('$value',
                                          style: TextStyle(fontSize: 14)));
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      barPosition(value.toString());
                                    }
                                  });
                                })),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          width: 150,
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            'Range Position',
                            style: TextStyle(fontSize: 14),
                          )),
                      Text(':'),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                                value: _rangePointerPosition,
                                items: _pointerPositions.map((String value) {
                                  return DropdownMenuItem<String>(
                                      value:
                                          (value != null) ? value : 'Outside',
                                      child: Text('$value',
                                          style: TextStyle(fontSize: 14)));
                                }).toList(),
                                onChanged: (dynamic value) {
                                  setState(() {
                                    rangePosition(value.toString());
                                  });
                                })),
                      )
                    ],
                  ),
                  Visibility(
                    visible: _barPosition == LinearElementPosition.cross
                        ? false
                        : true,
                    child: Row(
                      children: [
                        Container(
                            width: 150,
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              'Bar Offset',
                              style: TextStyle(fontSize: 14),
                            )),
                        Text(':'),
                        Container(
                          transform: Matrix4.translationValues(-8, 0, 0),
                          child: CustomDirectionalButtons(
                            maxValue: 20,
                            minValue: 0,
                            initialValue: _barOffset,
                            onChanged: (double value) {
                              setState(() {
                                _barOffset = value;
                              });
                            },
                            step: 1,
                            loop: false,
                            iconColor: model.textColor,
                            style: TextStyle(
                                fontSize: 16.0, color: model.textColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ])));
  }

  @override
  Widget build(BuildContext context) {
    final Brightness _brightness = Theme.of(context).brightness;
    return (isWebOrDesktop && MediaQuery.of(context).size.width >= 550)
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Wrap(children: [
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 3,
                    child: _buildLinearGauge(context)),
              ]),
              Spacer(),
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: 1,
                  color: _brightness == Brightness.dark
                      ? Color(0xff3D3D3D)
                      : Color(0xffe2e2e2)),
              Container(
                  color: _brightness == Brightness.dark
                      ? Color(0xff2a2a2a)
                      : model.webBackgroundColor,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(10),
                  child: _buildPropertiesPanel(context)),
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(children: [
                  _buildLinearGauge(context),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    color: _brightness == Brightness.dark
                        ? Color(0xff2a2a2a)
                        : model.webBackgroundColor,
                    child: _buildPropertiesPanel(context),
                  ),
                ]),
              ),
            ),
          );
  }
}
