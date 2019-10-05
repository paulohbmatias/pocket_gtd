import 'package:hive/hive.dart';
part 'hive/box_model.g.dart';

@HiveType()
class BoxModel {

  @HiveField(0)
  int id;

  @HiveField(1)
  int idLocal;

  @HiveField(2)
  String title;

  @HiveField(3)
  String description;

  BoxModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.idLocal = map['idLocal'];
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
    'idLocal': this.idLocal,
    'title': this.title,
    'description': this.description
  };

  BoxModel(this.id, this.idLocal, this.title, this.description);
}