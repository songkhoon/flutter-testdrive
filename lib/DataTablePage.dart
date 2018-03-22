import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:testdrive/UnitData.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class DataTablePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DataTableState();
  }
}

class DataTableState extends State<DataTablePage> {
  UnitDataList dataList;
  List<DataColumn> _columnData = <DataColumn>[
    new DataColumn(label: const Text("Fund Name")),
    new DataColumn(label: const Text("Scheme")),
    new DataColumn(label: const Text("Amount Paid"), numeric: true),
    new DataColumn(label: const Text("Total Unit"), numeric: true),
    new DataColumn(label: const Text("Nav")),
    new DataColumn(label: const Text("Nav Date")),
  ];
  UnitTrustDataSource _unitTrustDataSource = new UnitTrustDataSource();

  @override
  void initState() {
    loadAsset("resources/ut-details.json").then((data) {
      dataList = new UnitDataList.fromJson(JSON.decode(data));
      _unitTrustDataSource.dataList = dataList;
      print("length: ${dataList.data.length}");
      setState(() {
        print("set state");
      });
    }).catchError((e) {
      print("error: ${e}");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Data Table"),
      ),
      body: new Center(
        child: new ListView(
          children: _dataTable(),
        ),
      ),
    );
  }

  Future<String> loadAsset(String file) async {
    return await rootBundle.loadString(file);
  }

  List<Widget> _dataTable() {
    if (dataList == null) {
      return new List<Widget>();
    } else {
      return <Widget>[
        new PaginatedDataTable(
            header: const Text("Fund Detail"),
            columns: _columnData,
            source: _unitTrustDataSource,
        ),
        new PieChart()
      ];
    }
  }
}

class UnitTrustDataSource extends DataTableSource {
  UnitDataList dataList;

  @override
  DataRow getRow(int index) {
    if (dataList != null) {
      if (index >= dataList.data.length) return null;
      final data = dataList.data[index];
      return new DataRow.byIndex(index: index, cells: <DataCell>[
        new DataCell(new Container(
          child: new Text(
            "${data.fundname}",
            style: new TextStyle(fontSize: 10.0),
            softWrap: true,
          ),
          width: 100.0,),
        ),
        new DataCell(new Container(
          child: new Text("${data.scheme}"),
          width: 40.0,
        )),
        new DataCell(new Text("${data.amountpaid}")),
        new DataCell(new Text("${data.totalunit}")),
        new DataCell(new Text("${data.nav}")),
        new DataCell(new Text("${data.navDate}")),
      ]);
    } else {
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount {
    if (dataList == null) {
      return 0;
    } else {
      return dataList.data.length;
    }
  }

  @override
  int get selectedRowCount => 0;
}

class PieChart extends StatelessWidget {
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
        new CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
        new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new AnimatedCircularChart(
      key: _chartKey,
      size: const Size(300.0, 300.0),
      initialChartData: data,
      chartType: CircularChartType.Pie,
    );
  }
}
