import 'dart:convert';

GetProfileDetailsModel getProfileDetailsModelFromJson(String str) => GetProfileDetailsModel.fromJson(json.decode(str));

String getProfileDetailsModelToJson(GetProfileDetailsModel data) => json.encode(data.toJson());

class GetProfileDetailsModel {
  bool? success;
  GetProfileResult? result;
  dynamic message;

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
  String? id;
  String? name;
  String? email;
  String? profile_pic;
  String? phone;

  GetProfileResult({
    this.id,
    this.name,
    this.email,
    this.profile_pic,
    this.phone,
  });

  factory GetProfileResult.fromJson(Map<String, dynamic> json) => GetProfileResult(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    profile_pic: json["profile_pic"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "email": profile_pic,
    "phone": phone,
  };
}
