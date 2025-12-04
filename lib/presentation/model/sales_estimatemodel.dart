





// // To parse this JSON data, do
// //
// //     final salesestimateModel = salesestimateModelFromJson(jsonString);

// import 'dart:convert';

// SalesestimateModel salesestimateModelFromJson(String str) => SalesestimateModel.fromJson(json.decode(str));

// String salesestimateModelToJson(SalesestimateModel data) => json.encode(data.toJson());

// class SalesestimateModel {
//     bool status;
//     String message;
//     List<SalesestimateList> data;

//     SalesestimateModel({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory SalesestimateModel.fromJson(Map<String, dynamic> json) => SalesestimateModel(
//         status: json["status"],
//         message: json["message"],
//         data: List<SalesestimateList>.from(json["data"].map((x) => SalesestimateList.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class SalesestimateList {
//     String? id;
//     String? internalId;
//     DateTime? date;
//     String? estimateId;
//     String? customerId;
//     String? customerName;
//     String? status;
//     String? offerAccept;
//     int? expiryDays;
//     String? subsidiary;
//     BuildingSegment? propertyName;
//     String? unitName;
//     String? unitNo;
//     String? unitType;
//     String? buildingSegment;
//     String? unitSegment;
//     String? anticipatedCompletionDate;
//     int? totalArea;
//     int? total;
//     String? salesRep;
//     String? agentName;
//     String? agentOrBroker;
//     String? createdBy;
//     String? leadSource;
//     DateTime? createdTime;
//     String? dldWaiver;
//     String? nextApprovalRole;
//     String? approvalStatus;
//     String? reasonForRejection;
//     String? reasonForCancellation;
//     String? planType;
//     String schemeType;
//     String? pricingPlanName;
//     String? benefits;
//     String? serviceChargesWaiver;
//     String? buyBac;
//     String? rentalGuarantee;
//     List<Item>? items;
//     List<PricingSchedule>? pricingSchedule;
//     int? v;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     SalesestimateList({
//          this.id,
//          this.internalId,
//          this.date,
//          this.estimateId,
//          this.customerId,
//          this.customerName,
//          this.status,
//          this.offerAccept,
//          this.expiryDays,
//          this.subsidiary,
//          this.propertyName,
//          this.unitName,
//          this.unitNo,
//          this.unitType,
//          this.buildingSegment,
//          this.unitSegment,
//          this.anticipatedCompletionDate,
//          this.totalArea,
//          this.total,
//          this.salesRep,
//          this.agentName,
//          this.agentOrBroker,
//          this.createdBy,
//          this.leadSource,
//          this.createdTime,
//          this.dldWaiver,
//          this.nextApprovalRole,
//          this.approvalStatus,
//          this.reasonForRejection,
//          this.reasonForCancellation,
//          this.planType,
//          required this.schemeType,
//          this.pricingPlanName,
//          this.benefits,
//         required this.serviceChargesWaiver,
//          this.buyBac,
//          this.rentalGuarantee,
//          this.items,
//          this.pricingSchedule,
//          this.v,
//         required this.createdAt,
//          this.updatedAt,
//     });

