// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TempModelAdapter extends TypeAdapter<TempModel> {
  @override
  final int typeId = 1;

  @override
  TempModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TempModel(
      windSpeed: fields[0] as double?,
      windDegrees: fields[1] as int?,
      temp: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TempModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.windSpeed)
      ..writeByte(1)
      ..write(obj.windDegrees)
      ..writeByte(2)
      ..write(obj.temp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TempModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
