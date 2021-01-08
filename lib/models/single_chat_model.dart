import 'package:json_annotation/json_annotation.dart';

import 'message_model.dart';
import 'order_model.dart';

part 'single_chat_model.g.dart';

@JsonSerializable()
class SingleChat {
  Order order;
  List<Message> messages;

  SingleChat({this.order, this.messages});

  factory SingleChat.fromJson(Map<String, dynamic> json) => _$SingleChatFromJson(json);
  Map<String, dynamic> toJson() => _$SingleChatToJson(this);

  @override
  String toString() => "Messages: ${messages.toString()}";
}
