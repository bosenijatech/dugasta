class ChequeModel {
  bool? status;
  List<Message>? message;

  ChequeModel({this.status, this.message});

  ChequeModel.fromJson(Map<String, dynamic> json) {
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
  String? receiptid;
  int? internalid;
  int? receiptno;
  String? receiptdate;
  int? amount;
  String? contractid;
  String? tenantid;
  String? tenantname;
  String? active;
  int? issync;
  List<Details>? details;
  String? source;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Message(
      {this.sId,
      this.receiptid,
      this.internalid,
      this.receiptno,
      this.receiptdate,
      this.amount,
      this.contractid,
      this.tenantid,
      this.tenantname,
      this.active,
      this.issync,
      this.details,
      this.source,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    receiptid = json['receiptid'];
    internalid = json['internalid'];
    receiptno = json['receiptno'];
    receiptdate = json['receiptdate'];
    amount = json['amount'];
    contractid = json['contractid'];
    tenantid = json['tenantid'];
    tenantname = json['tenantname'];
    active = json['active'];
    issync = json['issync'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    source = json['source'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['receiptid'] = receiptid;
    data['internalid'] = internalid;
    data['receiptno'] = receiptno;
    data['receiptdate'] = receiptdate;
    data['amount'] = amount;
    data['contractid'] = contractid;
    data['tenantid'] = tenantid;
    data['tenantname'] = tenantname;
    data['active'] = active;
    data['issync'] = issync;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    data['source'] = source;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Details {
  String? receiptid;
  int? internalid;
  String? receiptdate;
  String? paymode;
  String? chequedate;
  int? amount;
  String? sId;

  Details(
      {this.receiptid,
      this.internalid,
      this.receiptdate,
      this.paymode,
      this.chequedate,
      this.amount,
      this.sId});

  Details.fromJson(Map<String, dynamic> json) {
    receiptid = json['receiptid'];
    internalid = json['internalid'];
    receiptdate = json['receiptdate'];
    paymode = json['paymode'];
    chequedate = json['chequedate'];
    amount = json['amount'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receiptid'] = receiptid;
    data['internalid'] = internalid;
    data['receiptdate'] = receiptdate;
    data['paymode'] = paymode;
    data['chequedate'] = chequedate;
    data['amount'] = amount;
    data['_id'] = sId;
    return data;
  }
}
