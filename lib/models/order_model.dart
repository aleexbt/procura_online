import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:procura_online/models/user_model.dart';

import 'order_media.dart';

part 'order_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class Order {
  @HiveField(0)
  int id;
  @JsonKey(name: 'user_id')
  @HiveField(1)
  int userId;
  @HiveField(2)
  String make;
  @HiveField(3)
  String model;
  @HiveField(4)
  int year;
  @JsonKey(name: 'note_text')
  @HiveField(5)
  String noteText;
  @JsonKey(name: 'number_of_doors')
  @HiveField(6)
  int numberOfDoors;
  @JsonKey(name: 'fuel_type')
  @HiveField(7)
  String fuelType;
  @JsonKey(name: 'engine_displacement')
  @HiveField(8)
  int engineDisplacement;
  @HiveField(9)
  String mpn;
  @JsonKey(name: 'user_info')
  @HiveField(10)
  User userInfo;
  @JsonKey(name: 'make_logo_url')
  @HiveField(11)
  String makeLogoUrl;
  @JsonKey(name: 'media_count')
  @HiveField(12)
  int mediaCount;
  @HiveField(13)
  List<OrderMedia> media;
  @HiveField(14)
  bool seen;
  @JsonKey(name: 'human_read_date')
  @HiveField(15)
  String humanReadDate;
  @HiveField(16)
  bool sold;

  Order({
    this.id,
    this.userId,
    this.make,
    this.model,
    this.year,
    this.noteText,
    this.numberOfDoors,
    this.fuelType,
    this.engineDisplacement,
    this.mpn,
    this.userInfo,
    this.makeLogoUrl,
    this.mediaCount,
    this.seen,
    this.humanReadDate,
    this.sold,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