//     factory SalesestimateList.fromJson(Map<String, dynamic> json) => SalesestimateList(
//         id: json["_id"],
//         internalId: json["internalId"],
//         date: DateTime.parse(json["date"]),
//         estimateId: json["estimateId"],
//         customerId: json["customerId"],
//         customerName: json["customerName"],
//         status: json["status"],
//         offerAccept: json["offerAccept"],
//         expiryDays: json["expiryDays"],
//         subsidiary: json["subsidiary"],
//         propertyName: buildingSegmentValues.map[json["propertyName"]]!,
//         unitName: json["unitName"],
//         unitNo: json["unitNo"],
//         unitType: json["unitType"],
//         buildingSegment:  json["buildingSegment"],
//         unitSegment: json["unitSegment"],
//         anticipatedCompletionDate: json["anticipatedCompletionDate"],
//         totalArea: json["totalArea"],
//         total: json["total"],
//         salesRep: json["salesRep"],
//         agentName: json["AgentName"],
//         agentOrBroker: json["AgentOrBroker"],
//         createdBy: json["createdBy"],
//         leadSource: json["leadSource"],
//         createdTime: DateTime.parse(json["createdTime"]),
//         dldWaiver: json["dldWaiver"],
//         nextApprovalRole: json["nextApprovalRole"],
//         approvalStatus: json["approvalStatus"],
//         reasonForRejection: json["reasonForRejection"],
//         reasonForCancellation: json["reasonForCancellation"],
//         planType: json["planType"],
//         schemeType: json["schemeType"],
//         pricingPlanName: json["pricingPlanName"],
//         benefits: json["benefits"],
//         serviceChargesWaiver: json["serviceChargesWaiver"],
//         buyBac: json["buyBac"],
//         rentalGuarantee: json["rentalGuarantee"],
//         items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
//         pricingSchedule: List<PricingSchedule>.from(json["pricingSchedule"].map((x) => PricingSchedule.fromJson(x))),
//         v: json["__v"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "internalId": internalId,
//         "date": date!.toIso8601String(),
//         "estimateId": estimateId,
//         "customerId": customerId,
//         "customerName": customerName,
//         "status": status,
//         "offerAccept": offerAccept,
//         "expiryDays": expiryDays,
//         "subsidiary": subsidiary,
//         "propertyName": buildingSegmentValues.reverse[propertyName],
//         "unitName": unitName,
//         "unitNo": unitNo,
//         "unitType": unitType,
//         "buildingSegment": buildingSegmentValues.reverse[buildingSegment],
//         "unitSegment": unitSegment,
//         "anticipatedCompletionDate": anticipatedCompletionDate,
//         "totalArea": totalArea,
//         "total": total,
//         "salesRep": salesRep,
//         "AgentName": agentName,
//         "AgentOrBroker": agentOrBroker,
//         "createdBy": createdBy,
//         "leadSource": leadSource,
//         "createdTime": createdTime!.toIso8601String(),
//         "dldWaiver": dldWaiver,
//         "nextApprovalRole": nextApprovalRole,
//         "approvalStatus": approvalStatus,
//         "reasonForRejection": reasonForRejection,
//         "reasonForCancellation": reasonForCancellation,
//         "planType": planType,
//         "schemeType": schemeType,
//         "pricingPlanName": pricingPlanName,
//         "benefits": benefits,
//         "serviceChargesWaiver": serviceChargesWaiver,
//         "buyBac": buyBac,
//         "rentalGuarantee": rentalGuarantee,
//         "items": List<dynamic>.from(items!.map((x) => x.toJson())),
//         "pricingSchedule": List<dynamic>.from(pricingSchedule!.map((x) => x.toJson())),
//         "__v": v,
//         "createdAt": createdAt!.toIso8601String(),
//         "updatedAt": updatedAt!.toIso8601String(),
//     };
// }

// enum BuildingSegment {
//     AHR4_AL_HASEEN_RESIDENCES_4,
//     EMPTY
// }

// final buildingSegmentValues = EnumValues({
//     "AHR4 - Al Haseen Residences 4": BuildingSegment.AHR4_AL_HASEEN_RESIDENCES_4,
//     "": BuildingSegment.EMPTY
// });

// class Item {
//     String? propertyName;
//     String? unitName;
//     String? item;
//     String? taxCode;
//     int? taxRate;
//     int? grossAmount;
//     double? amount;
//     int? discount;
//     dynamic? discountPercentage;
//     int? discountAmount;
//     String? propertyServiceType;
//     String? generateSchedule;
//     String? id;

