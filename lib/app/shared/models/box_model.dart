import 'package:hive/hive.dart';
part 'box_model.g.dart';

@HiveType()
class BoxModel {

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

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

  BoxModel(this.id, this.title, this.description);
}