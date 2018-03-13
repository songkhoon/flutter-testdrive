import 'package:flutter/material.dart';

class PageLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PageLayoutState();
  }
}

class PageLayoutState extends State<PageLayout> {
  final _imageContainer = new Container(
    child: new Image.asset(
      "images/lake.jpg",
      package: "build_layout",
      fit: BoxFit.cover,
    ),
  );

  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Page Layout"),
      ),
      body: new Center(
          child: new Stack(children: <Widget>[
        new PageView(
          children: <Widget>[_imageContainer, _imageContainer],
        ),
        new Positioned(
            bottom: 30.0,
            left: 0.0,
            right: 0.0,
            child: new Container(
              child: new Column(
                children: <Widget>[
                  new RaisedButton(
                    child: const Text("Long Button Name 1"),
                    color: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10.0,),
                  new RaisedButton(
                    child: const Text("Button 2"),
                    onPressed: () {},
                  ),
                ],
              ),
            )),
      ])),
    );
  }
}
