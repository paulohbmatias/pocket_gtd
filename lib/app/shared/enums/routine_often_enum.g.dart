// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_often_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineOftenEnumAdapter extends TypeAdapter<RoutineOftenEnum> {
  @override
  RoutineOftenEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RoutineOftenEnum.DAY;
      case 1:
        return RoutineOftenEnum.WEEK;
      case 2:
        return RoutineOftenEnum.MONTH;
      case 3:
        return RoutineOftenEnum.YEAR;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, RoutineOftenEnum obj) {
    switch (obj) {
      case RoutineOftenEnum.DAY:
        writer.writeByte(0);
        break;
      case RoutineOftenEnum.WEEK:
        writer.writeByte(1);
        break;
      case RoutineOftenEnum.MONTH:
        writer.writeByte(2);
        break;
      case RoutineOftenEnum.YEAR:
        writer.writeByte(3);
        break;
    }
  }
}
