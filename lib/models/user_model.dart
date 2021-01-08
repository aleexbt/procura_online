import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  int id;
  String name;
  String company;
  String type;
  String email;
  String phone;
  @JsonKey(name: 'phone_clicks_count')
  String phoneClicksCount;
  @JsonKey(name: 'district_id')
  String districtId;
  @JsonKey(name: 'city_id')
  String cityId;
  String address;
  String postcode;
  @JsonKey(name: 'vat_number')
  String vatNumber;
  @JsonKey(name: 'billing_country')
  String billingCountry;
  @JsonKey(name: 'billing_name')
  String billingName;
  @JsonKey(name: 'billing_city')
  String billingCity;
  @JsonKey(name: 'billing_address')
  String billingAddress;
  @JsonKey(name: 'billing_postcode')
  String billingPostcode;
  @JsonKey(name: 'billing_zip')
  String billingZip;
  @JsonKey(name: 'vat_id')
  String vatId;
  @JsonKey(name: 'extra_billing_information')
  String extraBillingInformation;
  String slug;
  @JsonKey(name: 'referred_by')
  String referredBy;
  String balance;
  @JsonKey(name: 'notifications_frequency')
  String notificationsFrequency;
  String subscribed;
  String approved;
  @JsonKey(name: 'last_read_announcements_at')
  String lastReadAnnouncementsAt;
  @JsonKey(name: 'last_login_at')
  String lastLoginAt;
  @JsonKey(name: 'last_login_ip')
  String lastLoginIp;
  @JsonKey(name: 'tour_status')
  String tourStatus;
  @JsonKey(name: 'email_verified_at')
  String emailVerifiedAt;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'deleted_at')
  String deletedAt;
  dynamic logo;
  dynamic cover;
  @JsonKey(name: 'referral_link')
  String referralLink;
  @JsonKey(name: 'is_online')
  bool isOnline;
  List media;

  User({
    this.id,
    this.name,
    this.company,
    this.type,
    this.email,
    this.phone,
    this.phoneClicksCount,
    this.districtId,
    this.cityId,
    this.address,
    this.postcode,
    this.vatNumber,
    this.billingCountry,
    this.billingName,
    this.billingCity,
    this.billingAddress,
    this.billingPostcode,
    this.billingZip,
    this.vatId,
    this.extraBillingInformation,
    this.slug,
    this.referredBy,
    this.balance,
    this.notificationsFrequency,
    this.subscribed,
    this.approved,
    this.lastReadAnnouncementsAt,
    this.lastLoginAt,
    this.lastLoginIp,
    this.tourStatus,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.logo,
    this.cover,
    this.referralLink,
    this.isOnline,
    this.media,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
