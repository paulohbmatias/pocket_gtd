// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  TaskModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel()
      ..id = fields[0] as int
      ..idLocal = fields[1] as int
      ..title = fields[2] as String
      ..details = fields[3] as String
      ..deadline = fields[4] as DateTime
      ..when = fields[5] as DateTime
      ..who = fields[6] as UserModel
      ..done = fields[7] as bool;
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idLocal)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.details)
      ..writeByte(4)
      ..write(obj.deadline)
      ..writeByte(5)
      ..write(obj.when)
      ..writeByte(6)
      ..write(obj.who)
      ..writeByte(7)
      ..write(obj.done);
  }
}
