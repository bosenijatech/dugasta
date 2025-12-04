class ApartmentTypeModel {
  bool? status;
  List<Message>? message;

  ApartmentTypeModel({this.status, this.message});

  ApartmentTypeModel.fromJson(Map<String, dynamic> json) {
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
  String? internalid;
  String? name;

  Message({this.internalid, this.name});

  Message.fromJson(Map<String, dynamic> json) {
    internalid = json['internalid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['internalid'] = internalid;
    data['name'] = name;
    return data;
  }
}
