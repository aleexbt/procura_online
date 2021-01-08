import 'package:json_annotation/json_annotation.dart';

import 'chat_model.dart';
import 'meta_model.dart';

part 'chats_model.g.dart';

@JsonSerializable()
class Chats {
  @JsonKey(name: 'data')
  List<Chat> chats;
  Meta meta;

  Chats({this.chats, this.meta});

  factory Chats.fromJson(Map<String, dynamic> json) => _$ChatsFromJson(json);
  Map<String, dynamic> toJson() => _$ChatsToJson(this);
}
