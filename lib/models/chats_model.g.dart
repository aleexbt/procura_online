// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chats _$ChatsFromJson(Map<String, dynamic> json) {
  return Chats(
    chats: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Chat.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChatsToJson(Chats instance) => <String, dynamic>{
      'data': instance.chats,
      'meta': instance.meta,
    };
