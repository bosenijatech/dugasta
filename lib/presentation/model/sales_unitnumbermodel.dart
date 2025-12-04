// To parse this JSON data, do
//
//     final mobileappgetunitnumberModel = mobileappgetunitnumberModelFromJson(jsonString);

import 'dart:convert';

MobileappgetunitnumberModel mobileappgetunitnumberModelFromJson(String str) => MobileappgetunitnumberModel.fromJson(json.decode(str));

String mobileappgetunitnumberModelToJson(MobileappgetunitnumberModel data) => json.encode(data.toJson());

class MobileappgetunitnumberModel {
    bool success;
    String message;
    List<Unitnumlist> payload;

    MobileappgetunitnumberModel({
        required this.success,
        required this.message,
        required this.payload,
    });

    factory MobileappgetunitnumberModel.fromJson(Map<String, dynamic> json) => MobileappgetunitnumberModel(
        success: json["success"],
        message: json["message"],
        payload: List<Unitnumlist>.from(json["payload"].map((x) => Unitnumlist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
    };
}

class Unitnumlist {
    String? value;
    String? text;

    Unitnumlist({
         this.value,
         this.text,
    });

    factory Unitnumlist.fromJson(Map<String, dynamic> json) => Unitnumlist(
        value: json["value"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "text": text,
    };
}
