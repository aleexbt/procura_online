import 'package:json_annotation/json_annotation.dart';
import 'package:procura_online/models/user_model.dart';

import 'order_media.dart';

part 'order_model.g.dart';

@JsonSerializable()
class Order {
  int id;
  @JsonKey(name: 'user_id')
  String userId;
  String make;
  String model;
  String year;
  @JsonKey(name: 'note_text')
  String noteText;
  @JsonKey(name: 'number_of_doors')
  String numberOfDoors;
  @JsonKey(name: 'fuel_type')
  String fuelType;
  @JsonKey(name: 'engine_displacement')
  String engineDisplacement;
  String mpn;
  @JsonKey(name: 'user_info')
  User userInfo;
  @JsonKey(name: 'make_logo_url')
  String makeLogoUrl;
  @JsonKey(name: 'media_count')
  String mediaCount;
  List<OrderMedia> media;
  bool seen;
  @JsonKey(name: 'human_read_date')
  String humanReadDate;
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
