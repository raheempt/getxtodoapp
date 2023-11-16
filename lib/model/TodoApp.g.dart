// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TodoApp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAppAdapter extends TypeAdapter<TodoApp> {
  @override
  final int typeId = 1;

  @override
  TodoApp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoApp(
      name: fields[0] as String,
      text: fields[1] as String,
      image: fields[2] as Uint8List,
      dateTime: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TodoApp obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAppAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
