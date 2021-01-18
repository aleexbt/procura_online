class OrdersModel {
  List<Order> order;
  Links links;
  Meta meta;

  OrdersModel({this.order, this.links, this.meta});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      order = new List<Order>.empty(growable: true);
      json['data'].forEach((v) {
        order.add(new Order.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['data'] = this.order.map((v) => v.toJson()).toList();
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

class Order {
  int id;
  String userId;
  String make;
  String model;
  String year;
  String noteText;
  String numberOfDoors;
  String fuelType;
  String engineDisplacement;
  String mpn;
  UserInfo userInfo;
  String makeLogoUrl;
  String mediaCount;
  List<String> conversations;
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
      this.numberOfDoors,
      this.fuelType,
      this.engineDisplacement,
      this.mpn,
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
    numberOfDoors = json['number_of_doors'];
    fuelType = json['fuel_type'];
    engineDisplacement = json['engine_displacement'];
    mpn = json['mpn'];
    userInfo = json['user_info'] != null ? new UserInfo.fromJson(json['user_info']) : null;
    makeLogoUrl = json['make_logo_url'];
    mediaCount = json['media_count'];
    // if (json['conversations'] != null) {
    //   conversations = new List<Null>();
    //   json['conversations'].forEach((v) {
    //     conversations.add(new Null.fromJson(v));
    //   });
    // }
    if (json['media'] != null) {
      media = new List<Media>.empty(growable: true);
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
    data['number_of_doors'] = this.numberOfDoors;
    data['fuel_type'] = this.fuelType;
    data['engine_displacement'] = this.engineDisplacement;
    data['mpn'] = this.mpn;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo.toJson();
    }
    data['make_logo_url'] = this.makeLogoUrl;
    data['media_count'] = this.mediaCount;
    // if (this.conversations != null) {
    //   data['conversations'] =
    //       this.conversations.map((v) => v.toJson()).toList();
    // }
    if (data['media'] != null) {
      media = new List<Media>.empty(growable: true);
      data['media'].forEach((v) {
        media.add(new Media.fromJson(v));
      });
    }
    data['seen'] = this.seen;
    data['human_read_date'] = this.humanReadDate;
    data['sold'] = this.sold;
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
  String vatId;
  String billingName;
  String billingCountry;
  String billingZip;
  String billingCity;
  String billingAddress;
  String billingPostcode;
  String extraBillingInformation;
  String type;
  String referredBy;
  String balance;
  String notificationsFrequency;
  String subscribed;
  String approved;
  String password;
  String rememberToken;
  String lastReadAnnouncementsAt;
  String lastLoginAt;
  String lastLoginIp;
  String createdAt;
  String updatedAt;
  String deletedAt;
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

class Links {
  String first;
  String last;
  String prev;
  String next;

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
      links = new List<Links>.empty(growable: true);
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
