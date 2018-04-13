import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  final String title;
  final Map<String, Widget> listView;

  ListViewPage(this.title, this.listView);

  @override
  _ListViewPageState createState() => new _ListViewPageState(this);
}

class _ListViewPageState extends State<ListViewPage> {
  final ListViewPage _listViewPage;

  _ListViewPageState(this._listViewPage);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_listViewPage.title),
      ),
      body: new ListView.builder(
          itemCount: _listViewPage.listView.length,
          itemBuilder: (context, i) {
            return new Column(children: <Widget>[
              new Container(
                child: new ListTile(
                  title: new Text(
                    _listViewPage.listView.keys.toList()[i],
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator
                        .of(context)
                        .push(new MaterialPageRoute(builder: (context) {
                      return _listViewPage.listView.values.toList()[i];
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
