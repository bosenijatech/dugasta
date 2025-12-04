// To parse this JSON data, do
//
//     final feedbackgetlevelmodel = feedbackgetlevelmodelFromJson(jsonString);

import 'dart:convert';

Feedbackgetlevelmodel feedbackgetlevelmodelFromJson(String str) => Feedbackgetlevelmodel.fromJson(json.decode(str));

String feedbackgetlevelmodelToJson(Feedbackgetlevelmodel data) => json.encode(data.toJson());

class Feedbackgetlevelmodel {
    bool success;
    String message;
    List<levellist> payload;

    Feedbackgetlevelmodel({
        required this.success,
        required this.message,
        required this.payload,
    });

    factory Feedbackgetlevelmodel.fromJson(Map<String, dynamic> json) => Feedbackgetlevelmodel(
        success: json["success"],
        message: json["message"],
        payload: List<levellist>.from(json["payload"].map((x) => levellist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "payload": List<dynamic>.from(payload.map((x) => x.toJson())),
    };
}

class levellist {
    String? internalId;
    String? name;

    levellist({
         this.internalId,
         this.name,
    });

    factory levellist.fromJson(Map<String, dynamic> json) => levellist(
        internalId: json["internalId"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "internalId": internalId,
        "name": name,
    };
}
