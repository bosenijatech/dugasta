

// import 'dart:convert';

// SalescontractModel salescontractModelFromJson(String str) => SalescontractModel.fromJson(json.decode(str));

// String salescontractModelToJson(SalescontractModel data) => json.encode(data.toJson());

// class SalescontractModel {
//     bool status;
//     String message;
//     List<SalesList> data;

//     SalescontractModel({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory SalescontractModel.fromJson(Map<String, dynamic> json) => SalescontractModel(
//         status: json["status"],
//         message: json["message"],
//         data: List<SalesList>.from(json["data"].map((x) => SalesList.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class SalesList {
//     String? id;
//     int? total;
//     String? internalId;
//     DateTime? date;
//     String? contractId;
//     String? customerId;
//     String? customerName;
//     String? status;
//     String? baseRef;
//     String? subsidiary;
//     String? spaTemplate;
//     String? annexure;
//     String? propertyName;
//     String? unitName;
//     String? unitNo;
//     String? unitType;
//     String? buildingSegment;
//     String? unitSegment;
//     String? nextApprovalRole;
//     String? approvalStatus;
//     String? reasonForRejection;
//     String? planType;
//     String? schemeType;
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

//     SalesList({
//          this.id,
//          this.internalId,
//          this.total,
//          this.date,
//          this.contractId,
//          this.customerId,
//          this.customerName,
//          this.status,
//          this.baseRef,
//          this.subsidiary,
//          this.spaTemplate,
//          this.annexure,
//          this.propertyName,
//          this.unitName,
//          this.unitNo,
//          this.unitType,
//          this.buildingSegment,
//          this.unitSegment,
//          this.nextApprovalRole,
//          this.approvalStatus,
//          this.reasonForRejection,
//          this.planType,
//          this.schemeType,
//          this.pricingPlanName,
//          this.benefits,
//          this.serviceChargesWaiver,
//          this.buyBac,
//          this.rentalGuarantee,
//          this.items,
//          this.pricingSchedule,
//          this.v,
//          this.createdAt,
//          this.updatedAt,
//     });

//     factory SalesList.fromJson(Map<String, dynamic> json) => SalesList(
//         id: json["_id"],
//         internalId: json["internalId"],
//         total: json["total"],
//         date: DateTime.parse(json["date"]),
//         contractId: json["contractId"],
//         customerId: json["customerId"],
//         customerName: json["customerName"],
//         status: json["status"],
//         baseRef: json["baseRef"],
//         subsidiary: json["subsidiary"],
//         spaTemplate: json["spaTemplate"],
//         annexure: json["annexure"],
//         propertyName: json["propertyName"],
//         unitName: json["unitName"],
//         unitNo: json["unitNo"],
//         unitType: json["unitType"],
//         buildingSegment: json["buildingSegment"],
//         unitSegment: json["unitSegment"],
//         nextApprovalRole: json["nextApprovalRole"],
//         approvalStatus: json["approvalStatus"],
//         reasonForRejection: json["reasonForRejection"],
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
//         "total": total,
//         "date": date!.toIso8601String(),
//         "contractId": contractId,
//         "customerId": customerId,
//         "customerName": customerName,
//         "status": status,
//         "baseRef": baseRef,
//         "subsidiary": subsidiary,
//         "spaTemplate": spaTemplate,
//         "annexure": annexure,
//         "propertyName": propertyName,
//         "unitName": unitName,
//         "unitNo": unitNo,
//         "unitType": unitType,
//         "buildingSegment": buildingSegment,
//         "unitSegment": unitSegment,
//         "nextApprovalRole": nextApprovalRole,
//         "approvalStatus": approvalStatus,
//         "reasonForRejection": reasonForRejection,
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

// class Item {
//     String? propertyName;
//     String? unitName;
//     String? priceLevel;
//     int? quantity;
//     double? rate;
//     double? amount;
//     String? description;
//     String? department;
//     int? discount;
//     String? propertyServiceType;
//     String? generateInvoice;
//     String? generateSchedule;
//     String? item;
//     int? grossAmount;
//     String? unitSegment;
//     String? buildingSegment;
//     String? taxCode;
//     int? taxPercentage;
//     int? taxAmount;
//     String? id;

//     Item({
//          this.propertyName,
//          this.unitName,
//          this.priceLevel,
//          this.quantity,
//          this.rate,
//          this.amount,
//          this.description,
//          this.department,
//          this.discount,
//          this.propertyServiceType,
//          this.generateInvoice,
//          this.generateSchedule,
//          this.item,
//          this.grossAmount,
//          this.unitSegment,
//          this.buildingSegment,
//          this.taxCode,
//          this.taxPercentage,
//          this.taxAmount,
//          this.id,
//     });

