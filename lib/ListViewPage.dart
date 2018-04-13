import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  final String title;
  final Map<String, Widget> listView;

  ListViewPage(this.title, this.listView);

  @override
  _ListViewPageState createState() => new _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView.builder(
          itemCount: widget.listView.length,
          itemBuilder: (context, i) {
            return new Column(children: <Widget>[
              new Container(
                child: new ListTile(
                  title: new Text(
                    widget.listView.keys.toList()[i],
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator
                        .of(context)
                        .push(new MaterialPageRoute(builder: (context) {
                      return widget.listView.values.toList()[i];
                    }));
                  },
                ),
                height: 30.0,
              ),
              new Divider(
                height: 8.0,
              )
            ]);
          },
      ),
    );
  }
}
