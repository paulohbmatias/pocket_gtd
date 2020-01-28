// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriorityEnumAdapter extends TypeAdapter<PriorityEnum> {
  @override
  PriorityEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PriorityEnum.LOW;
      case 1:
        return PriorityEnum.NORMAL;
      case 2:
        return PriorityEnum.HIGH;
      case 3:
        return PriorityEnum.URGENT;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, PriorityEnum obj) {
    switch (obj) {
      case PriorityEnum.LOW:
        writer.writeByte(0);
        break;
      case PriorityEnum.NORMAL:
        writer.writeByte(1);
        break;
      case PriorityEnum.HIGH:
        writer.writeByte(2);
        break;
      case PriorityEnum.URGENT:
        writer.writeByte(3);
        break;
    }
  }
}
