// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConversationAdapter extends TypeAdapter<Conversation> {
  @override
  final int typeId = 2;

  @override
  Conversation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Conversation(
      id: fields[0] as int,
      orderId: fields[1] as int,
      status: fields[2] as int,
      mute: fields[3] as int,
      createdAt: fields[4] as String,
      updatedAt: fields[5] as String,
      humanReadDate: fields[6] as String,
      userOne: fields[7] as User,
      userTwo: fields[8] as User,
      order: fields[9] as Order,
      messages: (fields[10] as List)?.cast<Message>(),
    );
  }

  @override
  void write(BinaryWriter writer, Conversation obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orderId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.mute)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.humanReadDate)
      ..writeByte(7)
      ..write(obj.userOne)
      ..writeByte(8)
      ..write(obj.userTwo)
      ..writeByte(9)
      ..write(obj.order)
      ..writeByte(10)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return Conversation(
    id: json['id'] as int,
    orderId: json['order_id'] as int,
    status: json['status'] as int,
    mute: json['mute'] as int,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    humanReadDate: json['human_read_date'] as String,
    userOne: json['user_one'] == null
        ? null
        : User.fromJson(json['user_one'] as Map<String, dynamic>),
    userTwo: json['user_two'] == null
        ? null
        : User.fromJson(json['user_two'] as Map<String, dynamic>),
    order: json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    messages: (json['messages'] as List)
        ?.map((e) =>
            e == null ? null : Message.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'status': instance.status,
      'mute': instance.mute,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'human_read_date': instance.humanReadDate,
      'user_one': instance.userOne,
      'user_two': instance.userTwo,
      'order': instance.order,
      'messages': instance.messages,
    };
