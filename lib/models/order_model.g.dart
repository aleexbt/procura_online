// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['id'] as int,
    userId: json['user_id'] as String,
    make: json['make'] as String,
    model: json['model'] as String,
    year: json['year'] as String,
    noteText: json['note_text'] as String,
    numberOfDoors: json['number_of_doors'] as String,
    fuelType: json['fuel_type'] as String,
    engineDisplacement: json['engine_displacement'] as String,
    mpn: json['mpn'] as String,
    userInfo: json['user_info'] == null
        ? null
        : User.fromJson(json['user_info'] as Map<String, dynamic>),
    makeLogoUrl: json['make_logo_url'] as String,
    mediaCount: json['media_count'] as String,
    seen: json['seen'] as bool,
    humanReadDate: json['human_read_date'] as String,
    sold: json['sold'],
  )..media = (json['media'] as List)
      ?.map((e) =>
          e == null ? null : OrderMedia.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'note_text': instance.noteText,
      'number_of_doors': instance.numberOfDoors,
      'fuel_type': instance.fuelType,
      'engine_displacement': instance.engineDisplacement,
      'mpn': instance.mpn,
      'user_info': instance.userInfo,
      'make_logo_url': instance.makeLogoUrl,
      'media_count': instance.mediaCount,
      'media': instance.media,
      'seen': instance.seen,
      'human_read_date': instance.humanReadDate,
      'sold': instance.sold,
    };
