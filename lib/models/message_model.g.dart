// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 1;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      id: fields[0] as int,
      userId: fields[1] as dynamic,
      message: fields[2] as String,
      isSeen: fields[3] as dynamic,
      deletedFromSender: fields[4] as String,
      deletedFromReceiver: fields[5] as String,
      conversationId: fields[6] as dynamic,
      humanReadDate: fields[7] as String,
      daysSectionDate: fields[8] as String,
      sender: fields[9] as User,
      hasAttachments: fields[10] as dynamic,
      media: (fields[11] as List)?.cast<MessageMedia>(),
      media2: (fields[12] as List)?.cast<OrderMedia>(),
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.isSeen)
      ..writeByte(4)
      ..write(obj.deletedFromSender)
      ..writeByte(5)
      ..write(obj.deletedFromReceiver)
      ..writeByte(6)
      ..write(obj.conversationId)
      ..writeByte(7)
      ..write(obj.humanReadDate)
      ..writeByte(8)
      ..write(obj.daysSectionDate)
      ..writeByte(9)
      ..write(obj.sender)
      ..writeByte(10)
      ..write(obj.hasAttachments)
      ..writeByte(11)
      ..write(obj.media)
      ..writeByte(12)
      ..write(obj.media2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    id: json['id'] as int,
    userId: json['user_id'],
    message: json['message'] as String,
    isSeen: json['is_seen'],
    deletedFromSender: json['deleted_from_server'] as String,
    deletedFromReceiver: json['deleted_from_receiver'] as String,
    conversationId: json['conversation_id'],
    humanReadDate: json['human_read_date'] as String,
    daysSectionDate: json['days_section_date'] as String,
    sender: json['sender'] == null
        ? null
        : User.fromJson(json['sender'] as Map<String, dynamic>),
    hasAttachments: json['has_attachments'],
    media: (json['media_'] as List)
        ?.map((e) =>
            e == null ? null : MessageMedia.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    media2: (json['media'] as List)
        ?.map((e) =>
            e == null ? null : OrderMedia.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'message': instance.message,
      'is_seen': instance.isSeen,
      'deleted_from_server': instance.deletedFromSender,
      'deleted_from_receiver': instance.deletedFromReceiver,
      'conversation_id': instance.conversationId,
      'human_read_date': instance.humanReadDate,
      'days_section_date': instance.daysSectionDate,
      'sender': instance.sender,
      'has_attachments': instance.hasAttachments,
      'media_': instance.media,
      'media': instance.media2,
    };
