// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

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
    conversation: json['conversation'] == null
        ? null
        : Conversation.fromJson(json['conversation'] as Map<String, dynamic>),
    sender: json['sender'] == null
        ? null
        : User.fromJson(json['sender'] as Map<String, dynamic>),
    hasAttachments: json['has_attachments'] as bool,
    media: (json['media'] as List)
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
      'conversation': instance.conversation,
      'sender': instance.sender,
      'has_attachments': instance.hasAttachments,
      'media': instance.media,
    };
