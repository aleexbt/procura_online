import 'package:json_annotation/json_annotation.dart';

part 'plan_model.g.dart';

@JsonSerializable()
class Plan {
  int id;
  String slug;
  String name;
  String description;
  @JsonKey(name: 'is_active')
  int isActive;
  String price;
  @JsonKey(name: 'signup_fee')
  String signupFee;
  String currency;
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
  @JsonKey(name: 'prorate_day')
  dynamic prorateDay;
  @JsonKey(name: 'prorate_period')
  dynamic proratePeriod;
  @JsonKey(name: 'prorate_extend_due')
  dynamic prorateExtendDue;
  @JsonKey(name: 'active_subscribers_limit')
  dynamic activeSubscribersLimit;
  @JsonKey(name: 'sort_order')
  int sortOrder;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'deleted_at')
  String deletedAt;
  List<PlanFeatures> features;

  Plan({
    this.id,
    this.slug,
    this.name,
    this.description,
    this.isActive,
    this.price,
    this.signupFee,
    this.currency,
    this.trialPeriod,
    this.trialInterval,
    this.invoicePeriod,
    this.invoiceInterval,
    this.gracePeriod,
    this.graceInterval,
    this.prorateDay,
    this.proratePeriod,
    this.prorateExtendDue,
    this.activeSubscribersLimit,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.features,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
  Map<String, dynamic> toJson() => _$PlanToJson(this);
}

@JsonSerializable()
class PlanFeatures {
  int id;
  @JsonKey(name: 'plan_id')
  int planId;
  String slug;
  String name;
  String description;
  String value;
  @JsonKey(name: 'resettable_period')
  int resettablePeriod;
  @JsonKey(name: 'resettable_interval')
  String resettableInterval;
  @JsonKey(name: 'sort_order')
  int sortOrder;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'deleted_at')
  String deletedAt;

  PlanFeatures({
    this.id,
    this.planId,
    this.slug,
    this.name,
    this.description,
    this.value,
    this.resettablePeriod,
    this.resettableInterval,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PlanFeatures.fromJson(Map<String, dynamic> json) => _$PlanFeaturesFromJson(json);
  Map<String, dynamic> toJson() => _$PlanFeaturesToJson(this);
}