//     Item({
//          this.propertyName,
//          this.unitName,
//          this.item,
//          this.taxCode,
//          this.taxRate,
//          this.grossAmount,
//          this.amount,
//          this.discount,
//          this.discountPercentage,
//          this.discountAmount,
//          this.propertyServiceType,
//          this.generateSchedule,
//          this.id,
//     });

//     factory Item.fromJson(Map<String, dynamic> json) => Item(
//         propertyName:  json["propertyName"],
//         unitName: json["unitName"],
//         item: json["item"],
//         taxCode:  json["taxCode"],
//         taxRate: json["taxRate"],
//         grossAmount: json["grossAmount"],
//         amount: json["amount"]?.toDouble(),
//         discount: json["discount"],
//         discountPercentage: json["discountPercentage"],
//         discountAmount: json["discountAmount"],
//         propertyServiceType: json["propertyServiceType"],
//         generateSchedule: json["generateSchedule"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "propertyName": buildingSegmentValues.reverse[propertyName],
//         "unitName": unitName,
//         "item": item,
//         "taxCode": taxCodeValues.reverse[taxCode],
//         "taxRate": taxRate,
//         "grossAmount": grossAmount,
//         "amount": amount,
//         "discount": discount,
//         "discountPercentage": discountPercentage,
//         "discountAmount": discountAmount,
//         "propertyServiceType": propertyServiceType,
//         "generateSchedule": generateSchedule,
//         "_id": id,
//     };
// }

// enum TaxCode {
//     VAT_AE_UNDEF_AE,
//     VAT_AE_VAT_5
// }

// final taxCodeValues = EnumValues({
//     "VAT_AE:UNDEF-AE": TaxCode.VAT_AE_UNDEF_AE,
//     "VAT_AE:Vat 5 %": TaxCode.VAT_AE_VAT_5
// });

// class PricingSchedule {
//     int? pricingPercent;
//     String? date;
//     double? amount;
//     Remarks? remarks;
//     String? allocate;
//     int? autoUniqueNumber;
//     String? installment;
//     String? installmentNumber;
//     String? paymentIntervalMonth;
//     PaymentStatus? paymentStatus;
//     String? stageName;
//     String? paymentIntervalDays;
//     String? id;

//     PricingSchedule({
//          this.pricingPercent,
//          this.date,
//          this.amount,
//          this.remarks,
//          this.allocate,
//          this.autoUniqueNumber,
//          this.installment,
//          this.installmentNumber,
//          this.paymentIntervalMonth,
//          this.paymentStatus,
//          this.stageName,
//          this.paymentIntervalDays,
//          this.id,
//     });

//     factory PricingSchedule.fromJson(Map<String, dynamic> json) => PricingSchedule(
//         pricingPercent: json["pricingPercent"],
//         date: json["date"],
//         amount: json["amount"]?.toDouble(),
//         remarks: remarksValues.map[json["remarks"]]!,
//         allocate: json["allocate"],
//         autoUniqueNumber: json["autoUniqueNumber"],
//         installment: json["installment"],
//         installmentNumber: json["installmentNumber"],
//         paymentIntervalMonth: json["paymentIntervalMonth"],
//         paymentStatus: paymentStatusValues.map[json["paymentStatus"]]!,
//         stageName: json["stageName"],
//         paymentIntervalDays: json["paymentIntervalDays"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "pricingPercent": pricingPercent,
//         "date": date,
//         "amount": amount,
//         "remarks": remarksValues.reverse[remarks],
//         "allocate": allocate,
//         "autoUniqueNumber": autoUniqueNumber,
//         "installment": installment,
//         "installmentNumber": installmentNumber,
//         "paymentIntervalMonth": paymentIntervalMonth,
//         "paymentStatus": paymentStatusValues.reverse[paymentStatus],
//         "stageName": stageName,
//         "paymentIntervalDays": paymentIntervalDays,
//         "_id": id,
//     };
// }

// enum PaymentStatus {
//     OPEN
// }

// final paymentStatusValues = EnumValues({
//     "Open": PaymentStatus.OPEN
// });

