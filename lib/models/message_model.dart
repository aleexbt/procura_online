import 'package:json_annotation/json_annotation.dart';
import 'package:procura_online/models/user_model.dart';

import 'order_media.dart';

part 'message_model.g.dart';

@JsonSerializable()
class Message {
  int id;
  @JsonKey(name: 'user_id')
  dynamic userId;
  String message;
  @JsonKey(name: 'is_seen')
  dynamic isSeen;
  @JsonKey(name: 'deleted_from_server')
  String deletedFromSender;
  @JsonKey(name: 'deleted_from_receiver')
  String deletedFromReceiver;
  @JsonKey(name: 'conversation_id')
  dynamic conversationId;
  @JsonKey(name: 'human_read_date')
  String humanReadDate;
  @JsonKey(name: 'days_section_date')
  String daysSectionDate;
  User sender;
  @JsonKey(name: 'has_attachments')
  dynamic hasAttachments;
  @JsonKey(name: 'media_')
  List<OrderMedia> media;

  Message({
    this.id,
    this.userId,
    this.message,
    this.isSeen,
    this.deletedFromSender,
    this.deletedFromReceiver,
    this.conversationId,
    this.humanReadDate,
    this.daysSectionDate,
    this.sender,
    this.hasAttachments,
    this.media,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
