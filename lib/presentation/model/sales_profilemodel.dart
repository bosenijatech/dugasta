// To parse this JSON data, do
//
//     final salesprofileModel = salesprofileModelFromJson(jsonString);

import 'dart:convert';

SalesprofileModel salesprofileModelFromJson(String str) => SalesprofileModel.fromJson(json.decode(str));

String salesprofileModelToJson(SalesprofileModel data) => json.encode(data.toJson());

class SalesprofileModel {
    bool status;
    String message;
    List<ProfileList> data;

    SalesprofileModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory SalesprofileModel.fromJson(Map<String, dynamic> json) => SalesprofileModel(
        status: json["status"],
        message: json["message"],
        data: List<ProfileList>.from(json["data"].map((x) => ProfileList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ProfileList {
    String? id;
    String? internalId;
    int? v;
    String? customerId;
    String? email;
    String? firstName;
    String? isactive;
    String? lastName;
    String? password;
    String? phone;
    String? subsidiary;
    String? active;
    String? companyName;
    String? customerType;

    ProfileList({
         this.id,
         this.internalId,
         this.v,
         this.customerId,
         this.email,
         this.firstName,
         this.isactive,
         this.lastName,
         this.password,
         this.phone,
         this.subsidiary,
         this.active,
         this.companyName,
         this.customerType,
    });

    factory ProfileList.fromJson(Map<String, dynamic> json) => ProfileList(
        id: json["_id"],
        internalId: json["internalId"],
        v: json["__v"],
        customerId: json["customerId"],
        email: json["email"],
        firstName: json["firstName"],
        isactive: json["isactive"],
        lastName: json["lastName"],
        password: json["password"],
        phone: json["phone"],
        subsidiary: json["subsidiary"],
        active: json["active"],
        companyName: json["companyName"],
        customerType: json["customerType"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "internalId": internalId,
        "__v": v,
        "customerId": customerId,
        "email": email,
        "firstName": firstName,
        "isactive": isactive,
        "lastName": lastName,
        "password": password,
        "phone": phone,
        "subsidiary": subsidiary,
        "active": active,
        "companyName": companyName,
        "customerType": customerType,
    };
}
