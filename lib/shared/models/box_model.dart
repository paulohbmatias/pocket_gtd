import 'dart:collection';

import 'package:sembast/sembast.dart';

class BoxModel {
  int id;
  String title, description;

  BoxModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
  }

  BoxModel.fromDatabase(var map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
  }
  
  toJson() => {
    'id': this.id,
    'title': this.title,
    'description': this.description
  };
}
