class UserModel {
  String token;
  User user;

  UserModel({this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String company;
  String type;
  String email;
  String phone;
  String phoneClicksCount;
  dynamic districtId;
  dynamic cityId;
  String address;
  String postcode;
  String vatNumber;
  String billingCountry;
  String billingName;
  String billingCity;
  String billingAddress;
  String billingPostcode;
  String billingZip;
  String vatId;
  String extraBillingInformation;
  String slug;
  String referredBy;
  String balance;
  String notificationsFrequency;
  String subscribed;
  String approved;
  String lastReadAnnouncementsAt;
  String lastLoginAt;
  String lastLoginIp;
  String tourStatus;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String logo;
  String cover;
  String referralLink;
  bool isOnline;
  List media;

  User(
      {this.id,
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
      this.media});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? null;
    name = json['name'] ?? null;
    company = json['company'] ?? null;
    type = json['type'] ?? null;
    email = json['email'] ?? null;
    phone = json['phone'] ?? null;
    phoneClicksCount = json['phone_clicks_count'] ?? null;
    districtId = json['district_id'] ?? null;
    cityId = json['city_id'] ?? null;
    address = json['address'] ?? null;
    postcode = json['postcode'] ?? null;
    vatNumber = json['vat_number'] ?? null;
    billingCountry = json['billing_country'] ?? null;
    billingName = json['billing_name'] ?? null;
    billingCity = json['billing_city'] ?? null;
    billingAddress = json['billing_address'] ?? null;
    billingPostcode = json['billing_postcode'] ?? null;
    billingZip = json['billing_zip'] ?? null;
    vatId = json['vat_id'] ?? null;
    extraBillingInformation = json['extra_billing_information'] ?? null;
    slug = json['slug'] ?? null;
    referredBy = json['referred_by'] ?? null;
    balance = json['balance'] ?? null;
    notificationsFrequency = json['notifications_frequency'] ?? null;
    subscribed = json['subscribed'] ?? null;
    approved = json['approved'] ?? null;
    lastReadAnnouncementsAt = json['last_read_announcements_at'] ?? null;
    lastLoginAt = json['last_login_at'] ?? null;
    lastLoginIp = json['last_login_ip'] ?? null;
    tourStatus = json['tour_status'] ?? null;
    emailVerifiedAt = json['email_verified_at'] ?? null;
    createdAt = json['created_at'] ?? null;
    updatedAt = json['updated_at'] ?? null;
    deletedAt = json['deleted_at'] ?? null;
    logo = json['logo'] ?? null;
    cover = json['cover'] ?? null;
    referralLink = json['referral_link'] ?? null;
    isOnline = json['is_online'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['company'] = this.company;
    data['type'] = this.type;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['phone_clicks_count'] = this.phoneClicksCount;
    data['district_id'] = this.districtId;
    data['city_id'] = this.cityId;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['vat_number'] = this.vatNumber;
    data['billing_country'] = this.billingCountry;
    data['billing_name'] = this.billingName;
    data['billing_city'] = this.billingCity;
    data['billing_address'] = this.billingAddress;
    data['billing_postcode'] = this.billingPostcode;
    data['billing_zip'] = this.billingZip;
    data['vat_id'] = this.vatId;
    data['extra_billing_information'] = this.extraBillingInformation;
    data['slug'] = this.slug;
    data['referred_by'] = this.referredBy;
    data['balance'] = this.balance;
    data['notifications_frequency'] = this.notificationsFrequency;
    data['subscribed'] = this.subscribed;
    data['approved'] = this.approved;
    data['last_read_announcements_at'] = this.lastReadAnnouncementsAt;
    data['last_login_at'] = this.lastLoginAt;
    data['last_login_ip'] = this.lastLoginIp;
    data['tour_status'] = this.tourStatus;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['logo'] = this.logo;
    data['cover'] = this.cover;
    data['referral_link'] = this.referralLink;
    data['is_online'] = this.isOnline;
    return data;
  }
}
