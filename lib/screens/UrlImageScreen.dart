import 'package:flutter/material.dart';

class UrlImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Не злите лунтика"),
        ),
        body: Column(children: <Widget>[
          Image.network(
            'https://i.ytimg.com/vi/uQDNg478Dvs/maxresdefault.jpg',
          ),
          Image.network(
            'https://www.meme-arsenal.com/memes/671618e1be086d55b1f31505caafc117.jpg',
          )
        ]));
  }
}
