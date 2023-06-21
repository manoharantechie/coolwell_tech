import 'dart:convert';

OrderCompleteModel orderCompleteModelFromJson(String str) => OrderCompleteModel.fromJson(json.decode(str));

String orderCompleteModelToJson(OrderCompleteModel data) => json.encode(data.toJson());

class OrderCompleteModel {
  bool? success;
  String? message;
  OrderCompleteResult? result;

  OrderCompleteModel({
    this.success,
    this.message,
    this.result,
  });

  factory OrderCompleteModel.fromJson(Map<String, dynamic> json) => OrderCompleteModel(
    success: json["success"],
    message: json["message"],
    result: OrderCompleteResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result!.toJson(),
  };
}

class OrderCompleteResult {
  dynamic serviceStatus;
  String? id;
  ComplaintId? complaintId;
  String? technicianId;
  dynamic startTime;
  dynamic endTime;
  String? taskTitle;
  String? category;
  String? longitude;
  String? latitude;
  String? location;
  UserId? userId;
  dynamic createdAt;
  dynamic updatedAt;

  OrderCompleteResult({
    this.serviceStatus,
    this.id,
    this.complaintId,
    this.technicianId,
    this.startTime,
    this.endTime,
    this.taskTitle,
    this.category,
    this.longitude,
    this.latitude,
    this.location,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderCompleteResult.fromJson(Map<String, dynamic> json) => OrderCompleteResult(
    serviceStatus: json["service_status"],
    id: json["_id"],
    complaintId: ComplaintId.fromJson(json["Complaint_id"]),
    technicianId: json["Technician_id"],
    startTime: json["Start_Time"],
    endTime: json["End_Time"],
    taskTitle: json["Task_Title"],
    category: json["Category"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    location: json["Location"],
    userId: UserId.fromJson(json["User_id"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "service_status": serviceStatus,
    "_id": id,
    "Complaint_id": complaintId!.toJson(),
    "Technician_id": technicianId,
    "Start_Time": startTime,
    "End_Time": endTime,
    "Task_Title": taskTitle,
    "Category": category,
    "longitude": longitude,
    "latitude": latitude,
    "Location": location,
    "User_id": userId!.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class ComplaintId {
  String? id;
  String? address;
  String? city;
  String? zip;
  String? latitude;
  String? longitude;

  ComplaintId({
    this.id,
    this.address,
    this.city,
    this.zip,
    this.latitude,
    this.longitude,
  });

  factory ComplaintId.fromJson(Map<String, dynamic> json) => ComplaintId(
    id: json["_id"],
    address: json["Address"],
    city: json["city"],
    zip: json["zip"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Address": address,
    "city": city,
    "zip": zip,
    "latitude": latitude,
    "longitude": longitude,
  };
}

class UserId {
  String? id;
  String? name;

  UserId({
    this.id,
    this.name,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
