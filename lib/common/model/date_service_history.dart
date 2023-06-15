import 'dart:convert';

DateServiceHistoryModel dateServiceHistoryModelFromJson(String str) => DateServiceHistoryModel.fromJson(json.decode(str));

String dateServiceHistoryModelToJson(DateServiceHistoryModel data) => json.encode(data.toJson());

class DateServiceHistoryModel {
  bool? success;
  List<DateServiceResult>? result;
  String? message;

  DateServiceHistoryModel({
    this.success,
    this.result,
    this.message,
  });

  factory DateServiceHistoryModel.fromJson(Map<String, dynamic> json) => DateServiceHistoryModel(
    success: json["success"],
    result: List<DateServiceResult>.from(json["result"].map((x) => DateServiceResult.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
  };
}

class DateServiceResult {
  String? id;
  dynamic startTime;
  dynamic endTime;
  Services? services;

  DateServiceResult({
    this.id,
    this.startTime,
    this.endTime,
    this.services,
  });

  factory DateServiceResult.fromJson(Map<String, dynamic> json) => DateServiceResult(
    id: json["_id"],
    startTime: json["Start_Time"],
    endTime: json["End_Time"],
    services: Services.fromJson(json["services"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Start_Time": startTime,
    "End_Time": endTime,
    "services": services!.toJson(),
  };
}

class Services {
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
