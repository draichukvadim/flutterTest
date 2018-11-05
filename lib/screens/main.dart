import 'package:flutter/material.dart';
import 'package:test_flutter_app/screens/ListScreen.dart';
import 'package:test_flutter_app/screens/LoginScreen.dart';
import 'package:test_flutter_app/screens/UrlImageScreen.dart';
import 'package:test_flutter_app/widgets/BatteryLevelWidget.dart';
import 'package:test_flutter_app/widgets/TwoWordsWidget.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Builder(
        builder: (context) => Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TwoWordsWidget(),
                  Text('You have pushed PLUS button this many times:'),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  FlatButton(
                      onPressed: () => _showMessage(context, "Next"),
                      child: Text("Show Message")),
                  FlatButton(
                      onPressed: () => _navigateToUrlImageScreen(context),
                      child: Text("Не ходи сюды")),
                  FlatButton(
                      onPressed: () => _navigateToLoginScreen(context),
                      child: Text("Open Login Page")),
                  BatteryLevelWidget(),
                  IconButton(
                    icon: new Icon(Icons.arrow_forward),
                    onPressed: () => _navigateToListScreen(context),
                  )
                ],
              ),
            ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }

  void _showMessage(BuildContext context, String text) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(SnackBar(
      content: new Text(text),
    ));
  }

  void _navigateToListScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListScreen()),
    );
  }

  void _navigateToUrlImageScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UrlImageScreen()),
    );
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
