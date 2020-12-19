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
  String districtId;
  String cityId;
  String address;
  String postcode;
  Null vatNumber;
  Null billingCountry;
  Null billingName;
  Null billingCity;
  Null billingAddress;
  Null billingPostcode;
  Null billingZip;
  Null vatId;
  Null extraBillingInformation;
  String slug;
  Null referredBy;
  String balance;
  Null notificationsFrequency;
  String subscribed;
  String approved;
  Null lastReadAnnouncementsAt;
  Null lastLoginAt;
  Null lastLoginIp;
  String tourStatus;
  Null emailVerifiedAt;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  Null logo;
  Null cover;
  String referralLink;
  bool isOnline;
  List<Null> media;

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
    id = json['id'];
    name = json['name'];
    company = json['company'];
    type = json['type'];
    email = json['email'];
    phone = json['phone'];
    phoneClicksCount = json['phone_clicks_count'];
    districtId = json['district_id'];
    cityId = json['city_id'];
    address = json['address'];
    postcode = json['postcode'];
    vatNumber = json['vat_number'];
    billingCountry = json['billing_country'];
    billingName = json['billing_name'];
    billingCity = json['billing_city'];
    billingAddress = json['billing_address'];
    billingPostcode = json['billing_postcode'];
    billingZip = json['billing_zip'];
    vatId = json['vat_id'];
    extraBillingInformation = json['extra_billing_information'];
    slug = json['slug'];
    referredBy = json['referred_by'];
    balance = json['balance'];
    notificationsFrequency = json['notifications_frequency'];
    subscribed = json['subscribed'];
    approved = json['approved'];
    lastReadAnnouncementsAt = json['last_read_announcements_at'];
    lastLoginAt = json['last_login_at'];
    lastLoginIp = json['last_login_ip'];
    tourStatus = json['tour_status'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    logo = json['logo'];
    cover = json['cover'];
    referralLink = json['referral_link'];
    isOnline = json['is_online'];
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
