import 'package:flutter/material.dart';
import 'package:testdrive/CustomPainter/BarChart.dart';
import 'package:testdrive/CustomPainter/ChartPage.dart';
import 'package:testdrive/CustomPainter/MultipleBarChart.dart';
import 'package:testdrive/CustomPainter/SingleBar.dart';

class CustomPainterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CustomPainterPageState();
}

class CustomPainterPageState extends State<CustomPainterPage> {
  final listTitle = <String>[
    "Chart Page",
    "Single Bar",
    "Bar Chart",
    "Multiple Chart",
  ];

  final listWidget = <Widget>[
    new ChartPage(),
    new SingleBar(),
    new BarChartStateful(),
    new MultipleBarChart(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text("Custom Paint"),
        ),
        body: new ListView.builder(
          itemBuilder: (context, i) {
            return new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(listTitle[i]),
                  onTap: () {
                    Navigator
                        .of(context)
                        .push(new MaterialPageRoute(builder: (context) {
                      return listWidget[i];
                    }));
                  },
                ),
                new Divider()
              ],
              mainAxisSize: MainAxisSize.max,
            );
          },
          itemCount: listTitle.length,
        ));
  }
}
