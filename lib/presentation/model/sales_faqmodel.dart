// sales_contractmodel.dart
import 'dart:convert';

SalesfaqModel salesfaqModelFromJson(String str) =>
    SalesfaqModel.fromJson(json.decode(str));

String salesfaqModelToJson(SalesfaqModel data) => json.encode(data.toJson());

class SalesfaqModel {
  bool status;
  List<SlaesFaqList> message;

  SalesfaqModel({
    required this.status,
    required this.message,
  });

  factory SalesfaqModel.fromJson(Map<String, dynamic> json) => SalesfaqModel(
        status: json["status"] ?? false,
        message: json["message"] == null
            ? []
            : List<SlaesFaqList>.from(
                json["message"].map((x) => SlaesFaqList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class SlaesFaqList {
  String? id;
  String? code;
  String? name;
  String? ans;
  Active? active;

  SlaesFaqList({
     this.id,
     this.code,
     this.name,
     this.ans,
     this.active,
  });

  factory SlaesFaqList.fromJson(Map<String, dynamic> json) => SlaesFaqList(
        id: json["_id"] ?? "",
        code: json["code"] ?? "",
        name: json["name"] ?? "",
        ans: json["ans"] ?? "",
        active: activeValues.map[json["active"]] ?? Active.Y,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "code": code,
        "name": name,
        "ans": ans,
        "active": activeValues.reverse[active],
      };
}

enum Active { Y }

final activeValues = EnumValues({"Y": Active.Y});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

