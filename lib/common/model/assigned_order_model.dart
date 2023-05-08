import 'dart:convert';

AssignedOrdersModel assignedOrdersModelFromJson(String str) => AssignedOrdersModel.fromJson(json.decode(str));

String assignedOrdersModelToJson(AssignedOrdersModel data) => json.encode(data.toJson());

class AssignedOrdersModel {
  bool? success;
  List<AssignedOrdersResult>? result;
  String? message;

  AssignedOrdersModel({
    this.success,
    this.result,
    this.message,
  });

  factory AssignedOrdersModel.fromJson(Map<String, dynamic> json) => AssignedOrdersModel(
    success: json["success"],
    result: List<AssignedOrdersResult>.from(json["result"].map((x) => AssignedOrdersResult.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
  };
}

class AssignedOrdersResult {
  List<String>? technicianId;
  List<String>? checklist;
  List<String>? attachment;
  List<String>? notes;
  dynamic serviceStatus;
  String? id;
  ServiceId? serviceId;
  UserId? userId;
  String? taskTitle;
  String? category;
  DateTime? startTime;
  DateTime? endTime;
  String? location;
  String? latitude;
  String? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;

  AssignedOrdersResult({
    this.technicianId,
    this.checklist,
    this.attachment,
    this.notes,
    this.serviceStatus,
    this.id,
    this.serviceId,
    this.userId,
    this.taskTitle,
    this.category,
    this.startTime,
    this.endTime,
    this.location,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory AssignedOrdersResult.fromJson(Map<String, dynamic> json) => AssignedOrdersResult(
    technicianId: List<String>.from(json["Technician_id"].map((x) => x)),
    checklist: List<String>.from(json["Checklist"].map((x) => x)),
    attachment: List<String>.from(json["Attachment"].map((x) => x)),
    notes: List<String>.from(json["Notes"].map((x) => x)),
    serviceStatus: json["service_status"],
    id: json["_id"],
    serviceId: ServiceId.fromJson(json["Service_id"]),
    userId: UserId.fromJson(json["User_id"]),
    taskTitle: json["Task_Title"],
    category: json["Category"],
    startTime: DateTime.parse(json["Start_Time"]),
    endTime: DateTime.parse(json["End_Time"]),
    location: json["Location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "Technician_id": List<dynamic>.from(technicianId!.map((x) => x)),
    "Checklist": List<dynamic>.from(checklist!.map((x) => x)),
    "Attachment": List<dynamic>.from(attachment!.map((x) => x)),
    "Notes": List<dynamic>.from(notes!.map((x) => x)),
    "service_status": serviceStatus,
    "_id": id,
    "Service_id": serviceId!.toJson(),
    "User_id": userId!.toJson(),
    "Task_Title": taskTitle,
    "Category": category,
    "Start_Time": startTime!.toIso8601String(),
    "End_Time": endTime!.toIso8601String(),
    "Location": location,
    "latitude": latitude,
    "longitude": longitude,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}

class ServiceId {
  List<String>? checkList;
  List<String>? coverImage;
  String? id;
  String? serviceName;
  String? category;
  String? amount;
  String? time;
  String? notes;
  DateTime? createdAt;
  DateTime? updatedAt;

  ServiceId({
    this.checkList,
    this.coverImage,
    this.id,
    this.serviceName,
    this.category,
    this.amount,
    this.time,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceId.fromJson(Map<String, dynamic> json) => ServiceId(
    checkList: List<String>.from(json["Check_List"].map((x) => x)),
    coverImage: List<String>.from(json["Cover_Image"].map((x) => x)),
    id: json["_id"],
    serviceName: json["Service_Name"],
    category: json["Category"],
    amount: json["Amount"],
    time: json["Time"],
    notes: json["Notes"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "Check_List": List<dynamic>.from(checkList!.map((x) => x)),
    "Cover_Image": List<dynamic>.from(coverImage!.map((x) => x)),
    "_id": id,
    "Service_Name": serviceName,
    "Category": category,
    "Amount": amount,
    "Time": time,
    "Notes": notes,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}

class UserId {
  dynamic techId;
  dynamic twofa;
  String? role;
  bool? verified;
  bool? google;
  bool? facebook;
  dynamic status;
  bool? gmailVerified;
  bool? phoneVerified;
  String? id;
  String? name;
  String? email;
  String? verification;
  String? city;
  String? country;
  String? phone;
  String? urlTwitter;
  String? urlGitHub;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address;
  String? pincode;

  UserId({
    this.techId,
    this.twofa,
    this.role,
    this.verified,
    this.google,
    this.facebook,
    this.status,
    this.gmailVerified,
    this.phoneVerified,
    this.id,
    this.name,
    this.email,
    this.verification,
    this.city,
    this.country,
    this.phone,
    this.urlTwitter,
    this.urlGitHub,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.pincode,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    techId: json["Tech_id"],
    twofa: json["twofa"],
    role: json["role"],
    verified: json["verified"],
    google: json["google"],
    facebook: json["facebook"],
    status: json["status"],
    gmailVerified: json["gmail_verified"],
    phoneVerified: json["phone_verified"],
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    verification: json["verification"],
    city: json["city"],
    country: json["country"],
    phone: json["phone"],
    urlTwitter: json["urlTwitter"],
    urlGitHub: json["urlGitHub"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    address: json["address"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "Tech_id": techId,
    "twofa": twofa,
    "role": role,
    "verified": verified,
    "google": google,
    "facebook": facebook,
    "status": status,
    "gmail_verified": gmailVerified,
    "phone_verified": phoneVerified,
    "_id": id,
    "name": name,
    "email": email,
    "verification": verification,
    "city": city,
    "country": country,
    "phone": phone,
    "urlTwitter": urlTwitter,
    "urlGitHub": urlGitHub,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "address": address,
    "pincode": pincode,
  };
}
