class CategoryModel {
  bool? status;
  List<Message>? message;

  CategoryModel({this.status, this.message});

  CategoryModel.fromJson(Map<String, dynamic> json) {
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
  int? rmHeaderid;
  String? catId;
  String? catName;
  String? active;

  Message({this.sId, this.rmHeaderid, this.catId, this.catName, this.active});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rmHeaderid = json['rm_headerid'];
    catId = json['cat_id'];
    catName = json['cat_name'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['rm_headerid'] = rmHeaderid;
    data['cat_id'] = catId;
    data['cat_name'] = catName;
    data['active'] = active;
    return data;
  }
}
