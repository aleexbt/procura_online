// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    userId: json['user_id'] as int,
    title: json['title'] as String,
    slug: json['slug'] as String,
    description: json['description'] as String,
    make: json['make'] as String,
    model: json['model'] as String,
    year: json['year'] as int,
    color: json['color'] as String,
    numberOfSeats: json['number_of_seats'] as int,
    numberOfDoors: json['number_of_doors'] as int,
    fuelType: json['fuel_type'] as String,
    engineDisplacement: json['engine_displacement'] as int,
    enginePower: json['engine_power'] as int,
    transmission: json['transmission'] as String,
    registered: json['registered'] as String,
    mileage: json['mileage'] as String,
    condition: json['condition'] as String,
    price: json['price'] as String,
    oldPrice: json['old_price'] as String,
    negotiable: json['negotiable'] as int,
    featured: json['featured'] as int,
    approved: json['approved'] as int,
    viewsCount: json['views_count'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    categories: (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Categories.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    mainPhoto: json['main_photo'] == null
        ? null
        : MainPhoto.fromJson(json['main_photo'] as Map<String, dynamic>),
    gallery: json['gallery'] == null
        ? null
        : Photos.fromJson(json['gallery'] as Map<String, dynamic>) ?? [],
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'user_id': instance.userId,
    'title': instance.title,
    'slug': instance.slug,
    'description': instance.description,
    'make': instance.make,
    'model': instance.model,
    'year': instance.year,
    'color': instance.color,
    'number_of_seats': instance.numberOfSeats,
    'number_of_doors': instance.numberOfDoors,
    'fuel_type': instance.fuelType,
    'engine_displacement': instance.engineDisplacement,
    'engine_power': instance.enginePower,
    'transmission': instance.transmission,
    'registered': instance.registered,
    'mileage': instance.mileage,
    'condition': instance.condition,
    'price': instance.price,
    'old_price': instance.oldPrice,
    'negotiable': instance.negotiable,
    'featured': instance.featured,
    'approved': instance.approved,
    'views_count': instance.viewsCount,
    'created_at': instance.createdAt,
    'updated_at': instance.updatedAt,
    'categories': instance.categories,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('main_photo', instance.mainPhoto);
  writeNotNull('gallery', instance.gallery);
  return val;
}

Categories _$CategoriesFromJson(Map<String, dynamic> json) {
  return Categories(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

MainPhoto _$MainPhotoFromJson(Map<String, dynamic> json) {
  return MainPhoto(
    original: json['original'] as String,
    thumb: json['thumb'] as String,
    bigThumb: json['big_thumb'] as String,
  );
}

Map<String, dynamic> _$MainPhotoToJson(MainPhoto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('original', instance.original);
  writeNotNull('thumb', instance.thumb);
  writeNotNull('big_thumb', instance.bigThumb);
  return val;
}

Photos _$PhotosFromJson(Map<String, dynamic> json) {
  return Photos(
    original: json['original'] as Map<String, dynamic>,
    thumb: json['thumb'] as Map<String, dynamic>,
    bigThumb: json['bigThumb'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$PhotosToJson(Photos instance) => <String, dynamic>{
      'original': instance.original,
      'thumb': instance.thumb,
      'bigThumb': instance.bigThumb,
    };
