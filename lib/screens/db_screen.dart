import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:test_flutter_app/database/database.dart';
import 'package:test_flutter_app/model/repository_model.dart';

class DbScreen extends StatefulWidget {
  @override
  State createState() => DbScreenState();
}

class DbScreenState extends State<DbScreen> {
  List<Repository> gitHubRepositories = List();
  bool isLoading = false;
  RepositoryDatabase db;

  PublishSubject subject = PublishSubject<String>();

  @override
  void dispose() {
    subject.close();
    db.closeDb();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    db = RepositoryDatabase();
    db.initDb();
    subject.stream
        .debounce(Duration(microseconds: 400))
        .listen(_searchRepositories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Db test screen"),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (String string) => (subject.add(string)),
              ),
              isLoading ? CircularProgressIndicator() : Container(),
              Expanded(
                child: ListView.builder(
                    itemCount: gitHubRepositories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new RepositoryView(gitHubRepositories[index], db);
                    }),
              )
            ],
          ),
        ));
  }

  void _searchRepositories(query) {
    _resetRepositories();
    if (query.isEmpty)
      setState(() {
        isLoading = false;
      });
    else {
      setState(() {
        isLoading = true;
      });
      http
          .get("https://api.github.com/search/repositories?q=$query")
          .then((res) => (res.body))
          .then(json.decode)
          .then((map) => map["items"])
          .then((repositories) => repositories.forEach(_addRepository))
          .catchError(onError)
          .then((e) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  void _resetRepositories() {
    setState(() => gitHubRepositories.clear());
  }

  void _addRepository(item) {
    setState(() {
      gitHubRepositories.add(Repository.fromJson(item));
    });
  }

  void onError(dynamic d) {
    setState(() {
      isLoading = false;
    });
  }
}

class RepositoryView extends StatefulWidget {
  RepositoryView(this.repository, this.repositoryDatabase);

  final Repository repository;
  final RepositoryDatabase repositoryDatabase;

  @override
  State createState() => RepositoryViewState(this.repositoryDatabase);
}

class RepositoryViewState extends State<RepositoryView> {
  Repository repository;
  RepositoryDatabase repositoryDatabase;

  RepositoryViewState(this.repositoryDatabase);

  @override
  void initState() {
    super.initState();
    repository = widget.repository;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100.0,
        child: Column(
          children: <Widget>[
            Text("${repository.name}"),
            Text("${repository.description}"),
            FlatButton(
              child: Text("Add to db!"),
              onPressed: () => repositoryDatabase.addRepository(repository),
            )
          ],
        ),
      ),
    );
  }
}
