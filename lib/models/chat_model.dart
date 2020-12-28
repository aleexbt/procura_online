class ChatModel {
  List<Conversation> data;
  Links links;
  Meta meta;

  ChatModel({this.data, this.links, this.meta});

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Conversation>();
      json['data'].forEach((v) {
        data.add(new Conversation.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class Conversation {
  int id;
  String orderId;
  String userOne;
  String userTwo;
  String status;
  bool mute;
  String humanReadDate;
  String secondUser;
  Userone userone;
  Userone usertwo;
  Order order;
  LatestMessage latestMessage;
  bool seen;

  Conversation(
      {this.id,
      this.orderId,
      this.userOne,
      this.userTwo,
      this.status,
      this.mute,
      this.humanReadDate,
      this.secondUser,
      this.userone,
      this.usertwo,
      this.order,
      this.latestMessage,
      this.seen});

  Conversation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userOne = json['user_one'];
    userTwo = json['user_two'];
    status = json['status'];
    mute = json['mute'];
    humanReadDate = json['human_read_date'];
    secondUser = json['second_user'];
    userone = json['userone'] != null ? new Userone.fromJson(json['userone']) : null;
    usertwo = json['usertwo'] != null ? new Userone.fromJson(json['usertwo']) : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    latestMessage = json['latest_message'] != null ? new LatestMessage.fromJson(json['latest_message']) : null;
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user_one'] = this.userOne;
    data['user_two'] = this.userTwo;
    data['status'] = this.status;
    data['mute'] = this.mute;
    data['human_read_date'] = this.humanReadDate;
    data['second_user'] = this.secondUser;
    if (this.userone != null) {
      data['userone'] = this.userone.toJson();
    }
    if (this.usertwo != null) {
      data['usertwo'] = this.usertwo.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    if (this.latestMessage != null) {
      data['latest_message'] = this.latestMessage.toJson();
    }
    data['seen'] = this.seen;
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
  String phoneClicksCount;
  String districtId;
  String cityId;
  String address;
  String postcode;
  String vatNumber;
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
  String lastLoginAt;
  String lastLoginIp;
  String tourStatus;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  Null logo;
  Null cover;
  String referralLink;
  bool isOnline;
  List<Null> media;

  Userone(
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

  Userone.fromJson(Map<String, dynamic> json) {
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
    // if (json['media'] != null) {
    //   media = new List<Null>();
    //   json['media'].forEach((v) {
    //     media.add(new Null.fromJson(v));
    //   });
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
    // if (this.media != null) {
    //   data['media'] = this.media.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Order {
  int id;
  String userId;
  String make;
  String model;
  String year;
  String noteText;
  UserInfo userInfo;
  String makeLogoUrl;
  Null mediaCount;
  List<int> conversations;
  List<Media> media;
  bool seen;
  String humanReadDate;
  bool sold;

  Order(
      {this.id,
      this.userId,
      this.make,
      this.model,
      this.year,
      this.noteText,
      this.userInfo,
      this.makeLogoUrl,
      this.mediaCount,
      this.conversations,
      this.media,
      this.seen,
      this.humanReadDate,
      this.sold});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    make = json['make'];
    model = json['model'];
    year = json['year'];
    noteText = json['note_text'];
    userInfo = json['user_info'] != null ? new UserInfo.fromJson(json['user_info']) : null;
    makeLogoUrl = json['make_logo_url'];
    mediaCount = json['media_count'];
    // conversations = json['conversations'].cast<int>();
    if (json['media'] != null) {
      media = new List<Media>();
      json['media'].forEach((v) {
        media.add(new Media.fromJson(v));
      });
    }
    seen = json['seen'];
    humanReadDate = json['human_read_date'];
    sold = json['sold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['make'] = this.make;
    data['model'] = this.model;
    data['year'] = this.year;
    data['note_text'] = this.noteText;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo.toJson();
    }
    data['make_logo_url'] = this.makeLogoUrl;
    data['media_count'] = this.mediaCount;
    data['conversations'] = this.conversations;
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    data['seen'] = this.seen;
    data['human_read_date'] = this.humanReadDate;
    data['sold'] = this.sold;
    return data;
  }
}

class UserInfo {
  String name;
  String company;
  String email;
  String slug;
  String phone;
  String tourStatus;
  String districtId;
  String cityId;
  String address;
  String postcode;
  String vatNumber;
  Null vatId;
  Null billingName;
  Null billingCountry;
  Null billingZip;
  Null billingCity;
  Null billingAddress;
  Null billingPostcode;
  Null extraBillingInformation;
  String type;
  Null referredBy;
  String balance;
  Null notificationsFrequency;
  String subscribed;
  String approved;
  String password;
  String rememberToken;
  Null lastReadAnnouncementsAt;
  String lastLoginAt;
  String lastLoginIp;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  int id;

  UserInfo(
      {this.name,
      this.company,
      this.email,
      this.slug,
      this.phone,
      this.tourStatus,
      this.districtId,
      this.cityId,
      this.address,
      this.postcode,
      this.vatNumber,
      this.vatId,
      this.billingName,
      this.billingCountry,
      this.billingZip,
      this.billingCity,
      this.billingAddress,
      this.billingPostcode,
      this.extraBillingInformation,
      this.type,
      this.referredBy,
      this.balance,
      this.notificationsFrequency,
      this.subscribed,
      this.approved,
      this.password,
      this.rememberToken,
      this.lastReadAnnouncementsAt,
      this.lastLoginAt,
      this.lastLoginIp,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.id});

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    company = json['company'];
    email = json['email'];
    slug = json['slug'];
    phone = json['phone'];
    tourStatus = json['tour_status'];
    districtId = json['district_id'];
    cityId = json['city_id'];
    address = json['address'];
    postcode = json['postcode'];
    vatNumber = json['vat_number'];
    vatId = json['vat_id'];
    billingName = json['billing_name'];
    billingCountry = json['billing_country'];
    billingZip = json['billing_zip'];
    billingCity = json['billing_city'];
    billingAddress = json['billing_address'];
    billingPostcode = json['billing_postcode'];
    extraBillingInformation = json['extra_billing_information'];
    type = json['type'];
    referredBy = json['referred_by'];
    balance = json['balance'];
    notificationsFrequency = json['notifications_frequency'];
    subscribed = json['subscribed'];
    approved = json['approved'];
    password = json['password'];
    rememberToken = json['remember_token'];
    lastReadAnnouncementsAt = json['last_read_announcements_at'];
    lastLoginAt = json['last_login_at'];
    lastLoginIp = json['last_login_ip'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['company'] = this.company;
    data['email'] = this.email;
    data['slug'] = this.slug;
    data['phone'] = this.phone;
    data['tour_status'] = this.tourStatus;
    data['district_id'] = this.districtId;
    data['city_id'] = this.cityId;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['vat_number'] = this.vatNumber;
    data['vat_id'] = this.vatId;
    data['billing_name'] = this.billingName;
    data['billing_country'] = this.billingCountry;
    data['billing_zip'] = this.billingZip;
    data['billing_city'] = this.billingCity;
    data['billing_address'] = this.billingAddress;
    data['billing_postcode'] = this.billingPostcode;
    data['extra_billing_information'] = this.extraBillingInformation;
    data['type'] = this.type;
    data['referred_by'] = this.referredBy;
    data['balance'] = this.balance;
    data['notifications_frequency'] = this.notificationsFrequency;
    data['subscribed'] = this.subscribed;
    data['approved'] = this.approved;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
    data['last_read_announcements_at'] = this.lastReadAnnouncementsAt;
    data['last_login_at'] = this.lastLoginAt;
    data['last_login_ip'] = this.lastLoginIp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['id'] = this.id;
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

class Links {
  String first;
  String last;
  Null prev;
  Null next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Links> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({this.currentPage, this.from, this.lastPage, this.links, this.path, this.perPage, this.to, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
