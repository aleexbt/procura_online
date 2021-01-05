import 'chat_model.dart';

class Message {
  int id;
  String userId;
  String message;
  String isSeen;
  String deletedFromSender;
  String deletedFromReceiver;
  String conversationId;
  String humanReadDate;
  String daysSectionDate;
  Conversation conversation;
  Userone sender;
  bool hasAttachments;
  List<Media> media;

  Message(
      {this.id,
      this.userId,
      this.message,
      this.isSeen,
      this.deletedFromSender,
      this.deletedFromReceiver,
      this.conversationId,
      this.humanReadDate,
      this.daysSectionDate,
      this.conversation,
      this.sender,
      this.hasAttachments,
      this.media});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    message = json['message'];
    isSeen = json['is_seen'];
    deletedFromSender = json['deleted_from_sender'];
    deletedFromReceiver = json['deleted_from_receiver'];
    conversationId = json['conversation_id'];
    humanReadDate = json['human_read_date'];
    daysSectionDate = json['days_section_date'];
    conversation = json['conversation'] != null ? new Conversation.fromJson(json['conversation']) : null;
    sender = json['sender'] != null ? new Userone.fromJson(json['sender']) : null;
    hasAttachments = json['has_attachments'];
    if (json['media'] != null) {
      media = new List<Media>();
      json['media'].forEach((v) {
        media.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['message'] = this.message;
    data['is_seen'] = this.isSeen;
    data['deleted_from_sender'] = this.deletedFromSender;
    data['deleted_from_receiver'] = this.deletedFromReceiver;
    data['conversation_id'] = this.conversationId;
    data['human_read_date'] = this.humanReadDate;
    data['days_section_date'] = this.daysSectionDate;
    if (this.conversation != null) {
      data['conversation'] = this.conversation.toJson();
    }
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    data['has_attachments'] = this.hasAttachments;
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  int id;
  String thumb;
  String image;

  Media({this.id, this.thumb, this.image});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumb = json['thumb'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thumb'] = this.thumb;
    data['image'] = this.image;
    return data;
  }
}

class Userone {
  int id;
  String name;
  String company;
  String type;
  String email;
  String phone;
  String districtId;
  String cityId;
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
  List<Media> media;

  Userone(
      {this.id,
      this.name,
      this.company,
      this.type,
      this.email,
      this.phone,
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

  Userone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    company = json['company'];
    type = json['type'];
    email = json['email'];
    phone = json['phone'];
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
    // logo = json['logo'];
    // cover = json['cover'];
    referralLink = json['referral_link'];
    isOnline = json['is_online'];
// if (json['media'] != null) {
// media = new List<Null>();
// json['media'].forEach((v) { media.add(new Null.fromJson(v)); });
// }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['company'] = this.company;
    data['type'] = this.type;
    data['email'] = this.email;
    data['phone'] = this.phone;
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
// if (this.media != null) {
// data['media'] = this.media.map((v) => v.toJson()).toList();
// }
    return data;
  }
}

class LatestMessage {
  int id;
  String message;
  String isSeen;
  String deletedFromSender;
  String deletedFromReceiver;
  String userId;
  String conversationId;
  String createdAt;
  String updatedAt;
  String humanReadDate;
  String daysSectionDate;
  Userone sender;

  LatestMessage(
      {this.id,
      this.message,
      this.isSeen,
      this.deletedFromSender,
      this.deletedFromReceiver,
      this.userId,
      this.conversationId,
      this.createdAt,
      this.updatedAt,
      this.humanReadDate,
      this.daysSectionDate,
      this.sender});

  LatestMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    isSeen = json['is_seen'];
    deletedFromSender = json['deleted_from_sender'];
    deletedFromReceiver = json['deleted_from_receiver'];
    userId = json['user_id'];
    conversationId = json['conversation_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    humanReadDate = json['human_read_date'];
    daysSectionDate = json['days_section_date'];
    sender = json['sender'] != null ? new Userone.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['is_seen'] = this.isSeen;
    data['deleted_from_sender'] = this.deletedFromSender;
    data['deleted_from_receiver'] = this.deletedFromReceiver;
    data['user_id'] = this.userId;
    data['conversation_id'] = this.conversationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['human_read_date'] = this.humanReadDate;
    data['days_section_date'] = this.daysSectionDate;
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    return data;
  }
}
