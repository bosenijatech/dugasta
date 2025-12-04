// To parse this JSON data, do
//
//     final mobileappgetprojectModel = mobileappgetprojectModelFromJson(jsonString);

import 'dart:convert';

MobileappgetprojectModel mobileappgetprojectModelFromJson(String str) => MobileappgetprojectModel.fromJson(json.decode(str));

String mobileappgetprojectModelToJson(MobileappgetprojectModel data) => json.encode(data.toJson());

class MobileappgetprojectModel {
    bool success;
    String message;
    List<ProjectList> payload;

    MobileappgetprojectModel({
        required this.success,
        required this.message,
        required this.payload,
    });

    factory MobileappgetprojectModel.fromJson(Map<String, dynamic> json) => MobileappgetprojectModel(
        success: json["success"],
        message: json["message"],
        payload: List<ProjectList>.from(json["payload"].map((x) => ProjectList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
    };
}

class ProjectList {
    String? value;
    String? text;

    ProjectList({
        required this.value,
        required this.text,
    });

    factory ProjectList.fromJson(Map<String, dynamic> json) => ProjectList(
        value: json["value"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "text": text,
    };
}
