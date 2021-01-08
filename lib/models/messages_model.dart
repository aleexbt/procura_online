import 'package:json_annotation/json_annotation.dart';

import 'message_model.dart';
import 'meta_model.dart';

part 'messages_model.g.dart';

@JsonSerializable()
class Messages {
  @JsonKey(name: 'data')
  List<Message> messages;
  Meta meta;

  Messages({this.messages, this.meta});

  factory Messages.fromJson(Map<String, dynamic> json) => _$MessagesFromJson(json);
  Map<String, dynamic> toJson() => _$MessagesToJson(this);
}
