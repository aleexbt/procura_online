import 'package:json_annotation/json_annotation.dart';
import 'package:procura_online/models/user_model.dart';

import 'message_model.dart';
import 'order_model.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class Chat {
  int id;
  @JsonKey(name: 'order_id')
  String orderId;
  @JsonKey(name: 'user_one')
  String userOne;
  @JsonKey(name: 'user_two')
  String userTwo;
  String status;
  bool mute;
  @JsonKey(name: 'human_read_date')
  String humanReadDate;
  @JsonKey(name: 'second_user')
  String secondUser;
  Order order;
  @JsonKey(name: 'latest_message')
  Message latestMessage;
  bool seen;

  Chat({
    this.id,
    this.orderId,
    this.userOne,
    this.userTwo,
    this.status,
    this.mute,
    this.humanReadDate,
    this.secondUser,
    this.order,
    this.latestMessage,
    this.seen,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
