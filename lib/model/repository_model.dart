import 'package:meta/meta.dart';

class Repository {
  String id, name, description;

  Repository({
    @required this.id,
    @required this.name,
    @required this.description,
  });

  Repository.fromJson(Map json)
      : id = json["id"].toString(),
        name = json["name"],
        description = json["description"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    return map;
  }
}
