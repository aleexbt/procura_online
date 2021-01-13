import 'package:json_annotation/json_annotation.dart';
import 'package:procura_online/models/user_model.dart';

import 'message_model.dart';
import 'order_model.dart';

part 'new_conversation_model.g.dart';

@JsonSerializable()
class NewConversationModel {
  int id;
  @JsonKey(name: 'order_id')
  String orderId;
  String status;
  String mute;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated__at')
  String updatedAt;
  @JsonKey(name: 'human_read_date')
  String humanReadDate;
  @JsonKey(name: 'second_user')
  String secondUser;
  @JsonKey(name: 'userone')
  User userOne;
  @JsonKey(name: 'usertwo')
  User userTwo;
  Order order;
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

  factory NewConversationModel.fromJson(Map<String, dynamic> json) => _$NewConversationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewConversationModelToJson(this);
}
