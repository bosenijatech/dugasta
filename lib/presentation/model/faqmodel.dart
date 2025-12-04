class FAQModel {
  bool? status;
  List<Message>? message;

  FAQModel({this.status, this.message});

  FAQModel.fromJson(Map<String, dynamic> json) {
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
  String? ans;
  String? active;

  Message({this.sId, this.code, this.name, this.ans, this.active});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    code = json['code'];
    name = json['name'];
    ans = json['ans'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['code'] = code;
    data['name'] = name;
    data['ans'] = ans;
    data['active'] = active;
    return data;
  }
}