//     factory Item.fromJson(Map<String, dynamic> json) => Item(
//         propertyName: json["propertyName"],
//         unitName: json["unitName"],
//         priceLevel: json["priceLevel"],
//         quantity: json["quantity"],
//         rate: json["rate"]?.toDouble(),
//         amount: json["amount"]?.toDouble(),
//         description: json["description"],
//         department: json["department"],
//         discount: json["discount"],
//         propertyServiceType: json["propertyServiceType"],
//         generateInvoice: json["generateInvoice"],
//         generateSchedule: json["generateSchedule"],
//         item: json["item"],
//         grossAmount: json["grossAmount"],
//         unitSegment: json["unitSegment"],
//         buildingSegment: json["buildingSegment"],
//         taxCode: json["taxCode"],
//         taxPercentage: json["taxPercentage"],
//         taxAmount: json["taxAmount"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "propertyName": propertyName,
//         "unitName": unitName,
//         "priceLevel": priceLevel,
//         "quantity": quantity,
//         "rate": rate,
//         "amount": amount,
//         "description": description,
//         "department": department,
//         "discount": discount,
//         "propertyServiceType": propertyServiceType,
//         "generateInvoice": generateInvoice,
//         "generateSchedule": generateSchedule,
//         "item": item,
//         "grossAmount": grossAmount,
//         "unitSegment": unitSegment,
//         "buildingSegment": buildingSegment,
//         "taxCode": taxCode,
//         "taxPercentage": taxPercentage,
//         "taxAmount": taxAmount,
//         "_id": id,
//     };
// }

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

// =================== Helper functions ===================
int? parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

double? parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

// =================== Main Model ===================
SalescontractModel salescontractModelFromJson(String str) =>
    SalescontractModel.fromJson(json.decode(str));

String salescontractModelToJson(SalescontractModel data) =>
    json.encode(data.toJson());

class SalescontractModel {
  bool status;
  String message;
  List<SalesList> data;

  SalescontractModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SalescontractModel.fromJson(Map<String, dynamic> json) =>
      SalescontractModel(
        status: json["status"],
        message: json["message"],
        data: List<SalesList>.from(
            json["data"].map((x) => SalesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

// =================== SalesList ===================
class SalesList {
  String? id;
  int? total;
  String? internalId;
  DateTime? date;
  String? contractId;
  String? customerId;
  String? customerName;
  String? status;
  String? baseRef;
  String? subsidiary;
  String? spaTemplate;
  String? annexure;
  String? propertyName;
  String? unitName;
  String? unitNo;
  String? unitType;
  String? buildingSegment;
  String? unitSegment;
  String? nextApprovalRole;
  String? approvalStatus;
  String? reasonForRejection;
  String? planType;
  String? schemeType;
  String? pricingPlanName;
  String? benefits;
  String? serviceChargesWaiver;
  String? buyBac;
  String? rentalGuarantee;
  List<Item>? items;
  List<PricingSchedule>? pricingSchedule;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  SalesList({
    this.id,
    this.internalId,
    this.total,
    this.date,
    this.contractId,
    this.customerId,
    this.customerName,
    this.status,
    this.baseRef,
    this.subsidiary,
    this.spaTemplate,
    this.annexure,
    this.propertyName,
    this.unitName,
    this.unitNo,
    this.unitType,
    this.buildingSegment,
    this.unitSegment,
    this.nextApprovalRole,
    this.approvalStatus,
    this.reasonForRejection,
    this.planType,
    this.schemeType,
    this.pricingPlanName,
    this.benefits,
    this.serviceChargesWaiver,
    this.buyBac,
    this.rentalGuarantee,
    this.items,
    this.pricingSchedule,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory SalesList.fromJson(Map<String, dynamic> json) => SalesList(
        id: json["_id"],
        internalId: json["internalId"],
        total: parseInt(json["total"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        contractId: json["contractId"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        status: json["status"],
        baseRef: json["baseRef"],
        subsidiary: json["subsidiary"],
        spaTemplate: json["spaTemplate"],
        annexure: json["annexure"],
        propertyName: json["propertyName"],
        unitName: json["unitName"],
        unitNo: json["unitNo"],
        unitType: json["unitType"],
        buildingSegment: json["buildingSegment"],
        unitSegment: json["unitSegment"],
        nextApprovalRole: json["nextApprovalRole"],
        approvalStatus: json["approvalStatus"],
        reasonForRejection: json["reasonForRejection"],
        planType: json["planType"],
        schemeType: json["schemeType"],
        pricingPlanName: json["pricingPlanName"],
        benefits: json["benefits"],
        serviceChargesWaiver: json["serviceChargesWaiver"],
        buyBac: json["buyBac"],
        rentalGuarantee: json["rentalGuarantee"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        pricingSchedule: json["pricingSchedule"] == null
            ? []
            : List<PricingSchedule>.from(
                json["pricingSchedule"].map((x) => PricingSchedule.fromJson(x))),
        v: parseInt(json["__v"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "internalId": internalId,
        "total": total,
        "date": date?.toIso8601String(),
        "contractId": contractId,
        "customerId": customerId,
        "customerName": customerName,
        "status": status,
        "baseRef": baseRef,
        "subsidiary": subsidiary,
        "spaTemplate": spaTemplate,
        "annexure": annexure,
        "propertyName": propertyName,
        "unitName": unitName,
        "unitNo": unitNo,
        "unitType": unitType,
        "buildingSegment": buildingSegment,
        "unitSegment": unitSegment,
        "nextApprovalRole": nextApprovalRole,
        "approvalStatus": approvalStatus,
        "reasonForRejection": reasonForRejection,
        "planType": planType,
        "schemeType": schemeType,
        "pricingPlanName": pricingPlanName,
        "benefits": benefits,
        "serviceChargesWaiver": serviceChargesWaiver,
        "buyBac": buyBac,
        "rentalGuarantee": rentalGuarantee,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "pricingSchedule": pricingSchedule == null
            ? []
            : List<dynamic>.from(pricingSchedule!.map((x) => x.toJson())),
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

// =================== Item ===================
class Item {
  String? propertyName;
  String? unitName;
  String? priceLevel;
  int? quantity;
  double? rate;
  double? amount;
  String? description;
  String? department;
  int? discount;
  String? propertyServiceType;
  String? generateInvoice;
  String? generateSchedule;
  String? item;
  int? grossAmount;
  String? unitSegment;
  String? buildingSegment;
  String? taxCode;
  int? taxPercentage;
  int? taxAmount;
  String? id;

  Item({
    this.propertyName,
    this.unitName,
    this.priceLevel,
    this.quantity,
    this.rate,
    this.amount,
    this.description,
    this.department,
    this.discount,
    this.propertyServiceType,
    this.generateInvoice,
    this.generateSchedule,
    this.item,
    this.grossAmount,
    this.unitSegment,
    this.buildingSegment,
    this.taxCode,
    this.taxPercentage,
    this.taxAmount,
    this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        propertyName: json["propertyName"],
        unitName: json["unitName"],
        priceLevel: json["priceLevel"],
        quantity: parseInt(json["quantity"]),
        rate: parseDouble(json["rate"]),
        amount: parseDouble(json["amount"]),
        description: json["description"],
        department: json["department"],
        discount: parseInt(json["discount"]),
        propertyServiceType: json["propertyServiceType"],
        generateInvoice: json["generateInvoice"],
        generateSchedule: json["generateSchedule"],
        item: json["item"],
        grossAmount: parseInt(json["grossAmount"]),
        unitSegment: json["unitSegment"],
        buildingSegment: json["buildingSegment"],
        taxCode: json["taxCode"],
        taxPercentage: parseInt(json["taxPercentage"]),
        taxAmount: parseInt(json["taxAmount"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "propertyName": propertyName,
        "unitName": unitName,
        "priceLevel": priceLevel,
        "quantity": quantity,
        "rate": rate,
        "amount": amount,
        "description": description,
        "department": department,
        "discount": discount,
        "propertyServiceType": propertyServiceType,
        "generateInvoice": generateInvoice,
        "generateSchedule": generateSchedule,
        "item": item,
        "grossAmount": grossAmount,
        "unitSegment": unitSegment,
        "buildingSegment": buildingSegment,
        "taxCode": taxCode,
        "taxPercentage": taxPercentage,
        "taxAmount": taxAmount,
        "_id": id,
      };
}

// =================== PricingSchedule ===================
class PricingSchedule {
  int? pricingPercent;
  String? date;
  double? amount;
  Remarks? remarks;
  String? allocate;
  int? autoUniqueNumber;
  String? installment;
  String? installmentNumber;
  String? paymentIntervalMonth;
  PaymentStatus? paymentStatus;
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

  factory PricingSchedule.fromJson(Map<String, dynamic> json) => PricingSchedule(
        pricingPercent: parseInt(json["pricingPercent"]),
        date: json["date"],
        amount: parseDouble(json["amount"]),
        remarks: json["remarks"] == null ? null : remarksValues.map[json["remarks"]],
        allocate: json["allocate"],
        autoUniqueNumber: parseInt(json["autoUniqueNumber"]),
        installment: json["installment"],
        installmentNumber: json["installmentNumber"],
        paymentIntervalMonth: json["paymentIntervalMonth"],
        paymentStatus: json["paymentStatus"] == null
            ? null
            : paymentStatusValues.map[json["paymentStatus"]],
        stageName: json["stageName"],
        paymentIntervalDays: json["paymentIntervalDays"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "pricingPercent": pricingPercent,
        "date": date,
        "amount": amount,
        "remarks": remarks == null ? null : remarksValues.reverse[remarks],
        "allocate": allocate,
        "autoUniqueNumber": autoUniqueNumber,
        "installment": installment,
        "installmentNumber": installmentNumber,
        "paymentIntervalMonth": paymentIntervalMonth,
        "paymentStatus": paymentStatus == null ? null : paymentStatusValues.reverse[paymentStatus],
        "stageName": stageName,
        "paymentIntervalDays": paymentIntervalDays,
        "_id": id,
      };
}

// =================== Enums ===================
enum PaymentStatus { OPEN }

final paymentStatusValues = EnumValues({"Open": PaymentStatus.OPEN});

enum Remarks { FROM_BOOKING_DATE, HAND_OVER, ON_BOOKING }

final remarksValues = EnumValues({
  "From Booking Date": Remarks.FROM_BOOKING_DATE,
  "Hand Over": Remarks.HAND_OVER,
  "On Booking": Remarks.ON_BOOKING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
