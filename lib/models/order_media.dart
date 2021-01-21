import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_media.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class OrderMedia {
  @HiveField(0)
  int id;
  @JsonKey(name: 'file_name')
  @HiveField(1)
  String fileName;

  OrderMedia({this.id, this.fileName});

  factory OrderMedia.fromJson(Map<String, dynamic> json) => _$OrderMediaFromJson(json);
  Map<String, dynamic> toJson() => _$OrderMediaToJson(this);
}
