// class LoginModel {
//   bool? status;
//   Message? message;
//   String? token;

//   LoginModel({this.status, this.message, this.token});

//   LoginModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message =
//         json['message'] != null ? Message.fromJson(json['message']) : null;
//     token = json['token'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (message != null) {
//       data['message'] = message!.toJson();
//     }
//     data['token'] = token;
//     return data;
//   }
// }

// class Message {
//   String? sId;
//   String? tenantid;
//   String? tenantFirstname;
//   String? tenantLastname;
//   String? tenantMobileno;
//   String? tenantEmail;
//   String? tenantUsername;
//   String? tenantPassword;
//   String? tenantPassportno;
//   String? tenantPassportexpdate;
//   String? tenantEmirtesid;
//   String? tenantEmirtesexpdate;
//   String? tenantimgurl;
//   String? source;

//   int? issync;
//   String? role;
//   String? active;
//   String? otp;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   var customerId;
//   var subsidiary;
//   var incharge;
//   String? customerName;
//   Message(
//       {this.sId,
//       this.tenantid,
//       this.tenantFirstname,
//       this.tenantLastname,
//       this.tenantMobileno,
//       this.tenantEmail,
//       this.tenantUsername,
//       this.tenantPassword,
//       this.tenantPassportno,
//       this.tenantPassportexpdate,
//       this.tenantEmirtesid,
//       this.tenantEmirtesexpdate,
//       this.tenantimgurl,
//       this.source,
//       this.issync,
//       this.role,
//       this.active,
//       this.otp,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.customerId,
//       this.subsidiary,
//       this.incharge,
//       this.customerName});

//   Message.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     tenantid = json['tenant_id'];
//     tenantFirstname = json['tenant_firstname'];
//     tenantLastname = json['tenant_lastname'];
//     tenantMobileno = json['tenant_mobileno'];
//     tenantEmail = json['tenant_email'];
//     tenantUsername = json['tenant_username'];
//     tenantPassword = json['tenant_password'];
//     tenantPassportno = json['tenant_passportno'];
//     tenantPassportexpdate = json['tenant_passportexpdate'];
//     tenantEmirtesid = json['tenant_emirtesid'];
//     tenantEmirtesexpdate = json['tenant_emirtesexpdate'];
//     tenantimgurl = json['tenantimgurl'];
//     source = json['source'];
//     issync = json['issync'];
//     role = json['role'];
//     active = json['active'];
//     otp = json['otp'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     customerId = json['customerId'];
//     subsidiary = json['subsidiary'];
//     incharge = json['maintenanceIncharge'];
//     customerName = json['customer_name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['tenantid'] = tenantid;
//     data['tenant_firstname'] = tenantFirstname;
//     data['tenant_lastname'] = tenantLastname;
//     data['tenant_mobileno'] = tenantMobileno;
//     data['tenant_email'] = tenantEmail;
//     data['tenant_username'] = tenantUsername;
//     data['tenant_password'] = tenantPassword;
//     data['tenant_passportno'] = tenantPassportno;
//     data['tenant_passportexpdate'] = tenantPassportexpdate;
//     data['tenant_emirtesid'] = tenantEmirtesid;
//     data['tenant_emirtesexpdate'] = tenantEmirtesexpdate;
//     data['tenantimgurl'] = tenantimgurl;
//     data['source'] = source;
//     data['issync'] = issync;
//     data['role'] = role;
//     data['active'] = active;
//     data['otp'] = otp;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     data['customerId'] = customerId;
//     data['subsidiary'] = subsidiary;
//     data['maintenanceIncharge'] = incharge;
//     data['customer_name'] = customerName;
//     return data;
//   }
// }


// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    bool? status;
    String? message;
    String? token;
    Data? data;

    LoginModel({
         this.status,
         this.message,
         this.token,
         this.data,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "data": data!.toJson(),
    };
}

class Data {
    String? id;
    String? internalId;
    int v;
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

    Data({
         this.id,
         this.internalId,
    required this.v,
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
