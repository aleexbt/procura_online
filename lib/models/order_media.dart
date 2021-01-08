import 'package:json_annotation/json_annotation.dart';

part 'order_media.g.dart';

@JsonSerializable()
class OrderMedia {
  int id;
  String thumb;
  String image;

  OrderMedia({this.id, this.thumb, this.image});

  factory OrderMedia.fromJson(Map<String, dynamic> json) => _$OrderMediaFromJson(json);
  Map<String, dynamic> toJson() => _$OrderMediaToJson(this);
}
