// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
    id: json['id'] as int,
    orderId: json['order_id'] as int,
    status: json['status'] as int,
    mute: json['mute'] as bool,
    humanReadDate: json['human_read_date'] as String,
    secondUser: json['second_user'] as int,
    userOne: json['userOne'] == null
        ? null
        : User.fromJson(json['userOne'] as Map<String, dynamic>),
    userTwo: json['userTwo'] == null
        ? null
        : User.fromJson(json['userTwo'] as Map<String, dynamic>),
    order: json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    latestMessage: json['latest_message'] == null
        ? null
        : Message.fromJson(json['latest_message'] as Map<String, dynamic>),
    seen: json['seen'] as bool,
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'status': instance.status,
      'mute': instance.mute,
      'human_read_date': instance.humanReadDate,
      'second_user': instance.secondUser,
      'userOne': instance.userOne,
      'userTwo': instance.userTwo,
      'order': instance.order,
      'latest_message': instance.latestMessage,
      'seen': instance.seen,
    };
