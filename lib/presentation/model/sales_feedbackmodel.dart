// To parse this JSON data, do
//
//     final feedbackmodel = feedbackmodelFromJson(jsonString);

import 'dart:convert';

Feedbackmodel feedbackmodelFromJson(String str) => Feedbackmodel.fromJson(json.decode(str));

String feedbackmodelToJson(Feedbackmodel data) => json.encode(data.toJson());

class Feedbackmodel {
    bool success;
    String message;

    Feedbackmodel({
        required this.success,
        required this.message,
    });

    factory Feedbackmodel.fromJson(Map<String, dynamic> json) => Feedbackmodel(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}
