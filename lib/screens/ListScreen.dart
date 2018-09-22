import 'package:flutter/material.dart';
import 'package:test_flutter_app/widgets/RandomWordsListWidget.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Second Screen"),
        ),
        body: new RandomWordsWidget());
  }
}
