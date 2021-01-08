import 'package:json_annotation/json_annotation.dart';

import 'order_model.dart';
import 'user_model.dart';

part 'conversation_model.g.dart';

@JsonSerializable()
class Conversation {
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
  User userone;
  User usertwo;
  Order order;
  // LatestMessage latestMessage;
  bool seen;

  Conversation({
    this.id,
    this.orderId,
    this.userOne,
    this.userTwo,
    this.status,
    this.mute,
    this.humanReadDate,
    this.secondUser,
    this.userone,
    this.usertwo,
    this.order,
    this.seen,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
