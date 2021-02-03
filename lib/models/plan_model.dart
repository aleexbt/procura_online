import 'package:json_annotation/json_annotation.dart';

part 'plan_model.g.dart';

@JsonSerializable()
class Plan {
  int id;
  String name;
  String description;
  String price;
  @JsonKey(name: 'trial_period')
  int trialPeriod;
  @JsonKey(name: 'trial_interval')
  String trialInterval;
  @JsonKey(name: 'invoice_period')
  int invoicePeriod;
  @JsonKey(name: 'invoice_interval')
  String invoiceInterval;
  @JsonKey(name: 'grace_period')
  int gracePeriod;
  @JsonKey(name: 'grace_interval')
  String graceInterval;

  Plan({
    this.id,
    this.name,
    this.description,
    this.price,
    this.trialPeriod,
    this.trialInterval,
    this.invoicePeriod,
    this.invoiceInterval,
    this.gracePeriod,
    this.graceInterval,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
  Map<String, dynamic> toJson() => _$PlanToJson(this);
}
