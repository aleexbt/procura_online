import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:procura_online/models/user_model.dart';

import 'message_model.dart';
import 'order_model.dart';

part 'conversation_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Conversation {
  @HiveField(0)
  int id;
  @JsonKey(name: 'order_id')
  @HiveField(1)
  int orderId;
  @HiveField(2)
  int status;
  @HiveField(3)
  int mute;
  @JsonKey(name: 'created_at')
  @HiveField(4)
  String createdAt;
  @JsonKey(name: 'updated_at')
  @HiveField(5)
  String updatedAt;
  @JsonKey(name: 'human_read_date')
  @HiveField(6)
  String humanReadDate;
  @JsonKey(name: 'user_one')
  @HiveField(7)
  User userOne;
  @JsonKey(name: 'user_two')
  @HiveField(8)
  User userTwo;
  @HiveField(9)
  Order order;
  @HiveField(10)
  List<Message> messages;

  Conversation({
    this.id,
    this.orderId,
    this.status,
    this.mute,
    this.createdAt,
    this.updatedAt,
    this.humanReadDate,
    this.userOne,
    this.userTwo,
    this.order,
    this.messages,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
