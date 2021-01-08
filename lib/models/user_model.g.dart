// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['name'] as String,
    company: json['company'] as String,
    type: json['type'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    phoneClicksCount: json['phone_clicks_count'] as String,
    districtId: json['district_id'] as String,
    cityId: json['city_id'] as String,
    address: json['address'] as String,
    postcode: json['postcode'] as String,
    vatNumber: json['vat_number'] as String,
    billingCountry: json['billing_country'] as String,
    billingName: json['billing_name'] as String,
    billingCity: json['billing_city'] as String,
    billingAddress: json['billing_address'] as String,
    billingPostcode: json['billing_postcode'] as String,
    billingZip: json['billing_zip'] as String,
    vatId: json['vat_id'] as String,
    extraBillingInformation: json['extra_billing_information'] as String,
    slug: json['slug'] as String,
    referredBy: json['referred_by'] as String,
    balance: json['balance'] as String,
    notificationsFrequency: json['notifications_frequency'] as String,
    subscribed: json['subscribed'] as String,
    approved: json['approved'] as String,
    lastReadAnnouncementsAt: json['last_read_announcements_at'] as String,
    lastLoginAt: json['last_login_at'] as String,
    lastLoginIp: json['last_login_ip'] as String,
    tourStatus: json['tour_status'] as String,
    emailVerifiedAt: json['email_verified_at'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    deletedAt: json['deleted_at'] as String,
    logo: json['logo'],
    cover: json['cover'],
    referralLink: json['referral_link'] as String,
    isOnline: json['is_online'] as bool,
    media: json['media'] as List,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company': instance.company,
      'type': instance.type,
      'email': instance.email,
      'phone': instance.phone,
      'phone_clicks_count': instance.phoneClicksCount,
      'district_id': instance.districtId,
      'city_id': instance.cityId,
      'address': instance.address,
      'postcode': instance.postcode,
      'vat_number': instance.vatNumber,
      'billing_country': instance.billingCountry,
      'billing_name': instance.billingName,
      'billing_city': instance.billingCity,
      'billing_address': instance.billingAddress,
      'billing_postcode': instance.billingPostcode,
      'billing_zip': instance.billingZip,
      'vat_id': instance.vatId,
      'extra_billing_information': instance.extraBillingInformation,
      'slug': instance.slug,
      'referred_by': instance.referredBy,
      'balance': instance.balance,
      'notifications_frequency': instance.notificationsFrequency,
      'subscribed': instance.subscribed,
      'approved': instance.approved,
      'last_read_announcements_at': instance.lastReadAnnouncementsAt,
      'last_login_at': instance.lastLoginAt,
      'last_login_ip': instance.lastLoginIp,
      'tour_status': instance.tourStatus,
      'email_verified_at': instance.emailVerifiedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'logo': instance.logo,
      'cover': instance.cover,
      'referral_link': instance.referralLink,
      'is_online': instance.isOnline,
      'media': instance.media,
    };
