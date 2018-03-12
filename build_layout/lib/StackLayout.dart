import 'package:flutter/material.dart';

class StackLayout extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new StackLayoutState();
  }

}

class StackLayoutState extends State<StackLayout> {
  var stack = new Stack(
    alignment: const Alignment(0.0, 0.6),
    children: [
      new CircleAvatar(
        backgroundImage: new AssetImage("images/lake.jpg", package: "build_layout"),
        radius: 100.0,
      ),
      new Container(
        decoration: new BoxDecoration(
          color: Colors.black45,
        ),
        child: new Text(
          'Description',
          style: new TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Stack View"),
      ),
      body: new Center(
        child: stack,
      ),
    );
  }


}