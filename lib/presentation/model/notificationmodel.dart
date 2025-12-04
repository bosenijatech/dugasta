class NotificationModel {
  bool? status;
  List<Message>? message;

  NotificationModel({this.status, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (message != null) {
      data['message'] = message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? sId;
  String? notificationmessage;
  String? createddatetime;
  String? customerId;
  int? isread;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Message(
      {this.sId,
      this.notificationmessage,
      this.createddatetime,
      this.customerId,
      this.isread,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    notificationmessage = json['notificationmessage'];
    createddatetime = json['createddatetime'];
    customerId = json['customerId'];
    isread = json['isread'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['notificationmessage'] = notificationmessage;
    data['createddatetime'] = createddatetime;
    data['customerId'] = customerId;
    data['isread'] = isread;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
