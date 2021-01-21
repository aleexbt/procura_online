import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_media.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class MessageMedia {
  @HiveField(0)
  int id;
  @HiveField(1)
  String thumb;
  @HiveField(2)
  String image;

  MessageMedia({this.id, this.thumb, this.image});

  factory MessageMedia.fromJson(Map<String, dynamic> json) => _$MessageMediaFromJson(json);
  Map<String, dynamic> toJson() => _$MessageMediaToJson(this);
}
