import 'dart:convert';

GetAssignedJobsListModel getAssignedJobsListModelFromJson(String str) => GetAssignedJobsListModel.fromJson(json.decode(str));

String getAssignedJobsListModelToJson(GetAssignedJobsListModel data) => json.encode(data.toJson());

class GetAssignedJobsListModel {
  bool? success;
  List<GetAssignedJobsResult>? result;
  String? message;

  GetAssignedJobsListModel({
    this.success,
    this.result,
    this.message,
  });

  factory GetAssignedJobsListModel.fromJson(Map<String, dynamic> json) => GetAssignedJobsListModel(
    success: json["success"],
    result: List<GetAssignedJobsResult>.from(json["result"].map((x) => GetAssignedJobsResult.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
  };
}

class GetAssignedJobsResult {
  String? id;
  GetAssignedServices? services;

  GetAssignedJobsResult({
    this.id,
    this.services,
  });

  factory GetAssignedJobsResult.fromJson(Map<String, dynamic> json) => GetAssignedJobsResult(
    id: json["_id"],
    services: GetAssignedServices.fromJson(json["services"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "services": services!.toJson(),
  };
}

class GetAssignedServices {
  String? id;
  List<String>? checkList;
  List<String>? coverImage;
  String? serviceName;
  String? category;
  String? amount;
  String? time;
  String? notes;
  dynamic rattings;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetAssignedServices({
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

  factory GetAssignedServices.fromJson(Map<String, dynamic> json) => GetAssignedServices(
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
