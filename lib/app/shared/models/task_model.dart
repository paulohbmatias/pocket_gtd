import 'package:hive/hive.dart';
part 'hive/task_model.g.dart';

@HiveType()
class TaskModel extends HiveObject{

  @HiveField(0)
  int id;

  @HiveField(1)
  int idLocal;

  @HiveField(2)
  String title;

  @HiveField(3)
  String content;

  @HiveField(4)
  DateTime deadline;

  TaskModel.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.idLocal = map['idLocal'];
    this.title = map['title'];
    this.content = map['content'];
    this.deadline = map['deadline'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(map['deadline'].toString()))
        : null;
  }
  
  TaskModel.fromDatabase(var map) {
    this.id = map['id'];
    this.idLocal = map['idLocal'];
    this.title = map['title'];
    this.content = map['content'];
    this.deadline = map['deadline'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(map['deadline'].toString()))
        : null;
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'idLocal': this.idLocal,
        'title': this.title,
        'content': this.content,
        'deadline':
            this.deadline != null ? this.deadline.millisecondsSinceEpoch : null
      };

  TaskModel(this.id, this.idLocal, this.title, this.content, this.deadline);
}