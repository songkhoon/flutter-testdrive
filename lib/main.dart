import 'package:flutter/material.dart';
import 'package:testdrive/AnimationPage.dart';
import 'package:testdrive/BatteryLevel.dart';
import 'package:testdrive/CustomPainter/CustomPainterPage.dart';
import 'package:testdrive/DataTablePage.dart';
import 'package:testdrive/GesturePage.dart';
import 'package:testdrive/ListViewPage.dart';
import 'package:testdrive/MVP/Contacts/view/contact_view.dart';
import 'package:testdrive/MVP/CryptoApp/CryptoView.dart';
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
  final _mvpWidgets = {
    "Contact List": new ContactList(),
    "Crypto App": new CryptoView(),
  };

  Map<String, Widget> get _homePageWidgets {
    return {
      "Test Drive": new TestDrive(),
      "First App": new RandomWords(),
      "Layout": new MyAppWidget(),
      "Battery Level": new BatteryLevel(),
      "Read Write File": new ReadWriteFile(),
      "Page Layout": new PageLayout(),
      "Animation Page": new AnimationPage(),
      "Gesture Page": new GesturePage(),
      "Table Data": new DataTablePage(),
      "Custom Paint Page": new CustomPainterPage(),
      "MVP Architecture": new ListViewPage("MVP Architecture", _mvpWidgets),
    };
  }

  List<Widget> list = <Widget>[
    new ListTile(
      title: new Text("Test Drive"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return new ListViewPage("Flutter", _homePageWidgets);
  }
}
