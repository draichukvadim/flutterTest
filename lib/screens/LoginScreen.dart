import 'package:flutter/material.dart';
import 'package:test_flutter_app/widgets/LoginWidget.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Screen"),
        ),
        body: LoginWidget());
  }
}
