// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleChat _$SingleChatFromJson(Map<String, dynamic> json) {
  return SingleChat(
    order: json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    messages: (json['messages'] as List)
        ?.map((e) =>
            e == null ? null : Message.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SingleChatToJson(SingleChat instance) =>
    <String, dynamic>{
      'order': instance.order,
      'messages': instance.messages,
    };