// enum Remarks {
//     FROM_BOOKING_DATE,
//     HAND_OVER,
//     ON_BOOKING
// }

// final remarksValues = EnumValues({
//     "From Booking Date": Remarks.FROM_BOOKING_DATE,
//     "Hand Over": Remarks.HAND_OVER,
//     "On Booking": Remarks.ON_BOOKING
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//             reverseMap = map.map((k, v) => MapEntry(v, k));
//             return reverseMap;
//     }
// }


import 'dart:convert';

// Helper functions for converting JSON
SalesestimateModel salesestimateModelFromJson(String str) =>
    SalesestimateModel.fromJson(json.decode(str));

String salesestimateModelToJson(SalesestimateModel data) =>
    json.encode(data.toJson());

// ================== Helper Functions ==================
int? parseInt(dynamic val) {
  if (val == null) return null;
  if (val is int) return val;
  if (val is double) return val.toInt();
  if (val is String) return int.tryParse(val);
  return null;
}

double? parseDouble(dynamic val) {
  if (val == null) return null;
  if (val is double) return val;
  if (val is int) return val.toDouble();
  if (val is String) return double.tryParse(val);
  return null;
}

DateTime? parseDate(dynamic val) {
  if (val == null || val == "") return null;
  try {
    return DateTime.parse(val);
  } catch (_) {
    return null;
  }
}

// ================== SalesestimateModel ==================
class SalesestimateModel {
  bool status;
  String message;
  List<SalesestimateList> data;

  SalesestimateModel({
    required this.status,
    required this.message,
    List<SalesestimateList>? data,
  }) : data = data ?? [];

