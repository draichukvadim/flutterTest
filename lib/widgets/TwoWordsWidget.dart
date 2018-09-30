  import 'package:english_words/english_words.dart';
  import 'package:flutter/material.dart';

class TwoWordsWidget extends StatefulWidget {
  @override
  State createState() => new TwoWordsState();
}

class TwoWordsState extends State<TwoWordsWidget> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text("Custom two words: " + wordPair.asPascalCase);
  }
}
