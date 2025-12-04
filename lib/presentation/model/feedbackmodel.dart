class FeedbackModel {
  bool? status;
  List<Message>? message;

  FeedbackModel({this.status, this.message});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
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
  String? code;
  String? name;
  String? active;

  Message({this.sId, this.code, this.name, this.active});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    code = json['code'];
    name = json['name'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['code'] = code;
    data['name'] = name;
    data['active'] = active;
    return data;
  }
}