  factory SalesestimateModel.fromJson(Map<String, dynamic> json) =>
      SalesestimateModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? List<SalesestimateList>.from(
                (json["data"] as List)
                    .map((x) => SalesestimateList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

// ================== SalesestimateList ==================
class SalesestimateList {
  String? id;
  String? internalId;
  DateTime? date;
  String? estimateId;
  String? customerId;
  String? customerName;
  String? status;
  String? offerAccept;
  int? expiryDays;
  String? subsidiary;
  String? propertyName;
  String? unitName;
  String? unitNo;
  String? unitType;
  String? buildingSegment;
  String? unitSegment;
  String? anticipatedCompletionDate;
  int? totalArea;
  int? total;
  String? salesRep;
  String? agentName;
  String? agentOrBroker;
  String? createdBy;
  String? leadSource;
  DateTime? createdTime;
  String? dldWaiver;
  String? nextApprovalRole;
  String? approvalStatus;
  String? reasonForRejection;
  String? reasonForCancellation;
  String? planType;
  String schemeType;
  String? pricingPlanName;
  String? benefits;
  String serviceChargesWaiver;
  String? buyBac;
  String? rentalGuarantee;
  List<Item> items;
  List<PricingSchedule> pricingSchedule;
  int? v;
  DateTime createdAt;
  DateTime? updatedAt;

  SalesestimateList({
    this.id,
    this.internalId,
    this.date,
    this.estimateId,
    this.customerId,
    this.customerName,
    this.status,
    this.offerAccept,
    this.expiryDays,
    this.subsidiary,
    this.propertyName,
    this.unitName,
    this.unitNo,
    this.unitType,
    this.buildingSegment,
    this.unitSegment,
    this.anticipatedCompletionDate,
    this.totalArea,
    this.total,
    this.salesRep,
    this.agentName,
    this.agentOrBroker,
    this.createdBy,
    this.leadSource,
    this.createdTime,
    this.dldWaiver,
    this.nextApprovalRole,
    this.approvalStatus,
    this.reasonForRejection,
    this.reasonForCancellation,
    this.planType,
    required this.schemeType,
    this.pricingPlanName,
    this.benefits,
    required this.serviceChargesWaiver,
    this.buyBac,
    this.rentalGuarantee,
    List<Item>? items,
    List<PricingSchedule>? pricingSchedule,
    this.v,
    required this.createdAt,
    this.updatedAt,
  })  : items = items ?? [],
        pricingSchedule = pricingSchedule ?? [];

  factory SalesestimateList.fromJson(Map<String, dynamic> json) =>
      SalesestimateList(
        id: json["_id"],
        internalId: json["internalId"],
        date: parseDate(json["date"]),
        estimateId: json["estimateId"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        status: json["status"],
        offerAccept: json["offerAccept"],
        expiryDays: parseInt(json["expiryDays"]),
        subsidiary: json["subsidiary"],
        propertyName: json["propertyName"],
        unitName: json["unitName"],
        unitNo: json["unitNo"],
        unitType: json["unitType"],
        buildingSegment: json["buildingSegment"],
        unitSegment: json["unitSegment"],
        anticipatedCompletionDate: json["anticipatedCompletionDate"],
        totalArea: parseInt(json["totalArea"]),
        total: parseInt(json["total"]),
        salesRep: json["salesRep"],
        agentName: json["AgentName"],
        agentOrBroker: json["AgentOrBroker"],
        createdBy: json["createdBy"],
        leadSource: json["leadSource"],
        createdTime: parseDate(json["createdTime"]),
        dldWaiver: json["dldWaiver"],
        nextApprovalRole: json["nextApprovalRole"],
        approvalStatus: json["approvalStatus"],
        reasonForRejection: json["reasonForRejection"],
        reasonForCancellation: json["reasonForCancellation"],
        planType: json["planType"],
        schemeType: json["schemeType"] ?? "",
        pricingPlanName: json["pricingPlanName"],
        benefits: json["benefits"],
        serviceChargesWaiver: json["serviceChargesWaiver"] ?? "",
        buyBac: json["buyBac"],
        rentalGuarantee: json["rentalGuarantee"],
        items: json["items"] != null
            ? List<Item>.from(
                (json["items"] as List).map((x) => Item.fromJson(x)))
            : [],
        pricingSchedule: json["pricingSchedule"] != null
            ? List<PricingSchedule>.from(
                (json["pricingSchedule"] as List)
                    .map((x) => PricingSchedule.fromJson(x)))
            : [],
        v: parseInt(json["__v"]),
        createdAt: parseDate(json["createdAt"]) ?? DateTime.now(),
        updatedAt: parseDate(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "internalId": internalId,
        "date": date?.toIso8601String(),
        "estimateId": estimateId,
        "customerId": customerId,
        "customerName": customerName,
        "status": status,
        "offerAccept": offerAccept,
        "expiryDays": expiryDays,
        "subsidiary": subsidiary,
        "propertyName": propertyName,
        "unitName": unitName,
        "unitNo": unitNo,
        "unitType": unitType,
        "buildingSegment": buildingSegment,
        "unitSegment": unitSegment,
        "anticipatedCompletionDate": anticipatedCompletionDate,
        "totalArea": totalArea,
        "total": total,
        "salesRep": salesRep,
        "AgentName": agentName,
        "AgentOrBroker": agentOrBroker,
        "createdBy": createdBy,
        "leadSource": leadSource,
        "createdTime": createdTime?.toIso8601String(),
        "dldWaiver": dldWaiver,
        "nextApprovalRole": nextApprovalRole,
        "approvalStatus": approvalStatus,
        "reasonForRejection": reasonForRejection,
        "reasonForCancellation": reasonForCancellation,
        "planType": planType,
        "schemeType": schemeType,
        "pricingPlanName": pricingPlanName,
        "benefits": benefits,
        "serviceChargesWaiver": serviceChargesWaiver,
        "buyBac": buyBac,
        "rentalGuarantee": rentalGuarantee,
        "items": items.map((x) => x.toJson()).toList(),
        "pricingSchedule": pricingSchedule.map((x) => x.toJson()).toList(),
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

// ================== Item Class ==================
class Item {
  String? propertyName;
  String? unitName;
  String? item;
  String? taxCode;
  int? taxRate;
  int? grossAmount;
  double? amount;
  int? discount;
  dynamic discountPercentage;
  int? discountAmount;
  String? propertyServiceType;
  String? generateSchedule;
  String? id;

  Item({
    this.propertyName,
    this.unitName,
    this.item,
    this.taxCode,
    this.taxRate,
    this.grossAmount,
    this.amount,
    this.discount,
    this.discountPercentage,
    this.discountAmount,
    this.propertyServiceType,
    this.generateSchedule,
    this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        propertyName: json["propertyName"],
        unitName: json["unitName"],
        item: json["item"],
        taxCode: json["taxCode"],
        taxRate: parseInt(json["taxRate"]),
        grossAmount: parseInt(json["grossAmount"]),
        amount: parseDouble(json["amount"]),
        discount: parseInt(json["discount"]),
        discountPercentage: json["discountPercentage"],
        discountAmount: parseInt(json["discountAmount"]),
        propertyServiceType: json["propertyServiceType"],
        generateSchedule: json["generateSchedule"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "propertyName": propertyName,
        "unitName": unitName,
        "item": item,
        "taxCode": taxCode,
        "taxRate": taxRate,
        "grossAmount": grossAmount,
        "amount": amount,
        "discount": discount,
        "discountPercentage": discountPercentage,
        "discountAmount": discountAmount,
        "propertyServiceType": propertyServiceType,
        "generateSchedule": generateSchedule,
        "_id": id,
      };
}

// ================== PricingSchedule Class ==================
class PricingSchedule {
  int? pricingPercent;
  String? date;
  double? amount;
  String? remarks;
  String? allocate;
  int? autoUniqueNumber;
  String? installment;
  String? installmentNumber;
  String? paymentIntervalMonth;
  String? paymentStatus;
  String? stageName;
  String? paymentIntervalDays;
  String? id;

  PricingSchedule({
    this.pricingPercent,
    this.date,
    this.amount,
    this.remarks,
    this.allocate,
    this.autoUniqueNumber,
    this.installment,
    this.installmentNumber,
    this.paymentIntervalMonth,
    this.paymentStatus,
    this.stageName,
    this.paymentIntervalDays,
    this.id,
  });

  factory PricingSchedule.fromJson(Map<String, dynamic> json) =>
      PricingSchedule(
        pricingPercent: parseInt(json["pricingPercent"]),
        date: json["date"],
        amount: parseDouble(json["amount"]),
        remarks: json["remarks"],
        allocate: json["allocate"],
        autoUniqueNumber: parseInt(json["autoUniqueNumber"]),
        installment: json["installment"],
        installmentNumber: json["installmentNumber"],
        paymentIntervalMonth: json["paymentIntervalMonth"],
        paymentStatus: json["paymentStatus"],
        stageName: json["stageName"],
        paymentIntervalDays: json["paymentIntervalDays"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "pricingPercent": pricingPercent,
        "date": date,
        "amount": amount,
        "remarks": remarks,
        "allocate": allocate,
        "autoUniqueNumber": autoUniqueNumber,
        "installment": installment,
        "installmentNumber": installmentNumber,
        "paymentIntervalMonth": paymentIntervalMonth,
        "paymentStatus": paymentStatus,
        "stageName": stageName,
        "paymentIntervalDays": paymentIntervalDays,
        "_id": id,
      };
}

// ================== BuildingSegment Enum ==================
enum BuildingSegment {
  AHR4_AL_HASEEN_RESIDENCES_4,
  EMPTY,
}

final buildingSegmentValues = EnumValues({
  "AHR4 - Al Haseen Residences 4": BuildingSegment.AHR4_AL_HASEEN_RESIDENCES_4,
  "": BuildingSegment.EMPTY,
});

// ================== EnumValues Helper ==================
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
