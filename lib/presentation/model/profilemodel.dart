class ProfileModel {
  bool? status;
  Message? message;

  ProfileModel({this.status, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  String? sId;
  String? tenantId;
  String? tenantInternalid;
  String? tenantFirstname;
  String? tenantLastname;
  String? tenantCountrycode;
  String? tenantMobileno;
  String? tenantEmail;
  String? tenantUsername;
  String? tenantPassword;
  String? tenantPassportno;
  String? tenantPassportexpdate;
  String? tenantEmirtesid;
  String? tenantEmirtesexpdate;
  String? tenantimgurl;
  String? source;
  int? issync;
  int? customerId;
  String? role;
  String? active;
  int? subsidiary;
  int? maintenanceIncharge;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Message(
      {this.sId,
      this.tenantId,
      this.tenantInternalid,
      this.tenantFirstname,
      this.tenantLastname,
      this.tenantCountrycode,
      this.tenantMobileno,
      this.tenantEmail,
      this.tenantUsername,
      this.tenantPassword,
      this.tenantPassportno,
      this.tenantPassportexpdate,
      this.tenantEmirtesid,
      this.tenantEmirtesexpdate,
      this.tenantimgurl,
      this.source,
      this.issync,
      this.customerId,
      this.role,
      this.active,
      this.subsidiary,
      this.maintenanceIncharge,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tenantId = json['tenant_id'];
    tenantInternalid = json['tenant_internalid'];
    tenantFirstname = json['tenant_firstname'];
    tenantLastname = json['tenant_lastname'];
    tenantCountrycode = json['tenant_countrycode'];
    tenantMobileno = json['tenant_mobileno'];
    tenantEmail = json['tenant_email'];
    tenantUsername = json['tenant_username'];
    tenantPassword = json['tenant_password'];
    tenantPassportno = json['tenant_passportno'];
    tenantPassportexpdate = json['tenant_passportexpdate'];
    tenantEmirtesid = json['tenant_emirtesid'];
    tenantEmirtesexpdate = json['tenant_emirtesexpdate'];
    tenantimgurl = json['tenantimgurl'];
    source = json['source'];
    issync = json['issync'];
    customerId = json['customerId'];
    role = json['role'];
    active = json['active'];
    subsidiary = json['subsidiary'];
    maintenanceIncharge = json['maintenanceIncharge'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['tenant_id'] = tenantId;
    data['tenant_internalid'] = tenantInternalid;
    data['tenant_firstname'] = tenantFirstname;
    data['tenant_lastname'] = tenantLastname;
    data['tenant_countrycode'] = tenantCountrycode;
    data['tenant_mobileno'] = tenantMobileno;
    data['tenant_email'] = tenantEmail;
    data['tenant_username'] = tenantUsername;
    data['tenant_password'] = tenantPassword;
    data['tenant_passportno'] = tenantPassportno;
    data['tenant_passportexpdate'] = tenantPassportexpdate;
    data['tenant_emirtesid'] = tenantEmirtesid;
    data['tenant_emirtesexpdate'] = tenantEmirtesexpdate;
    data['tenantimgurl'] = tenantimgurl;
    data['source'] = source;
    data['issync'] = issync;
    data['customerId'] = customerId;
    data['role'] = role;
    data['active'] = active;
    data['subsidiary'] = subsidiary;
    data['maintenanceIncharge'] = maintenanceIncharge;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
