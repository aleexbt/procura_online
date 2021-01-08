import 'package:json_annotation/json_annotation.dart';
import 'package:procura_online/models/product_model.dart';

import 'meta_model.dart';

part 'listing_model.g.dart';

@JsonSerializable()
class Listing {
  @JsonKey(name: 'data')
  List<Product> products;
  Meta meta;

  Listing({this.products, this.meta});

  factory Listing.fromJson(Map<String, dynamic> json) => _$ListingFromJson(json);
  Map<String, dynamic> toJson() => _$ListingToJson(this);
}
