import 'package:flutter/material.dart';
import 'package:testdrive/AnimationPage.dart';
import 'package:testdrive/BatteryLevel.dart';
import 'package:testdrive/DataTablePage.dart';
import 'package:testdrive/GesturePage.dart';
import 'package:testdrive/PageLayout.dart';
import 'package:testdrive/ReadWriteFile.dart';
import 'package:testdrive/TestDrive.dart';
import 'package:build_layout/main.dart';
import 'package:firstapp/main.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StatefulWidget> createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final listTitle = <String>[
    "Test Drive",
    "First App",
    "Layout",
    "Battery Level",
    "Read Write File",
    "Page Layout",
    "Animation Page",
    "Gesture Page",
    "Table Data",
  ];

  final listWidget = <Widget>[
    new TestDrive(),
    new RandomWords(),
    new MyAppWidget(),
    new BatteryLevel(),
    new ReadWriteFile(),
    new PageLayout(),
    new AnimationPage(),
    new GesturePage(),
    new DataTablePage(),
  ];

  List<Widget> list = <Widget>[
    new ListTile(
      title: new Text("Test Drive"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Flutter"),
        ),
        body: new ListView.builder(
          itemBuilder: (context, i) {
            return new Container(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      listTitle[i],
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    onTap: () {
                      Navigator
                          .of(context)
                          .push(new MaterialPageRoute(builder: (contest) {
                        return listWidget[i];
                      }));
                    },
                  ),
                  new Divider()
                ],
              ),
            );
          },
          itemCount: listTitle.length,
        ));
  }
}
