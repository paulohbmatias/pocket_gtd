// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IconModelAdapter extends TypeAdapter<IconModel> {
  @override
  IconModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IconModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IconModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.codePoint)
      ..writeByte(1)
      ..write(obj.fontFamily)
      ..writeByte(2)
      ..write(obj.fontPackage)
      ..writeByte(3)
      ..write(obj.matchTextDirection);
  }
}
