import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:procura_online/models/message_media.dart';
import 'package:procura_online/models/user_model.dart';

import 'order_media.dart';

part 'message_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Message {
  @HiveField(0)
  int id;
  @JsonKey(name: 'user_id')
  @HiveField(1)
  int userId;
  @HiveField(2)
  String message;
  @JsonKey(name: 'is_seen')
  @HiveField(3)
  int isSeen;
  @JsonKey(name: 'deleted_from_server')
  @HiveField(4)
  int deletedFromSender;
  @JsonKey(name: 'deleted_from_receiver')
  @HiveField(5)
  int deletedFromReceiver;
  @JsonKey(name: 'conversation_id')
  @HiveField(6)
  int conversationId;
  @JsonKey(name: 'human_read_date')
  @HiveField(7)
  String humanReadDate;
  @JsonKey(name: 'days_section_date')
  @HiveField(8)
  String daysSectionDate;
  @HiveField(9)
  User sender;
  @JsonKey(name: 'has_attachments')
  @HiveField(10)
  bool hasAttachments;
  @HiveField(11)
  List<MessageMedia> media;

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
