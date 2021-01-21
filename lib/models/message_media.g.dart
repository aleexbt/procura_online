// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_media.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageMediaAdapter extends TypeAdapter<MessageMedia> {
  @override
  final int typeId = 5;

  @override
  MessageMedia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageMedia(
      id: fields[0] as int,
      thumb: fields[1] as String,
      image: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MessageMedia obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.thumb)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageMediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageMedia _$MessageMediaFromJson(Map<String, dynamic> json) {
  return MessageMedia(
    id: json['id'] as int,
    thumb: json['thumb'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$MessageMediaToJson(MessageMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thumb': instance.thumb,
      'image': instance.image,
    };
