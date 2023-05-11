import 'dart:convert';

AssignedOrdersModel assignedOrdersModelFromJson(String str) => AssignedOrdersModel.fromJson(json.decode(str));

String assignedOrdersModelToJson(AssignedOrdersModel data) => json.encode(data.toJson());

class AssignedOrdersModel {
  bool? success;
  AssignedOrdersResult? result;
  String? message;

  AssignedOrdersModel({
    this.success,
    this.result,
    this.message,
  });

  factory AssignedOrdersModel.fromJson(Map<String, dynamic> json) => AssignedOrdersModel(
    success: json["success"],
    result: AssignedOrdersResult.fromJson(json["result"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result!.toJson(),
    "message": message,
  };
}

class AssignedOrdersResult {
  Item? item;
  Services? services;

  AssignedOrdersResult({
    this.item,
    this.services,
  });

  factory AssignedOrdersResult.fromJson(Map<String, dynamic> json) => AssignedOrdersResult(
    item: Item.fromJson(json["item"]),
    services: Services.fromJson(json["services"]),
  );

  Map<String, dynamic> toJson() => {
    "item": item!.toJson(),
    "services": services!.toJson(),
  };
}

class Item {
  List<String>? technicianId;
  List<String>? checklist;
  List<String>? attachment;
  List<String>? notes;
  dynamic serviceStatus;
  String? id;
  ServiceId? serviceId;
  String? taskTitle;
  String? category;
  DateTime? startTime;
  DateTime? endTime;
  String? location;
  String? latitude;
  String? longitude;
  UserId? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Item({
    this.technicianId,
    this.checklist,
    this.attachment,
    this.notes,
    this.serviceStatus,
    this.id,
    this.serviceId,
    this.taskTitle,
    this.category,
    this.startTime,
    this.endTime,
    this.location,
    this.latitude,
    this.longitude,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    technicianId: List<String>.from(json["Technician_id"].map((x) => x)),
    checklist: List<String>.from(json["Checklist"].map((x) => x)),
    attachment: List<String>.from(json["Attachment"].map((x) => x)),
    notes: List<String>.from(json["Notes"].map((x) => x)),
    serviceStatus: json["service_status"],
    id: json["_id"],
    serviceId: ServiceId.fromJson(json["Service_id"]),
    taskTitle: json["Task_Title"],
    category: json["Category"],
    startTime: DateTime.parse(json["Start_Time"]),
    endTime: DateTime.parse(json["End_Time"]),
    location: json["Location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    userId: UserId.fromJson(json["User_id"]),
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
    "Task_Title": taskTitle,
    "Category": category,
    "Start_Time": startTime!.toIso8601String(),
    "End_Time": endTime!.toIso8601String(),
    "Location": location,
    "latitude": latitude,
    "longitude": longitude,
    "User_id": userId!.toJson(),
  "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}

class ServiceId {
  dynamic serviceStatus;
  String? id;
  String? serviceId;
  dynamic date;
  String? name;
  String? address;
  String? city;
  String? zip;
  String? latitude;
  String? longitude;
  dynamic amount;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ServiceId({
    this.serviceStatus,
    this.id,
    this.serviceId,
    this.date,
    this.name,
    this.address,
    this.city,
    this.zip,
    this.latitude,
    this.longitude,
    this.amount,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceId.fromJson(Map<String, dynamic> json) => ServiceId(
    serviceStatus: json["service_status"],
    id: json["_id"],
    serviceId: json["Service_id"],
    date: json["Date"],
    name: json["Name"],
    address: json["Address"],
    city: json["city"],
    zip: json["zip"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    amount: json["Amount"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "service_status": serviceStatus,
    "_id": id,
    "Service_id": serviceId,
    "Date": date,
    "Name": name,
    "Address": address,
    "city": city,
    "zip": zip,
    "latitude": latitude,
    "longitude": longitude,
    "Amount": amount,
    "user_id": userId,
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
  String? phone;
  String? gmailOtp;
  String? verification;
  List<dynamic>? addressDefault;
  List<dynamic>? addressHome;
  List<dynamic>? addressOther;
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
    this.phone,
    this.gmailOtp,
    this.verification,
    this.addressDefault,
    this.addressHome,
    this.addressOther,
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
    phone: json["phone"],
    gmailOtp: json["gmail_otp"],
    verification: json["verification"],
    addressDefault: List<dynamic>.from(json["addressDefault"].map((x) => x)),
    addressHome: List<dynamic>.from(json["addressHome"].map((x) => x)),
    addressOther: List<dynamic>.from(json["addressOther"].map((x) => x)),
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
    "phone": phone,
    "gmail_otp": gmailOtp,
    "verification": verification,
    "addressDefault": List<dynamic>.from(addressDefault!.map((x) => x)),
    "addressHome": List<dynamic>.from(addressHome!.map((x) => x)),
    "addressOther": List<dynamic>.from(addressOther!.map((x) => x)),
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "address": address,
    "pincode": pincode,
  };
}

class Services {
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

  Services({
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

  factory Services.fromJson(Map<String, dynamic> json) => Services(
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
