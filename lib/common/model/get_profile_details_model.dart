import 'dart:convert';

GetProfileDetailsModel getProfileDetailsModelFromJson(String str) => GetProfileDetailsModel.fromJson(json.decode(str));

String getProfileDetailsModelToJson(GetProfileDetailsModel data) => json.encode(data.toJson());

class GetProfileDetailsModel {
  bool? success;
  GetProfileResult? result;
  String? message;

  GetProfileDetailsModel({
    this.success,
    this.result,
    this.message,
  });

  factory GetProfileDetailsModel.fromJson(Map<String, dynamic> json) => GetProfileDetailsModel(
    success: json["success"],
    result: GetProfileResult.fromJson(json["result"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result!.toJson(),
    "message": message,
  };
}

class GetProfileResult {
  String? profilePic;
  String? phone;
  dynamic addressDefault;
  dynamic addressHome;
  List<dynamic>? addressOther;
  String? id;
  String? name;
  String? email;

  GetProfileResult({
    this.profilePic,
    this.phone,
    this.addressDefault,
    this.addressHome,
    this.addressOther,
    this.id,
    this.name,
    this.email,
  });

  factory GetProfileResult.fromJson(Map<String, dynamic> json) => GetProfileResult(
    profilePic: json["profile_pic"],
    phone: json["phone"],
    addressDefault: json["addressDefault"],
    addressHome: json["addressHome"],
    addressOther: List<dynamic>.from(json["addressOther"].map((x) => x)),
    id: json["_id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "profile_pic": profilePic,
    "phone": phone,
    "addressDefault": addressDefault,
    "addressHome": addressHome,
    "addressOther": List<dynamic>.from(addressOther!.map((x) => x)),
    "_id": id,
    "name": name,
    "email": email,
  };
}
