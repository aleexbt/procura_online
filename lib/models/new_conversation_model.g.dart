// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewConversationModel _$NewConversationModelFromJson(Map<String, dynamic> json) {
  return NewConversationModel(
    id: json['id'] as int,
    orderId: json['order_id'] as String,
    status: json['status'] as String,
    mute: json['mute'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated__at'] as String,
    humanReadDate: json['human_read_date'] as String,
    secondUser: json['second_user'] as String,
    userOne: json['userone'] == null
        ? null
        : User.fromJson(json['userone'] as Map<String, dynamic>),
    userTwo: json['usertwo'] == null
        ? null
        : User.fromJson(json['usertwo'] as Map<String, dynamic>),
    order: json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    messages: (json['messages'] as List)
        ?.map((e) =>
            e == null ? null : Message.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NewConversationModelToJson(
        NewConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'status': instance.status,
      'mute': instance.mute,
      'created_at': instance.createdAt,
      'updated__at': instance.updatedAt,
      'human_read_date': instance.humanReadDate,
      'second_user': instance.secondUser,
      'userone': instance.userOne,
      'usertwo': instance.userTwo,
      'order': instance.order,
      'messages': instance.messages,
    };
