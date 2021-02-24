import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class User {
  @HiveField(0)
  dynamic id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String company;
  @HiveField(3)
  String type;
  @HiveField(4)
  String email;
  @HiveField(5)
  String phone;
  @JsonKey(name: 'phone_clicks_count')
  @HiveField(6)
  String phoneClicksCount;
  @JsonKey(name: 'district_id')
  @HiveField(7)
  int districtId;
  @JsonKey(name: 'city_id')
  @HiveField(8)
  int cityId;
  @HiveField(9)
  String address;
  @HiveField(10)
  String postcode;
  @JsonKey(name: 'vat_number')
  @HiveField(11)
  String vatNumber;
  @JsonKey(name: 'billing_country')
  @HiveField(12)
  String billingCountry;
  @JsonKey(name: 'billing_name')
  @HiveField(13)
  String billingName;
  @JsonKey(name: 'billing_city')
  @HiveField(14)
  String billingCity;
  @JsonKey(name: 'billing_address')
  @HiveField(15)
  String billingAddress;
  @JsonKey(name: 'billing_postcode')
  @HiveField(16)
  String billingPostcode;
  @JsonKey(name: 'billing_zip')
  @HiveField(17)
  String billingZip;
  @JsonKey(name: 'vat_id')
  @HiveField(18)
  String vatId;
  @JsonKey(name: 'extra_billing_information')
  @HiveField(19)
  String extraBillingInformation;
  @HiveField(20)
  String slug;
  @JsonKey(name: 'referred_by')
  @HiveField(21)
  int referredBy;
  @HiveField(22)
  String balance;
  @JsonKey(name: 'notifications_frequency')
  @HiveField(23)
  String notificationsFrequency;
  @HiveField(24)
  int subscribed;
  @HiveField(25)
  int approved;
  @JsonKey(name: 'last_read_announcements_at')
  @HiveField(26)
  String lastReadAnnouncementsAt;
  @JsonKey(name: 'last_login_at')
  @HiveField(27)
  String lastLoginAt;
  @JsonKey(name: 'last_login_ip')
  @HiveField(28)
  String lastLoginIp;
  @JsonKey(name: 'tour_status')
  @HiveField(29)
  int tourStatus;
  @JsonKey(name: 'email_verified_at')
  @HiveField(30)
  String emailVerifiedAt;
  @JsonKey(name: 'created_at')
  @HiveField(31)
  String createdAt;
  @JsonKey(name: 'updated_at')
  @HiveField(32)
  String updatedAt;
  @JsonKey(name: 'deleted_at')
  @HiveField(33)
  String deletedAt;
  @HiveField(34)
  Logo logo;
  @HiveField(35)
  Cover cover;
  @JsonKey(name: 'referral_link')
  @HiveField(36)
  String referralLink;
  @JsonKey(name: 'is_online')
  @HiveField(37)
  bool isOnline;
  @HiveField(38)
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

@JsonSerializable()
@HiveType(typeId: 7)
class Logo {
  @HiveField(0)
  String thumbnail;
  @HiveField(1)
  String url;

  Logo({this.thumbnail, this.url});

  factory Logo.fromJson(Map<String, dynamic> json) => _$LogoFromJson(json);
  Map<String, dynamic> toJson() => _$LogoToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 8)
class Cover {
  @HiveField(0)
  String thumbnail;
  @HiveField(1)
  String url;

  Cover({this.thumbnail, this.url});

  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);
  Map<String, dynamic> toJson() => _$CoverToJson(this);
}
