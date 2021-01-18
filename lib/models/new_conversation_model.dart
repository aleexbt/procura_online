import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import 'package:procura_online/models/user_model.dart';

import 'message_model.dart';
import 'order_model.dart';

part 'new_conversation_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class NewConversationModel {
  @HiveField(0)
  int id;
  @JsonKey(name: 'order_id')
  @HiveField(1)
  String orderId;
  @HiveField(2)
  String status;
  @HiveField(3)
  String mute;
  @JsonKey(name: 'created_at')
  @HiveField(4)
  String createdAt;
  @JsonKey(name: 'updated_at')
  @HiveField(5)
  String updatedAt;
  @JsonKey(name: 'human_read_date')
  @HiveField(6)
  String humanReadDate;
  @JsonKey(name: 'second_user')
  @HiveField(7)
  String secondUser;
  @JsonKey(name: 'userone')
  @HiveField(8)
  User userOne;
  @JsonKey(name: 'usertwo')
  @HiveField(9)
  User userTwo;
  @HiveField(10)
  Order order;
  @HiveField(11)
  List<Message> messages;

  NewConversationModel({
    this.id,
    this.orderId,
    this.status,
    this.mute,
    this.createdAt,
    this.updatedAt,
    this.humanReadDate,
    this.secondUser,
    this.userOne,
    this.userTwo,
    this.order,
    this.messages,
  });

  factory NewConversationModel.fromJson(Map<String, dynamic> json) =>
      _$NewConversationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewConversationModelToJson(this);
}
