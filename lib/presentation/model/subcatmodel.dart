class SubCategoryModel {
  bool? status;
  List<Message>? message;

  SubCategoryModel({this.status, this.message});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
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
  int? catHeaderid;
  String? subcatId;
  String? subcatName;
  int? subcatCharges;
  int? subcatAmount;
  String? subcatCurrency;
  String? active;

  Message(
      {this.sId,
      this.rmHeaderid,
      this.catHeaderid,
      this.subcatId,
      this.subcatName,
      this.subcatCharges,
      this.subcatAmount,
      this.subcatCurrency,
      this.active});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rmHeaderid = json['rm_headerid'];
    catHeaderid = json['cat_headerid'];
    subcatId = json['subcat_id'];
    subcatName = json['subcat_name'];
    subcatCharges = json['subcat_charges'];
    subcatAmount = json['subcat_amount'];
    subcatCurrency = json['subcat_currency'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['rm_headerid'] = rmHeaderid;
    data['cat_headerid'] = catHeaderid;
    data['subcat_id'] = subcatId;
    data['subcat_name'] = subcatName;
    data['subcat_charges'] = subcatCharges;
    data['subcat_amount'] = subcatAmount;
    data['subcat_currency'] = subcatCurrency;
    data['active'] = active;
    return data;
  }
}
