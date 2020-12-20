class AuthError {
  String message;
  AuthErrors errors;

  AuthError({this.message, this.errors});

  AuthError.fromJson(Map<String, dynamic> json) {
    print('message: ${json['message']}');
    message = json['message'];
    errors = json['errors'] != null ? AuthErrors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }
}

class AuthErrors {
  List<String> name;
  List<String> email;
  List<String> phone;
  List<String> password;
  List<String> type;
  List<String> company;
  List<String> districtId;
  List<String> city;
  List<String> address;
  List<String> postcode;

  AuthErrors({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.type,
    this.company,
    this.districtId,
    this.city,
    this.address,
    this.postcode,
  });

  AuthErrors.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? json['name'].cast<String>() : [];
    email = json['email'] != null ? json['email'].cast<String>() : [];
    phone = json['phone'] != null ? json['phone'].cast<String>() : [];
    password = json['password'] != null ? json['password'].cast<String>() : [];
    type = json['type'] != null ? json['type'].cast<String>() : [];
    company = json['company'] != null ? json['company'].cast<String>() : [];
    districtId = json['distric_id'] != null ? json['distric_id'].cast<String>() : [];
    city = json['city'] != null ? json['city'].cast<String>() : [];
    address = json['address'] != null ? json['address'].cast<String>() : [];
    postcode = json['postcode'] != null ? json['postcode'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['type'] = this.type;
    data['company'] = this.company;
    data['distric_id'] = this.districtId;
    data['city'] = this.city;
    data['address'] = this.city;
    data['postcode'] = this.postcode;
    return data;
  }
}
