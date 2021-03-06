import 'package:json_annotation/json_annotation.dart';
import 'package:procura_online/models/user_model.dart';

import 'message_model.dart';
import 'order_model.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class Chat {
  int id;
  @JsonKey(name: 'order_id')
  int orderId;
  int status;
  bool mute;
  @JsonKey(name: 'human_read_date')
  String humanReadDate;
  @JsonKey(name: 'second_user')
  int secondUser;
  User userOne;
  User userTwo;
  Order order;
  @JsonKey(name: 'latest_message')
  Message latestMessage;
  bool seen;

  Chat({
    this.id,
    this.orderId,
    this.status,
    this.mute,
    this.humanReadDate,
    this.secondUser,
    this.userOne,
    this.userTwo,
    this.order,
    this.latestMessage,
    this.seen,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
