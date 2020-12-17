import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool success;
  Data data;

  UserModel({
    this.success,
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  String token;
  UserDetails userDetails;

  Data({
    this.token,
    this.userDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"] == null ? null : json["token"],
        userDetails: json["userDetails"] == null ? null : UserDetails.fromJson(json["userDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "userDetails": userDetails == null ? null : userDetails.toJson(),
      };
}

class UserDetails {
  int id;
  String firstName;
  String lastName;
  dynamic company;
  dynamic vat;
  String username;
  String email;
  dynamic phone;
  dynamic districtId;
  dynamic cityId;
  String address;
  dynamic postalCode;
  dynamic emailVerifiedAt;
  dynamic referrerId;
  dynamic avatar;
  bool newsletter;
  bool notifyByEmail;
  dynamic lastLoginAt;
  dynamic lastLoginIp;
  dynamic bannedUntil;
  dynamic approvedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic salesman;
  dynamic deletedAt;
  String name;
  String referralLink;

  UserDetails({
    this.id,
    this.firstName,
    this.lastName,
    this.company,
    this.vat,
    this.username,
    this.email,
    this.phone,
    this.districtId,
    this.cityId,
    this.address,
    this.postalCode,
    this.emailVerifiedAt,
    this.referrerId,
    this.avatar,
    this.newsletter,
    this.notifyByEmail,
    this.lastLoginAt,
    this.lastLoginIp,
    this.bannedUntil,
    this.approvedAt,
    this.createdAt,
    this.updatedAt,
    this.salesman,
    this.deletedAt,
    this.name,
    this.referralLink,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        company: json["company"],
        vat: json["vat"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"],
        districtId: json["district_id"],
        cityId: json["city_id"],
        address: json["address"] == null ? null : json["address"],
        postalCode: json["postal_code"],
        emailVerifiedAt: json["email_verified_at"],
        referrerId: json["referrer_id"],
        avatar: json["avatar"],
        newsletter: json["newsletter"] == null ? null : json["newsletter"],
        notifyByEmail: json["notify_by_email"] == null ? null : json["notify_by_email"],
        lastLoginAt: json["last_login_at"],
        lastLoginIp: json["last_login_ip"],
        bannedUntil: json["banned_until"],
        approvedAt: json["approved_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        salesman: json["salesman"],
        deletedAt: json["deleted_at"],
        name: json["name"] == null ? null : json["name"],
        referralLink: json["referral_link"] == null ? null : json["referral_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "company": company,
        "vat": vat,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "phone": phone,
        "district_id": districtId,
        "city_id": cityId,
        "address": address == null ? null : address,
        "postal_code": postalCode,
        "email_verified_at": emailVerifiedAt,
        "referrer_id": referrerId,
        "avatar": avatar,
        "newsletter": newsletter == null ? null : newsletter,
        "notify_by_email": notifyByEmail == null ? null : notifyByEmail,
        "last_login_at": lastLoginAt,
        "last_login_ip": lastLoginIp,
        "banned_until": bannedUntil,
        "approved_at": approvedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "salesman": salesman,
        "deleted_at": deletedAt,
        "name": name == null ? null : name,
        "referral_link": referralLink == null ? null : referralLink,
      };
}
