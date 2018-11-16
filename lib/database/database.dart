import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_flutter_app/model/repository_model.dart';

class RepositoryDatabase {
  static final RepositoryDatabase _instance = RepositoryDatabase._internal();

  factory RepositoryDatabase() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  RepositoryDatabase._internal();

  Future<Database> initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Repositories (id STRING PRIMARY KEY, name TEXT, description TEXT)");
    print("DB was created");
  }

  Future<int> addRepository(Repository repository) async {
    var dbClient = await db;
    int id = await dbClient.insert("Repositories", repository.toMap());
    print("Repo added $id");
    return id;
  }

  Future closeDb() async {
    var dbClient = await db;
    dbClient.close();
  }
}
