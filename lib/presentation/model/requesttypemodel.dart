class RequestTypeModel {
  bool? status;
  List<Message>? message;

  RequestTypeModel({this.status, this.message});

  RequestTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? internalid;
  String? name;

  Message({this.internalid, this.name});

  Message.fromJson(Map<String, dynamic> json) {
    internalid = json['internalid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['internalid'] = this.internalid;
    data['name'] = this.name;
    return data;
  }
}
