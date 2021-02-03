// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) {
  return Plan(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    price: json['price'] as String,
    trialPeriod: json['trial_period'] as int,
    trialInterval: json['trial_interval'] as String,
    invoicePeriod: json['invoice_period'] as int,
    invoiceInterval: json['invoice_interval'] as String,
    gracePeriod: json['grace_period'] as int,
    graceInterval: json['grace_interval'] as String,
  );
}

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'trial_period': instance.trialPeriod,
      'trial_interval': instance.trialInterval,
      'invoice_period': instance.invoicePeriod,
      'invoice_interval': instance.invoiceInterval,
      'grace_period': instance.gracePeriod,
      'grace_interval': instance.graceInterval,
    };
