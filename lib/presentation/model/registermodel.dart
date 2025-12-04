class RegisterModel {
  bool? success;
  ResponseData? responseData;

  RegisterModel({this.success, this.responseData});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    responseData = json['responseData'] != null
        ? ResponseData.fromJson(json['responseData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (responseData != null) {
      data['responseData'] = responseData!.toJson();
    }
    return data;
  }
}

class ResponseData {
  int? status;
  int? leadId;
  String? otp;

  ResponseData({this.status, this.leadId, this.otp});

  ResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    leadId = json['leadId'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['leadId'] = leadId;
    data['otp'] = otp;
    return data;
  }
}
