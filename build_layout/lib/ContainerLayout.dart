import "package:flutter/material.dart";

class ContainerLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ContainerLayoutState();
  }

}

class ContainerLayoutState extends State<ContainerLayout> {
  @override
  Widget build(BuildContext context) {

    var imageContainer = new Container(
      decoration: new BoxDecoration(
        border: new Border.all(width: 5.0, color: Colors.white),
        borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
      ),
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(4.0),
      child: new Image.asset("images/lake.jpg"),
    );

    var container = new Container(
      decoration: new BoxDecoration(
        color: Colors.blue,
      ),
      padding: const EdgeInsets.only(top: 10.0, left: 2.0, right: 2.0),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(
                  child: imageContainer
              ),
              new Expanded(
                  child: imageContainer
              )
            ],
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: imageContainer
              ),
              new Expanded(
                  child: imageContainer
              )
            ],
          ),
        ],
      ),
    );

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Container"),
          leading: new IconButton(
              icon: new Icon(Icons.backspace),
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
        ),
        body: container,
      ),
      theme: new ThemeData(primaryColor: Colors.lightBlue),
    );
  }

}
