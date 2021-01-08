import 'package:json_annotation/json_annotation.dart';

part 'upload_media_model.g.dart';

@JsonSerializable()
class UploadMedia {
  String name;
  @JsonKey(name: 'original_name')
  String originalName;

  UploadMedia({this.name, this.originalName});

  factory UploadMedia.fromJson(Map<String, dynamic> json) => _$UploadMediaFromJson(json);
  Map<String, dynamic> toJson() => _$UploadMediaToJson(this);
}
