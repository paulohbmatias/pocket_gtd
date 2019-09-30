import 'package:sembast/sembast.dart';

class TaskModel {
  int id;
  String title, description;
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
  
  TaskModel.fromDatabase(RecordSnapshot<dynamic, dynamic> map) {
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
}
