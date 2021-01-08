import 'package:json_annotation/json_annotation.dart';

import 'meta_model.dart';
import 'order_model.dart';

part 'orders_model.g.dart';

@JsonSerializable()
class Orders {
  @JsonKey(name: 'data')
  List<Order> orders;
  Meta meta;

  Orders({this.orders, this.meta});

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}
