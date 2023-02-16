/// Dart import
import 'dart:math';

/// Package import
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// DataGrid import
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// Local import
import '../../../model/sample_view.dart';

/// Renders Load More Infinite Scrolling Data Grid
class LoadMoreInfiniteScrollingDataGrid extends SampleView {
  /// Creates Load More Infinite Scrolling Data Grid
  LoadMoreInfiniteScrollingDataGrid({Key? key}) : super(key: key);

  @override
  _LoadMoreInfiniteScrollingDataGridState createState() =>
      _LoadMoreInfiniteScrollingDataGridState();
}

class _LoadMoreInfiniteScrollingDataGridState extends SampleViewState {
  /// DataGridSource required for SfDataGrid to obtain the row data.
  final _EmployeeDataSource employeeDataSource = _EmployeeDataSource();

  late bool isWebOrDesktop;

  /// Building the progress indicator when DataGrid scroller reach the bottom
  Widget _buildProgressIndicator() {
    final isLight = model.themeData.brightness == Brightness.light;
    return Container(
        height: 60.0,
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
            color: isLight ? Color(0xFFFFFFFF) : Color(0xFF212121),
            border: BorderDirectional(
                top: BorderSide(
                    width: 1.0,
                    color: isLight
                        ? Color.fromRGBO(0, 0, 0, 0.26)
                        : Color.fromRGBO(255, 255, 255, 0.26)))),
        child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            child: Container(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(model.backgroundColor),
              backgroundColor: Colors.transparent,
            ))));
  }

  /// Callback method for load more builder
  Widget _buildLoadMoreView(BuildContext context, LoadMoreRows loadMoreRows) {
    Future<String> loadRows() async {
      // Call the loadMoreRows function to call the
      // DataGridSource.handleLoadMoreRows method. So, additional
      // rows can be added from handleLoadMoreRows method.
      await loadMoreRows();
      return Future<String>.value('Completed');
    }

    return FutureBuilder<String>(
      initialData: 'Loading',
      future: loadRows(),
      builder: (context, snapShot) {
        return snapShot.data == 'Loading'
            ? _buildProgressIndicator()
            : SizedBox.fromSize(size: Size.zero);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
        source: employeeDataSource,
        loadMoreViewBuilder: _buildLoadMoreView,
        columns: _getColumns());
  }

  @override
  void initState() {
    super.initState();
    isWebOrDesktop = (model.isWeb || model.isDesktop);
  }

  List<GridColumn> _getColumns() {
    return <GridColumn>[
      GridTextColumn(
          columnName: 'id',
          width:
              (isWebOrDesktop && model.isMobileResolution) ? 120 : double.nan,
          columnWidthMode:
              !isWebOrDesktop ? ColumnWidthMode.none : ColumnWidthMode.fill,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              child: Text(
                'Order ID',
                overflow: TextOverflow.ellipsis,
              ))),
      GridTextColumn(
          columnName: 'customerId',
          columnWidthMode:
              !isWebOrDesktop ? ColumnWidthMode.none : ColumnWidthMode.fill,
          width: !isWebOrDesktop
              ? 120
              : (isWebOrDesktop && model.isMobileResolution)
                  ? 150
                  : double.nan,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              child: Text(
                'Customer ID',
                overflow: TextOverflow.ellipsis,
              ))),
      GridTextColumn(
          columnName: 'name',
          width:
              (isWebOrDesktop && model.isMobileResolution) ? 120 : double.nan,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: Text(
                'Name',
                overflow: TextOverflow.ellipsis,
              ))),
      GridTextColumn(
          width:
              (isWebOrDesktop && model.isMobileResolution) ? 110 : double.nan,
          columnName: 'freight',
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              child: Text(
                'Freight',
                overflow: TextOverflow.ellipsis,
              ))),
      GridTextColumn(
          columnName: 'city',
          width:
              (isWebOrDesktop && model.isMobileResolution) ? 120 : double.nan,
          columnWidthMode:
              !isWebOrDesktop ? ColumnWidthMode.none : ColumnWidthMode.fill,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: Text(
                'City',
                overflow: TextOverflow.ellipsis,
              ))),
      GridTextColumn(
          width:
              (isWebOrDesktop && model.isMobileResolution) ? 120 : double.nan,
          columnName: 'price',
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              child: Text(
                'Price',
                overflow: TextOverflow.ellipsis,
              )))
    ];
  }
}

class _Employee {
  _Employee(
      this.id, this.customerId, this.name, this.freight, this.city, this.price);
  final int id;
  final int customerId;
  final String name;
  final String city;
  final double freight;
  final double price;
}

class _EmployeeDataSource extends DataGridSource {
  _EmployeeDataSource() {
    _populateData();
    buildDataGridRow();
  }

  List<_Employee> employees = [];
  List<DataGridRow> dataGridRows = [];

  // Building DataGridRows

  void _populateData() {
    employees.clear();
    employees = getEmployees(employees, 25);
  }

  void buildDataGridRow() {
    dataGridRows = employees.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'id', value: dataGridRow.id),
        DataGridCell(columnName: 'customerId', value: dataGridRow.customerId),
        DataGridCell(columnName: 'name', value: dataGridRow.name),
        DataGridCell(columnName: 'freight', value: dataGridRow.freight),
        DataGridCell(columnName: 'city', value: dataGridRow.city),
        DataGridCell(columnName: 'price', value: dataGridRow.price),
      ]);
    }).toList(growable: false);
  }

  // Overrides

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.centerRight,
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.centerRight,
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: '\$')
              .format(row.getCells()[3].value)
              .toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 0)
              .format(row.getCells()[5].value)
              .toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

  @override
  Future<void> handleLoadMoreRows() async {
    await Future.delayed(Duration(seconds: 5));
    employees = getEmployees(employees, 15);
    buildDataGridRow();
    notifyListeners();
  }

  // Employee Data's

  final List<String> names = <String>[
    'Welli',
    'Blonp',
    'Folko',
    'Furip',
    'Folig',
    'Picco',
    'Frans',
    'Warth',
    'Linod',
    'Simop',
    'Merep',
    'Riscu',
    'Seves',
    'Vaffe',
    'Alfki',
  ];

  final List<String> cities = <String>[
    'Bruxelles',
    'Rosario',
    'Recife',
    'Graz',
    'Montreal',
    'Tsawassen',
    'Campinas',
    'Resende',
  ];

  List<_Employee> getEmployees(List<_Employee> employeeData, int count) {
    final Random random = Random();
    final int startIndex = employeeData.isNotEmpty ? employeeData.length : 0,
        endIndex = startIndex + count;

    for (int i = startIndex; i < endIndex; i++) {
      employeeData.add(_Employee(
        1000 + i,
        1700 + i,
        names[i < names.length ? i : random.nextInt(names.length - 1)],
        random.nextInt(1000) + random.nextDouble(),
        cities[random.nextInt(cities.length - 1)],
        1500.0 + random.nextInt(100),
      ));
    }
    return employeeData;
  }
}
