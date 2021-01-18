// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as dynamic,
      name: fields[1] as String,
      company: fields[2] as String,
      type: fields[3] as String,
      email: fields[4] as String,
      phone: fields[5] as String,
      phoneClicksCount: fields[6] as String,
      districtId: fields[7] as String,
      cityId: fields[8] as String,
      address: fields[9] as String,
      postcode: fields[10] as String,
      vatNumber: fields[11] as String,
      billingCountry: fields[12] as String,
      billingName: fields[13] as String,
      billingCity: fields[14] as String,
      billingAddress: fields[15] as String,
      billingPostcode: fields[16] as String,
      billingZip: fields[17] as String,
      vatId: fields[18] as String,
      extraBillingInformation: fields[19] as String,
      slug: fields[20] as String,
      referredBy: fields[21] as String,
      balance: fields[22] as String,
      notificationsFrequency: fields[23] as String,
      subscribed: fields[24] as String,
      approved: fields[25] as dynamic,
      lastReadAnnouncementsAt: fields[26] as String,
      lastLoginAt: fields[27] as String,
      lastLoginIp: fields[28] as String,
      tourStatus: fields[29] as String,
      emailVerifiedAt: fields[30] as String,
      createdAt: fields[31] as String,
      updatedAt: fields[32] as String,
      deletedAt: fields[33] as String,
      logo: fields[34] as dynamic,
      cover: fields[35] as dynamic,
      referralLink: fields[36] as String,
      isOnline: fields[37] as bool,
      media: (fields[38] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(39)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.company)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.phoneClicksCount)
      ..writeByte(7)
      ..write(obj.districtId)
      ..writeByte(8)
      ..write(obj.cityId)
      ..writeByte(9)
      ..write(obj.address)
      ..writeByte(10)
      ..write(obj.postcode)
      ..writeByte(11)
      ..write(obj.vatNumber)
      ..writeByte(12)
      ..write(obj.billingCountry)
      ..writeByte(13)
      ..write(obj.billingName)
      ..writeByte(14)
      ..write(obj.billingCity)
      ..writeByte(15)
      ..write(obj.billingAddress)
      ..writeByte(16)
      ..write(obj.billingPostcode)
      ..writeByte(17)
      ..write(obj.billingZip)
      ..writeByte(18)
      ..write(obj.vatId)
      ..writeByte(19)
      ..write(obj.extraBillingInformation)
      ..writeByte(20)
      ..write(obj.slug)
      ..writeByte(21)
      ..write(obj.referredBy)
      ..writeByte(22)
      ..write(obj.balance)
      ..writeByte(23)
      ..write(obj.notificationsFrequency)
      ..writeByte(24)
      ..write(obj.subscribed)
      ..writeByte(25)
      ..write(obj.approved)
      ..writeByte(26)
      ..write(obj.lastReadAnnouncementsAt)
      ..writeByte(27)
      ..write(obj.lastLoginAt)
      ..writeByte(28)
      ..write(obj.lastLoginIp)
      ..writeByte(29)
      ..write(obj.tourStatus)
      ..writeByte(30)
      ..write(obj.emailVerifiedAt)
      ..writeByte(31)
      ..write(obj.createdAt)
      ..writeByte(32)
      ..write(obj.updatedAt)
      ..writeByte(33)
      ..write(obj.deletedAt)
      ..writeByte(34)
      ..write(obj.logo)
      ..writeByte(35)
      ..write(obj.cover)
      ..writeByte(36)
      ..write(obj.referralLink)
      ..writeByte(37)
      ..write(obj.isOnline)
      ..writeByte(38)
      ..write(obj.media);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'],
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
    approved: json['approved'],
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
