import 'package:flutter/material.dart';

class GridViewLayout extends StatefulWidget {
  final title = "Grid View";

  @override
  State<StatefulWidget> createState() {
    return new GridViewLayoutState();
  }
}

class GridViewLayoutState extends State<GridViewLayout> {
  List<Container> _buildGridTileList(int count) {
    return new List<Container>.generate(
        count,
        (index) => new Container(
              child: new Image.asset("images/lake.jpg"),
            ));
  }

  Widget buildGrid() {
    return new GridView.extent(
      maxCrossAxisExtent: 150.0,
      padding: const EdgeInsets.all(2.0),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
      children: _buildGridTileList(30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        leading: new IconButton(
            icon: new Icon(Icons.backspace),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: new Center(
        child: buildGrid(),
      ),
    );
  }
}
