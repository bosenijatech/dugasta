import 'dart:convert';

Viewunitstatementmodel viewunitstatementmodelFromJson(String str) =>
    Viewunitstatementmodel.fromJson(json.decode(str));

String viewunitstatementmodelToJson(Viewunitstatementmodel data) =>
    json.encode(data.toJson());

class Viewunitstatementmodel {
  bool success;
  Message message;

  Viewunitstatementmodel({
    required this.success,
    required this.message,
  });

  factory Viewunitstatementmodel.fromJson(Map<String, dynamic> json) =>
      Viewunitstatementmodel(
        success: json["success"] ?? false,
        message: json["message"] == null
            ? Message()
            : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message.toJson(),
      };
}

class Message {
  bool? success;
  String? buyerName;
  Property? property;
  Summary? summary;
  List<Transaction>? transactions;

  Message({
    this.success,
    this.buyerName,
    this.property,
    this.summary,
    this.transactions,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: json["success"],
        buyerName: json["buyerName"],

        property: json["property"] == null
            ? null
            : Property.fromJson(json["property"]),

        summary: json["summary"] == null
            ? null
            : Summary.fromJson(json["summary"]),

        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]
                    .map((x) => Transaction.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "buyerName": buyerName,
        "property": property?.toJson(),
        "summary": summary?.toJson(),
        "transactions":
            transactions?.map((x) => x.toJson()).toList(),
      };
}

class Property {
  String? buildingName;
  String? location;
  String? apartmentNo;
  String? apartmentType;
  String? area;

  Property({
    this.buildingName,
    this.location,
    this.apartmentNo,
    this.apartmentType,
    this.area,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        buildingName: json["buildingName"],
        location: json["location"],
        apartmentNo: json["apartmentNo"],
        apartmentType: json["apartmentType"],
        area: json["area"],
      );

  Map<String, dynamic> toJson() => {
        "buildingName": buildingName,
        "location": location,
        "apartmentNo": apartmentNo,
        "apartmentType": apartmentType,
        "area": area,
      };
}

class Summary {
  double? balance;

  Summary({this.balance});

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        balance: json["balance"] == null
            ? null
            : (json["balance"] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
      };
}

class Transaction {
  String? item;
  String? transactionnumber;
  String? trandate;
  double? amount;
  double? received;
  double? rtotal;

  Transaction({
    this.item,
    this.transactionnumber,
    this.trandate,
    this.amount,
    this.received,
    this.rtotal,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        item: json["item"],
        transactionnumber: json["transactionnumber"],
        trandate: json["trandate"],
        amount: json["amount"] == null
            ? null
            : (json["amount"] as num).toDouble(),
        received: json["received"] == null
            ? null
            : (json["received"] as num).toDouble(),
        rtotal: json["rtotal"] == null
            ? null
            : (json["rtotal"] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "transactionnumber": transactionnumber,
        "trandate": trandate,
        "amount": amount,
        "received": received,
        "rtotal": rtotal,
      };
}
