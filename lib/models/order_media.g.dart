// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderMedia _$OrderMediaFromJson(Map<String, dynamic> json) {
  return OrderMedia(
    id: json['id'] as int,
    thumb: json['thumb'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$OrderMediaToJson(OrderMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thumb': instance.thumb,
      'image': instance.image,
    };
