import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  int id;
  @JsonKey(name: 'user_id')
  int userId;
  String title;
  String slug;
  String description;
  String make;
  String model;
  int year;
  String color;
  @JsonKey(name: 'number_of_seats')
  int numberOfSeats;
  @JsonKey(name: 'number_of_doors')
  int numberOfDoors;
  @JsonKey(name: 'fuel_type')
  String fuelType;
  @JsonKey(name: 'engine_displacement')
  int engineDisplacement;
  @JsonKey(name: 'engine_power')
  int enginePower;
  String transmission;
  String registered;
  String mileage;
  String condition;
  String price;
  @JsonKey(name: 'old_price')
  String oldPrice;
  int negotiable;
  int featured;
  int approved;
  @JsonKey(name: 'views_count')
  String viewsCount;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  List<Categories> categories;
  @JsonKey(name: 'main_photo', includeIfNull: false)
  MainPhoto mainPhoto;
  @JsonKey(includeIfNull: false, defaultValue: [])
  Photos gallery;

  Product({
    this.id,
    this.userId,
    this.title,
    this.slug,
    this.description,
    this.make,
    this.model,
    this.year,
    this.color,
    this.numberOfSeats,
    this.numberOfDoors,
    this.fuelType,
    this.engineDisplacement,
    this.enginePower,
    this.transmission,
    this.registered,
    this.mileage,
    this.condition,
    this.price,
    this.oldPrice,
    this.negotiable,
    this.featured,
    this.approved,
    this.viewsCount,
    this.createdAt,
    this.updatedAt,
    this.categories,
    this.mainPhoto,
    this.gallery,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Categories {
  int id;
  String name;

  Categories({this.id, this.name});

  factory Categories.fromJson(Map<String, dynamic> json) => _$CategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}

@JsonSerializable(includeIfNull: false)
class MainPhoto {
  String original;
  String thumb;
  @JsonKey(name: 'big_thumb')
  String bigThumb;

  MainPhoto({this.original, this.thumb, this.bigThumb});

  factory MainPhoto.fromJson(Map<String, dynamic> json) => _$MainPhotoFromJson(json);
  Map<String, dynamic> toJson() => _$MainPhotoToJson(this);
}

@JsonSerializable()
class Photos {
  Map<String, dynamic> original;
  Map<String, dynamic> thumb;
  Map<String, dynamic> bigThumb;

  Photos({this.original, this.thumb, this.bigThumb});

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        original:
            json['original'] != null ? Map.from(json['original']).map((k, v) => MapEntry<String, dynamic>(k, v)) : null,
        thumb: json['thumb'] != null ? Map.from(json['thumb']).map((k, v) => MapEntry<String, dynamic>(k, v)) : null,
        bigThumb: json['big_thumb'] != null
            ? Map.from(json['big_thumb']).map((k, v) => MapEntry<String, dynamic>(k, v))
            : null,
      );
  Map<String, dynamic> toJson() => _$PhotosToJson(this);
}
