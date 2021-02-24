import 'package:json_annotation/json_annotation.dart';
import 'package:procura_online/models/product_model.dart';
import 'package:procura_online/models/user_model.dart';

import 'meta_model.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class Profile {
  List<Product> data;
  User user;
  Meta meta;

  Profile({this.data, this.user, this.meta});

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
