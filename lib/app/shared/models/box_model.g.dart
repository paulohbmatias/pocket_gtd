// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoxModelAdapter extends TypeAdapter<BoxModel> {
  @override
  BoxModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BoxModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BoxModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description);
  }
}
