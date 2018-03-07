import 'package:build_layout/GridViewLayout.dart';
import 'package:flutter/material.dart';
import 'package:build_layout/BasicLayout.dart';
import 'ContainerLayout.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Flutter Layout",
      theme: new ThemeData(primaryColor: Colors.orange),
      home: new MyAppWidget(),
    );
  }
}

class MyAppWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppWidgetState();
  }
}

class MyAppWidgetState extends State<MyAppWidget> {
  final layoutTitles = <String>[
    "Basic Layout",
    "Container",
    "Grid View",
    "List View",
    "Stack",
    "Card",
    "ListTile"
  ];
  final layoutWidgets = <Widget>[
    new BasicLayout(),
    new ContainerLayout(),
    new GridViewLayout()
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Layout"),
      ),
      body: layoutSelection(),
    );
  }

  Widget layoutSelection() {
    return new ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, i) {
        return new Container(
          child: new Column(
            children: <Widget>[
              new ListTile(
                  title: new Text(
                layoutTitles[i],
                style: const TextStyle(fontSize: 18.0),
              ),
                onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                      return layoutWidgets[i];
                    }));
                },
              ),
              new Divider()
            ],
          ),
        );
      },
      itemCount: layoutTitles.length,
    );
  }
}
