import 'package:hive/hive.dart';
import 'package:pocket_gtd/app/shared/models/priority_enum.dart';
import 'package:pocket_gtd/app/shared/models/user_model.dart';
part 'task_model.g.dart';

@HiveType()
class TaskModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int idLocal;

  @HiveField(2)
  String title;

  @HiveField(3)
  String details;

  @HiveField(4)
  DateTime deadline;

  @HiveField(5)
  DateTime when;

  @HiveField(6)
  UserModel who;

  @HiveField(7)
  bool done = false;

  @HiveField(8)
  PriorityEnum priority = PriorityEnum.NORMAL;

  TaskModel.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.idLocal = map['idLocal'];
    this.details = map['content'];
    this.deadline =
        map['deadline'] != null ? DateTime.fromMillisecondsSinceEpoch(int.parse(map['deadline'].toString())) : null;
    this.when = map['when'] != null ? DateTime.fromMillisecondsSinceEpoch(int.parse(map['when'].toString())) : null;
    this.who = UserModel.fromJson(map['who']);
  }

  TaskModel.fromDatabase(var map) {
    this.id = map['id'];
    this.idLocal = map['idLocal'];
    this.details = map['content'];
    this.deadline =
        map['deadline'] != null ? DateTime.fromMillisecondsSinceEpoch(int.parse(map['deadline'].toString())) : null;
    this.when = map['when'] != null ? DateTime.fromMillisecondsSinceEpoch(int.parse(map['when'].toString())) : null;
    this.who = UserModel.fromJson(map['who']);
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'idLocal': this.idLocal,
        'content': this.details,
        'deadline': this.deadline != null ? this.deadline.millisecondsSinceEpoch : null,
        'when': this.when != null ? this.when.millisecondsSinceEpoch : null,
        'who': who.toMap()
      };

  TaskModel();
}
