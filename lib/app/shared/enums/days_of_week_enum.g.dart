// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'days_of_week_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DaysOfWeekEnumAdapter extends TypeAdapter<DaysOfWeekEnum> {
  @override
  DaysOfWeekEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DaysOfWeekEnum.MONDAY;
      case 1:
        return DaysOfWeekEnum.TUESDAY;
      case 2:
        return DaysOfWeekEnum.WEDNESDAY;
      case 3:
        return DaysOfWeekEnum.THURSDAY;
      case 4:
        return DaysOfWeekEnum.FRIDAY;
      case 5:
        return DaysOfWeekEnum.SATURDAY;
      case 6:
        return DaysOfWeekEnum.SUNDAY;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, DaysOfWeekEnum obj) {
    switch (obj) {
      case DaysOfWeekEnum.MONDAY:
        writer.writeByte(0);
        break;
      case DaysOfWeekEnum.TUESDAY:
        writer.writeByte(1);
        break;
      case DaysOfWeekEnum.WEDNESDAY:
        writer.writeByte(2);
        break;
      case DaysOfWeekEnum.THURSDAY:
        writer.writeByte(3);
        break;
      case DaysOfWeekEnum.FRIDAY:
        writer.writeByte(4);
        break;
      case DaysOfWeekEnum.SATURDAY:
        writer.writeByte(5);
        break;
      case DaysOfWeekEnum.SUNDAY:
        writer.writeByte(6);
        break;
    }
  }
}
