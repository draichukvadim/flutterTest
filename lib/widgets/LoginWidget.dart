import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(hintText: "Лунтик любит не пустых"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text или придет лунтик и сьест твое лицо!';
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(hintText: "Бобр любит больше 3х"),
            validator: (value) {
              if (value.length < 3) {
                return 'Тили бом, больше трех бро или бобр тебя куснет';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
          Center(
            child: _image == null
                ? new Text('No image selected.')
                : new Image.file(_image),
          ),
          FlatButton(
            onPressed: getImage,
            child: Text("Pick image"),
          )
        ],
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
}
