// To parse this JSON data, do
//
//     final mobileappgetsubcategoryModel = mobileappgetsubcategoryModelFromJson(jsonString);

import 'dart:convert';

MobileappgetsubcategoryModel mobileappgetsubcategoryModelFromJson(String str) =>
    MobileappgetsubcategoryModel.fromJson(json.decode(str));

class MobileappgetsubcategoryModel {
  bool success;
  String message;
  List<Subcategorylist> payload;

  MobileappgetsubcategoryModel({
    required this.success,
    required this.message,
    required this.payload,
  });

  factory MobileappgetsubcategoryModel.fromJson(Map<String, dynamic> json) =>
      MobileappgetsubcategoryModel(
        success: json["success"],
        message: json["message"],
        payload: List<Subcategorylist>.from(
            json["payload"].map((x) => Subcategorylist.fromJson(x))),
      );
}

class Subcategorylist {
  String? internalId;
  String? name;

  Subcategorylist({this.internalId, this.name});

  factory Subcategorylist.fromJson(Map<String, dynamic> json) => Subcategorylist(
        internalId: json["internalId"],
        name: json["name"],
      );
}