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
  String? id;
  List<String>? checklist;
  List<String>? attachment;
  List<String>? notes;
  String? taskTitle;
  dynamic startTime;
  dynamic endTime;
  String? location;
  String? latitude;
  String? longitude;
  Complaints? complaints;
  Services? services;
  Users? users;

  AssignedOrdersResult({
    this.id,
    this.checklist,
    this.attachment,
    this.notes,
    this.taskTitle,
    this.startTime,
    this.endTime,
    this.location,
    this.latitude,
    this.longitude,
    this.complaints,
    this.services,
    this.users,
  });

  factory AssignedOrdersResult.fromJson(Map<String, dynamic> json) => AssignedOrdersResult(
    id: json["_id"],
    checklist: List<String>.from(json["Checklist"].map((x) => x)),
    attachment: List<String>.from(json["Attachment"].map((x) => x)),
    notes: List<String>.from(json["Notes"].map((x) => x)),
    taskTitle: json["Task_Title"],
    startTime: json["Start_Time"],
    endTime: json["End_Time"],
    location: json["Location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    complaints: Complaints.fromJson(json["complaints"]),
    services: Services.fromJson(json["services"]),
    users: Users.fromJson(json["users"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Checklist": List<dynamic>.from(checklist!.map((x) => x)),
    "Attachment": List<dynamic>.from(attachment!.map((x) => x)),
    "Notes": List<dynamic>.from(notes!.map((x) => x)),
    "Task_Title": taskTitle,
    "Start_Time": startTime!,
    "End_Time": endTime!,
    "Location": location,
    "latitude": latitude,
    "longitude": longitude,
    "complaints": complaints!.toJson(),
    "services": services!.toJson(),
    "users": users!.toJson(),
  };
}

class Complaints {
  String? id;
  dynamic serviceStatus;
  String? serviceId;
  dynamic date;
  String? address;
  String? city;
  String? zip;
  String? latitude;
  String? longitude;
  dynamic amount;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Complaints({
    this.id,
    this.serviceStatus,
    this.serviceId,
    this.date,
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

  factory Complaints.fromJson(Map<String, dynamic> json) => Complaints(
    id: json["_id"],
    serviceStatus: json["service_status"],
    serviceId: json["Service_id"],
    date: json["Date"],
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
    "_id": id,
    "service_status": serviceStatus,
    "Service_id": serviceId,
    "Date": date,
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

class Services {
  String? id;
  List<String>? checkList;
  List<String>? coverImage;
  String? serviceName;
  String? category;
  dynamic amount;
  String? time;
  String? notes;
  dynamic rattings;
  DateTime? createdAt;
  DateTime? updatedAt;

  Services({
    this.id,
    this.checkList,
    this.coverImage,
    this.serviceName,
    this.category,
    this.amount,
    this.time,
    this.notes,
    this.rattings,
    this.createdAt,
    this.updatedAt,
  });

  factory Services.fromJson(Map<String, dynamic> json) => Services(
    id: json["_id"],
    checkList: List<String>.from(json["Check_List"].map((x) => x)),
    coverImage: List<String>.from(json["Cover_Image"].map((x) => x)),
    serviceName: json["Service_Name"],
    category: json["Category"],
    amount: json["Amount"],
    time: json["Time"],
    notes: json["Notes"],
    rattings: json["Rattings"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Check_List": List<dynamic>.from(checkList!.map((x) => x)),
    "Cover_Image": List<dynamic>.from(coverImage!.map((x) => x)),
    "Service_Name": serviceName,
    "Category": category,
    "Amount": amount,
    "Time": time,
    "Notes": notes,
    "Rattings": rattings,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}

class Users {
  String? name;
  String? phone;

  Users({
    this.name,
    this.phone,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
  };
}
