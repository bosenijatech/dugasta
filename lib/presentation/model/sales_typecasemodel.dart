// To parse this JSON data, do
//
//     final mobileappgetypecaseModel = mobileappgetypecaseModelFromJson(jsonString);

import 'dart:convert';

MobileappgetypecaseModel mobileappgetypecaseModelFromJson(String str) => MobileappgetypecaseModel.fromJson(json.decode(str));

String mobileappgetypecaseModelToJson(MobileappgetypecaseModel data) => json.encode(data.toJson());

class MobileappgetypecaseModel {
    bool success;
    String message;
    List<typecaselist> payload;

    MobileappgetypecaseModel({
        required this.success,
        required this.message,
        required this.payload,
    });

    factory MobileappgetypecaseModel.fromJson(Map<String, dynamic> json) => MobileappgetypecaseModel(
        success: json["success"],
        message: json["message"],
        payload: List<typecaselist>.from(json["payload"].map((x) => typecaselist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
    };
}

class typecaselist {
    String? internalId;
    String? name;

    typecaselist({
        required this.internalId,
        required this.name,
    });

    factory typecaselist.fromJson(Map<String, dynamic> json) => typecaselist(
        internalId: json["internalId"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "internalId": internalId,
        "name": name,
    };
}
