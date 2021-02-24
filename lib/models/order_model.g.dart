// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 3;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      id: fields[0] as int,
      userId: fields[1] as int,
      make: fields[2] as String,
      model: fields[3] as String,
      year: fields[4] as int,
      noteText: fields[5] as String,
      numberOfDoors: fields[6] as int,
      fuelType: fields[7] as String,
      engineDisplacement: fields[8] as String,
      mpn: fields[9] as String,
      userInfo: fields[10] as User,
      makeLogoUrl: fields[11] as String,
      mediaCount: fields[12] as int,
      seen: fields[14] as bool,
      humanReadDate: fields[15] as String,
      sold: fields[16] as bool,
    )..media = (fields[13] as List)?.cast<OrderMedia>();
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.make)
      ..writeByte(3)
      ..write(obj.model)
      ..writeByte(4)
      ..write(obj.year)
      ..writeByte(5)
      ..write(obj.noteText)
      ..writeByte(6)
      ..write(obj.numberOfDoors)
      ..writeByte(7)
      ..write(obj.fuelType)
      ..writeByte(8)
      ..write(obj.engineDisplacement)
      ..writeByte(9)
      ..write(obj.mpn)
      ..writeByte(10)
      ..write(obj.userInfo)
      ..writeByte(11)
      ..write(obj.makeLogoUrl)
      ..writeByte(12)
      ..write(obj.mediaCount)
      ..writeByte(13)
      ..write(obj.media)
      ..writeByte(14)
      ..write(obj.seen)
      ..writeByte(15)
      ..write(obj.humanReadDate)
      ..writeByte(16)
      ..write(obj.sold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['id'] as int,
    userId: json['user_id'] as int,
    make: json['make'] as String,
    model: json['model'] as String,
    year: json['year'] as int,
    noteText: json['note_text'] as String,
    numberOfDoors: json['number_of_doors'] as int,
    fuelType: json['fuel_type'] as String,
    engineDisplacement: json['engine_displacement'] as String,
    mpn: json['mpn'] as String,
    userInfo: json['user_info'] == null
        ? null
        : User.fromJson(json['user_info'] as Map<String, dynamic>),
    makeLogoUrl: json['make_logo_url'] as String,
    mediaCount: json['media_count'] as int,
    seen: json['seen'] as bool,
    humanReadDate: json['human_read_date'] as String,
    sold: json['sold'] as bool,
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
