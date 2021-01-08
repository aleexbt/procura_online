// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return Conversation(
    id: json['id'] as int,
    orderId: json['order_id'] as String,
    userOne: json['user_one'] as String,
    userTwo: json['user_two'] as String,
    status: json['status'] as String,
    mute: json['mute'] as bool,
    humanReadDate: json['human_read_date'] as String,
    secondUser: json['second_user'] as String,
    userone: json['userone'] == null
        ? null
        : User.fromJson(json['userone'] as Map<String, dynamic>),
    usertwo: json['usertwo'] == null
        ? null
        : User.fromJson(json['usertwo'] as Map<String, dynamic>),
    order: json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    seen: json['seen'] as bool,
  );
}

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'user_one': instance.userOne,
      'user_two': instance.userTwo,
      'status': instance.status,
      'mute': instance.mute,
      'human_read_date': instance.humanReadDate,
      'second_user': instance.secondUser,
      'userone': instance.userone,
      'usertwo': instance.usertwo,
      'order': instance.order,
      'seen': instance.seen,
    };
