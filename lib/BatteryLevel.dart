import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryLevel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BatteryLevelState();
  }
}

class BatteryLevelState extends State<BatteryLevel> {
  static const platform = const MethodChannel("samples.flutter.io/battery");

  String _batteryLevel = "Unknown batter level";

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod("getBatteryLevel");
      batteryLevel = "Battery level at $result %.";
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get gattery level: '${e.message}'.";
    } on MissingPluginException catch (e) {
      batteryLevel = "Failed to get gattery level: '${e.message}'.";
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Battery Level"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new RaisedButton(
                child: new Text("Get Battery Level"),
                onPressed: _getBatteryLevel),
            new Text(_batteryLevel)
          ],
        ),
      ),
    );
  }
}
