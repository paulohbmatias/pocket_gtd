import 'package:hive/hive.dart';
part 'hive/task_model.g.dart';

@HiveType()
class TaskModel {

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime deadline;

  TaskModel.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.deadline = map['deadline'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(map['deadline'].toString()))
        : null;
  }
  
  TaskModel.fromDatabase(var map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.deadline = map['deadline'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(map['deadline'].toString()))
        : null;
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'title': this.title,
        'description': this.description,
        'deadline':
            this.deadline != null ? this.deadline.millisecondsSinceEpoch : null
      };

  TaskModel(this.id, this.title, this.description, this.deadline);
}
