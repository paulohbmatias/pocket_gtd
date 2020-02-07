// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineModelAdapter extends TypeAdapter<RoutineModel> {
  @override
  RoutineModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoutineModel()
      ..id = fields[0] as int
      ..idLocal = fields[1] as int
      ..title = fields[2] as String
      ..details = fields[3] as String
      ..begin = fields[4] as DateTime
      ..end = fields[5] as DateTime
      ..isDateUndefined = fields[6] as bool
      ..often = fields[7] as int
      ..initDay = fields[8] as int
      ..initMonth = fields[9] as int
      ..routineOften = fields[10] as RoutineOftenEnum
      ..days = (fields[11] as List)?.cast<DateTime>()
      ..daysOfWeek = (fields[12] as List)?.cast<DaysOfWeekEnum>()
      ..isActive = fields[13] as bool;
  }

  @override
  void write(BinaryWriter writer, RoutineModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idLocal)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.details)
      ..writeByte(4)
      ..write(obj.begin)
      ..writeByte(5)
      ..write(obj.end)
      ..writeByte(6)
      ..write(obj.isDateUndefined)
      ..writeByte(7)
      ..write(obj.often)
      ..writeByte(8)
      ..write(obj.initDay)
      ..writeByte(9)
      ..write(obj.initMonth)
      ..writeByte(10)
      ..write(obj.routineOften)
      ..writeByte(11)
      ..write(obj.days)
      ..writeByte(12)
      ..write(obj.daysOfWeek)
      ..writeByte(13)
      ..write(obj.isActive);
  }
}
