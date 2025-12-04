// To parse this JSON data, do
//
//     final mobileappgetypeModel = mobileappgetypeModelFromJson(jsonString);

import 'dart:convert';

MobileappgetypeModel mobileappgetypeModelFromJson(String str) => MobileappgetypeModel.fromJson(json.decode(str));

String mobileappgetypeModelToJson(MobileappgetypeModel data) => json.encode(data.toJson());

class MobileappgetypeModel {
    bool status;
    String message;
    List<Typelist> payload;

    MobileappgetypeModel({
        required this.status,
        required this.message,
        required this.payload,
    });

    factory MobileappgetypeModel.fromJson(Map<String, dynamic> json) => MobileappgetypeModel(
        status: json["status"],
        message: json["message"],
        payload: List<Typelist>.from(json["payload"].map((x) => Typelist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
    };
}

class Typelist {
    int? internalId;
    String? name;

    Typelist({
         this.internalId,
         this.name,
    });

    factory Typelist.fromJson(Map<String, dynamic> json) => Typelist(
        internalId: json["internalId"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "internalId": internalId,
        "Name": name,
    };
}
