// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadMedia _$UploadMediaFromJson(Map<String, dynamic> json) {
  return UploadMedia(
    name: json['name'] as String,
    originalName: json['original_name'] as String,
  );
}

Map<String, dynamic> _$UploadMediaToJson(UploadMedia instance) =>
    <String, dynamic>{
      'name': instance.name,
      'original_name': instance.originalName,
    };
