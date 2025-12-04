// To parse this JSON data, do
//
//     final mobileappgetcategoryModel = mobileappgetcategoryModelFromJson(jsonString);

import 'dart:convert';


MobileappgetcategoryModel mobileappgetcategoryModelFromJson(String str) =>
    MobileappgetcategoryModel.fromJson(json.decode(str));

String mobileappgetcategoryModelToJson(MobileappgetcategoryModel data) =>
    json.encode(data.toJson());

class MobileappgetcategoryModel {
  bool success;
  String message;
  List<Categorylist> payload;

  MobileappgetcategoryModel({
    required this.success,
    required this.message,
    required this.payload,
  });

  factory MobileappgetcategoryModel.fromJson(Map<String, dynamic> json) =>
      MobileappgetcategoryModel(
        success: json["success"],
        message: json["message"],
        payload: List<Categorylist>.from(
            json["payload"].map((x) => Categorylist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
      };
}

class Categorylist {
  String internalId;
  String name;

  Categorylist({
    required this.internalId,
    required this.name,
  });

  factory Categorylist.fromJson(Map<String, dynamic> json) => Categorylist(
        internalId: json["internalId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "internalId": internalId,
        "name": name,
      };
}
