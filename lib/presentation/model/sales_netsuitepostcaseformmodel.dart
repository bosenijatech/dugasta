// To parse this JSON data, do
//
//     final netsuitepostcaseformmodel = netsuitepostcaseformmodelFromJson(jsonString);

import 'dart:convert';

Netsuitepostcaseformmodel netsuitepostcaseformmodelFromJson(String str) => Netsuitepostcaseformmodel.fromJson(json.decode(str));

String netsuitepostcaseformmodelToJson(Netsuitepostcaseformmodel data) => json.encode(data.toJson());

class Netsuitepostcaseformmodel {
    bool success;
    String message;
    int caseId;

    Netsuitepostcaseformmodel({
        required this.success,
        required this.message,
        required this.caseId,
    });

    factory Netsuitepostcaseformmodel.fromJson(Map<String, dynamic> json) => Netsuitepostcaseformmodel(
        success: json["success"],
        message: json["message"],
        caseId: json["caseId"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "caseId": caseId,
    };
}
