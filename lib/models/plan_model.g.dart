// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) {
  return Plan(
    id: json['id'] as int,
    slug: json['slug'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    isActive: json['is_active'] as int,
    price: json['price'] as String,
    signupFee: json['signup_fee'] as String,
    currency: json['currency'] as String,
    trialPeriod: json['trial_period'] as int,
    trialInterval: json['trial_interval'] as String,
    invoicePeriod: json['invoice_period'] as int,
    invoiceInterval: json['invoice_interval'] as String,
    gracePeriod: json['grace_period'] as int,
    graceInterval: json['grace_interval'] as String,
    prorateDay: json['prorate_day'],
    proratePeriod: json['prorate_period'],
    prorateExtendDue: json['prorate_extend_due'],
    activeSubscribersLimit: json['active_subscribers_limit'],
    sortOrder: json['sort_order'] as int,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    deletedAt: json['deleted_at'] as String,
    features: (json['features'] as List)
        ?.map((e) =>
            e == null ? null : PlanFeatures.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'description': instance.description,
      'is_active': instance.isActive,
      'price': instance.price,
      'signup_fee': instance.signupFee,
      'currency': instance.currency,
      'trial_period': instance.trialPeriod,
      'trial_interval': instance.trialInterval,
      'invoice_period': instance.invoicePeriod,
      'invoice_interval': instance.invoiceInterval,
      'grace_period': instance.gracePeriod,
      'grace_interval': instance.graceInterval,
      'prorate_day': instance.prorateDay,
      'prorate_period': instance.proratePeriod,
      'prorate_extend_due': instance.prorateExtendDue,
      'active_subscribers_limit': instance.activeSubscribersLimit,
      'sort_order': instance.sortOrder,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'features': instance.features,
    };

PlanFeatures _$PlanFeaturesFromJson(Map<String, dynamic> json) {
  return PlanFeatures(
    id: json['id'] as int,
    planId: json['plan_id'] as int,
    slug: json['slug'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    value: json['value'] as String,
    resettablePeriod: json['resettable_period'] as int,
    resettableInterval: json['resettable_interval'] as String,
    sortOrder: json['sort_order'] as int,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    deletedAt: json['deleted_at'] as String,
  );
}

Map<String, dynamic> _$PlanFeaturesToJson(PlanFeatures instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plan_id': instance.planId,
      'slug': instance.slug,
      'name': instance.name,
      'description': instance.description,
      'value': instance.value,
      'resettable_period': instance.resettablePeriod,
      'resettable_interval': instance.resettableInterval,
      'sort_order': instance.sortOrder,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
