import 'package:flutter/material.dart';
import 'package:flutter_app/github_api_client.dart';
import 'package:flutter_app/github_repo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'GitHub Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<GithubRepo> _items;

  var _listViewKey = new Key('ListView');

  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var listView = new ListView(
      key: _listViewKey,
      itemExtent: 50.0,
      children: _createWidgets(_items),
    );
    var container = new Container(
        height: 500.0,
        child: listView
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            new TextField(
              decoration: const InputDecoration(
                hintText: 'Flutter',
                labelText: 'Query',
              ),
              maxLines: 1,
              controller: _controller,
            ),
            new Container(
              padding: const EdgeInsets.all(20.0),
              child: new RaisedButton(
                child: const Text('Search'),
                onPressed: _search,
              ),
            ),
            container,
          ],
        ),
      ),
    );
  }

  void _search() {
    var client = new GithubClient();
    client.get(_controller.text).then((result) {
      setState(() {
        _items = result;
      });
    });
  }

  Iterable<Widget> _createWidgets(List<GithubRepo> items) {
    var ret = new List<Widget>();
    if (items == null) {
      return ret;
    }
    items.forEach((item) {
      ret.add(
          new Text(item.name)
      );
    });
    return ret;
  }
}
