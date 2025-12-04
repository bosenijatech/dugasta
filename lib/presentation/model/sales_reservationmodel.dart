


// // To parse this JSON data, do
// //
// //     final salesreservationModel = salesreservationModelFromJson(jsonString);

// import 'dart:convert';

// SalesreservationModel salesreservationModelFromJson(String str) => SalesreservationModel.fromJson(json.decode(str));

// String salesreservationModelToJson(SalesreservationModel data) => json.encode(data.toJson());

// class SalesreservationModel {
//     bool status;
//     String message;
//     List<SalesreservationList> data;

//     SalesreservationModel({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     factory SalesreservationModel.fromJson(Map<String, dynamic> json) => SalesreservationModel(
//         status: json["status"],
//         message: json["message"],
//         data: List<SalesreservationList>.from(json["data"].map((x) => SalesreservationList.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class SalesreservationList {
//     String? id;
//     String? internalId;
//     DateTime? date;
//     String? orderId;
//     String? customerId;
//     String? customerName;
//     String? createdFrom;
//     String? targetRef;
//     String? subsidiary;
//     String? annexure;
//     String? propertyName;
//     String? unitName;
//     String? unitNo;
//     String? unitType;
//     String? buildingSegment;
//     String? unitSegment;
//     int? totalArea;
//     int? finalPricePerSqft;
//     String? salesRep;
//     String? agentName;
//     String? agent;
//     String? agentOrBroker;
//     String? createdBy;
//     String? leadSource;
//     String? incomeSource;
//     dynamic? cashAmount;
//     String? anticipatedCompletionDate;
//     String? nextApprovalRole;
//     String? approvalStatus;
//     String? reasonForRejection;
//     double? total;
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

//     SalesreservationList({
//          this.id,
//          this.internalId,
//          this.date,
//          this.orderId,
//          this.customerId,
//          this.customerName,
//          this.createdFrom,
//          this.targetRef,
//          this.subsidiary,
//          this.annexure,
//          this.propertyName,
//          this.unitName,
//          this.unitNo,
//          this.unitType,
//          this.buildingSegment,
//          this.unitSegment,
//          this.totalArea,
//          this.finalPricePerSqft,
//          this.salesRep,
//          this.agentName,
//          this.agent,
//          this.agentOrBroker,
//          this.createdBy,
//          this.leadSource,
//          this.incomeSource,
//          this.cashAmount,
//          this.anticipatedCompletionDate,
//          this.nextApprovalRole,
//          this.approvalStatus,
//          this.reasonForRejection,
//          this.total,
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

//     factory SalesreservationList.fromJson(Map<String, dynamic> json) => SalesreservationList(
//         id: json["_id"],
//         internalId: json["internalId"],
//         date: DateTime.parse(json["date"]),
//         orderId: json["orderId"],
//         customerId: json["customerId"],
//         customerName: json["customerName"],
//         createdFrom: json["createdFrom"],
//         targetRef: json["targetRef"],
//         subsidiary: json["subsidiary"],
//         annexure: json["annexure"],
//         propertyName: json["propertyName"],
//         unitName: json["unitName"],
//         unitNo: json["unitNo"],
//         unitType: json["unitType"],
//         buildingSegment: json["buildingSegment"],
//         unitSegment: json["unitSegment"],
//         totalArea: json["totalArea"],
//         finalPricePerSqft: json["finalPricePerSqft"],
//         salesRep: json["salesRep"],
//         agentName: json["AgentName"],
//         agent: json["Agent"],
//         agentOrBroker: json["AgentOrBroker"],
//         createdBy: json["createdBy"],
//         leadSource: json["leadSource"],
//         incomeSource: json["incomeSource"],
//         cashAmount: json["cashAmount"],
//         anticipatedCompletionDate: json["anticipatedCompletionDate"],
//         nextApprovalRole: json["nextApprovalRole"],
//         approvalStatus: json["approvalStatus"],
//         reasonForRejection: json["reasonForRejection"],
//         total: json["total"]?.toDouble(),
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
//         "orderId": orderId,
//         "customerId": customerId,
//         "customerName": customerName,
//         "createdFrom": createdFrom,
//         "targetRef": targetRef,
//         "subsidiary": subsidiary,
//         "annexure": annexure,
//         "propertyName": propertyName,
//         "unitName": unitName,
//         "unitNo": unitNo,
//         "unitType": unitType,
//         "buildingSegment": buildingSegment,
//         "unitSegment": unitSegment,
//         "totalArea": totalArea,
//         "finalPricePerSqft": finalPricePerSqft,
//         "salesRep": salesRep,
//         "AgentName": agentName,
//         "Agent": agent,
//         "AgentOrBroker": agentOrBroker,
//         "createdBy": createdBy,
//         "leadSource": leadSource,
//         "incomeSource": incomeSource,
//         "cashAmount": cashAmount,
//         "anticipatedCompletionDate": anticipatedCompletionDate,
//         "nextApprovalRole": nextApprovalRole,
//         "approvalStatus": approvalStatus,
//         "reasonForRejection": reasonForRejection,
//         "total": total,
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
//     String? description;
//     String? department;
//     int? discount;
//     int? discountPercentage;
//     int? discountAmount;
//     String? serviceInvoice;
//     PropertyServiceType? propertyServiceType;
//     String? generateInvoice;
//     String? generateSchedule;
//     String? item;
//     int? grossAmount;
//     String? unitSegment;
//     String? buildingSegment;
//     String? taxCode;
//     int? taxPercentage;
//     int? taxAmount;
//     int? estimatedGrossProfit;
//     int? estimatedGrossPercent;
//     String? id;

//     Item({
//          this.description,
//          this.department,
//          this.discount,
//          this.discountPercentage,
//          this.discountAmount,
//          this.serviceInvoice,
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
//          this.estimatedGrossProfit,
//          this.estimatedGrossPercent,
//          this.id,
//     });

//     factory Item.fromJson(Map<String, dynamic> json) => Item(
//         description: json["description"],
//         department: json["department"],
//         discount: json["discount"],
//         discountPercentage: json["discountPercentage"],
//         discountAmount: json["discountAmount"],
//         serviceInvoice: json["serviceInvoice"],
//         propertyServiceType: propertyServiceTypeValues.map[json["propertyServiceType"]]!,
//         generateInvoice: json["generateInvoice"],
//         generateSchedule: json["generateSchedule"],
//         item: json["item"],
//         grossAmount: json["grossAmount"],
//         unitSegment: json["unitSegment"],
//         buildingSegment: json["buildingSegment"],
//         taxCode: json["taxCode"],
//         taxPercentage: json["taxPercentage"],
//         taxAmount: json["taxAmount"],
//         estimatedGrossProfit: json["estimatedGrossProfit"],
//         estimatedGrossPercent: json["estimatedGrossPercent"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "description": description,
//         "department": department,
//         "discount": discount,
//         "discountPercentage": discountPercentage,
//         "discountAmount": discountAmount,
//         "serviceInvoice": serviceInvoice,
//         "propertyServiceType": propertyServiceTypeValues.reverse[propertyServiceType],
//         "generateInvoice": generateInvoice,
//         "generateSchedule": generateSchedule,
//         "item": item,
//         "grossAmount": grossAmount,
//         "unitSegment": unitSegment,
//         "buildingSegment": buildingSegment,
//         "taxCode": taxCode,
//         "taxPercentage": taxPercentage,
//         "taxAmount": taxAmount,
//         "estimatedGrossProfit": estimatedGrossProfit,
//         "estimatedGrossPercent": estimatedGrossPercent,
//         "_id": id,
//     };
// }

// enum PropertyServiceType {
//     ADDITIONAL_CHARGES,
//     PROPERTY_SALES
// }

// final propertyServiceTypeValues = EnumValues({
//     "Additional Charges": PropertyServiceType.ADDITIONAL_CHARGES,
//     "Property Sales": PropertyServiceType.PROPERTY_SALES
// });

// class PricingSchedule {
//     int? pricingPercent;
//     String? date;
//     double? amount;
//     String? remarks;
//     String? allocate;
//     int? autoUniqueNumber;
//     String? installment;
//     String? installmentNumber;
//     String? paymentIntervalMonth;
//     String? paymentStatus;
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
//         remarks:  json["remarks"],
//         allocate: json["allocate"],
//         autoUniqueNumber: json["autoUniqueNumber"],
//         installment: json["installment"],
//         installmentNumber: json["installmentNumber"],
//         paymentIntervalMonth: json["paymentIntervalMonth"],
//         paymentStatus: json["paymentStatus"],
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



// // To parse this JSON data, do
// //
// //     final salesReservationModel = salesReservationModelFromJson(jsonString);

// import 'dart:convert';

// // ====================== Model ======================
// SalesreservationModel salesReservationModelFromJson(String str) =>
//     SalesreservationModel.fromJson(json.decode(str));

// String salesReservationModelToJson(SalesreservationModel data) =>
//     json.encode(data.toJson());

// class SalesreservationModel {
//   bool status;
//   String message;
//   List<SalesreservationList> data;

//   SalesreservationModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory SalesreservationModel.fromJson(Map<String, dynamic> json) =>
//       SalesreservationModel(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<SalesreservationList>.from(
//                 json["data"].map((x) => SalesreservationList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class SalesreservationList {
//   String? id;
//   String? internalId;
//   DateTime? date;
//   String? orderId;
//   String? customerId;
//   String? customerName;
//   String? createdFrom;
//   String? targetRef;
//   String? subsidiary;
//   String? annexure;
//   String? propertyName;
//   String? unitName;
//   String? unitNo;
//   String? unitType;
//   String? buildingSegment;
//   String? unitSegment;
//   int? totalArea;
//   int? finalPricePerSqft;
//   String? salesRep;
//   String? agentName;
//   String? agent;
//   String? agentOrBroker;
//   String? createdBy;
//   String? leadSource;
//   String? incomeSource;
//   dynamic cashAmount;
//   String? anticipatedCompletionDate;
//   String? nextApprovalRole;
//   String? approvalStatus;
//   String? reasonForRejection;
//   double? total;
//   String? planType;
//   String? schemeType;
//   String? pricingPlanName;
//   String? benefits;
//   String? serviceChargesWaiver;
//   String? buyBac;
//   String? rentalGuarantee;
//   List<Item>? items;
//   List<PricingSchedule>? pricingSchedule;
//   int? v;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   SalesreservationList({
//     this.id,
//     this.internalId,
//     this.date,
//     this.orderId,
//     this.customerId,
//     this.customerName,
//     this.createdFrom,
//     this.targetRef,
//     this.subsidiary,
//     this.annexure,
//     this.propertyName,
//     this.unitName,
//     this.unitNo,
//     this.unitType,
//     this.buildingSegment,
//     this.unitSegment,
//     this.totalArea,
//     this.finalPricePerSqft,
//     this.salesRep,
//     this.agentName,
//     this.agent,
//     this.agentOrBroker,
//     this.createdBy,
//     this.leadSource,
//     this.incomeSource,
//     this.cashAmount,
//     this.anticipatedCompletionDate,
//     this.nextApprovalRole,
//     this.approvalStatus,
//     this.reasonForRejection,
//     this.total,
//     this.planType,
//     this.schemeType,
//     this.pricingPlanName,
//     this.benefits,
//     this.serviceChargesWaiver,
//     this.buyBac,
//     this.rentalGuarantee,
//     this.items,
//     this.pricingSchedule,
//     this.v,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory SalesreservationList.fromJson(Map<String, dynamic> json) =>
//       SalesreservationList(
//         id: json["_id"],
//         internalId: json["internalId"],
//         date: json["date"] == null ? null : DateTime.tryParse(json["date"]),
//         orderId: json["orderId"],
//         customerId: json["customerId"],
//         customerName: json["customerName"],
//         createdFrom: json["createdFrom"],
//         targetRef: json["targetRef"],
//         subsidiary: json["subsidiary"],
//         annexure: json["annexure"],
//         propertyName: json["propertyName"],
//         unitName: json["unitName"],
//         unitNo: json["unitNo"],
//         unitType: json["unitType"],
//         buildingSegment: json["buildingSegment"],
//         unitSegment: json["unitSegment"],
//         totalArea: json["totalArea"] == null
//             ? null
//             : int.tryParse(json["totalArea"].toString()),
//         finalPricePerSqft: json["finalPricePerSqft"] == null
//             ? null
//             : int.tryParse(json["finalPricePerSqft"].toString()),
//         salesRep: json["salesRep"],
//         agentName: json["AgentName"],
//         agent: json["Agent"],
//         agentOrBroker: json["AgentOrBroker"],
//         createdBy: json["createdBy"],
//         leadSource: json["leadSource"],
//         incomeSource: json["incomeSource"],
//         cashAmount: json["cashAmount"],
//         anticipatedCompletionDate: json["anticipatedCompletionDate"],
//         nextApprovalRole: json["nextApprovalRole"],
//         approvalStatus: json["approvalStatus"],
//         reasonForRejection: json["reasonForRejection"],
//         total: json["total"] == null
//             ? null
//             : double.tryParse(json["total"].toString()),
//         planType: json["planType"],
//         schemeType: json["schemeType"],
//         pricingPlanName: json["pricingPlanName"],
//         benefits: json["benefits"],
//         serviceChargesWaiver: json["serviceChargesWaiver"],
//         buyBac: json["buyBac"],
//         rentalGuarantee: json["rentalGuarantee"],
//         items: json["items"] == null
//             ? []
//             : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
//         pricingSchedule: json["pricingSchedule"] == null
//             ? []
//             : List<PricingSchedule>.from(
//                 json["pricingSchedule"].map((x) => PricingSchedule.fromJson(x))),
//         v: json["__v"] == null ? null : int.tryParse(json["__v"].toString()),
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.tryParse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.tryParse(json["updatedAt"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "internalId": internalId,
//         "date": date?.toIso8601String(),
//         "orderId": orderId,
//         "customerId": customerId,
//         "customerName": customerName,
//         "createdFrom": createdFrom,
//         "targetRef": targetRef,
//         "subsidiary": subsidiary,
//         "annexure": annexure,
//         "propertyName": propertyName,
//         "unitName": unitName,
//         "unitNo": unitNo,
//         "unitType": unitType,
//         "buildingSegment": buildingSegment,
//         "unitSegment": unitSegment,
//         "totalArea": totalArea,
//         "finalPricePerSqft": finalPricePerSqft,
//         "salesRep": salesRep,
//         "AgentName": agentName,
//         "Agent": agent,
//         "AgentOrBroker": agentOrBroker,
//         "createdBy": createdBy,
//         "leadSource": leadSource,
//         "incomeSource": incomeSource,
//         "cashAmount": cashAmount,
//         "anticipatedCompletionDate": anticipatedCompletionDate,
//         "nextApprovalRole": nextApprovalRole,
//         "approvalStatus": approvalStatus,
//         "reasonForRejection": reasonForRejection,
//         "total": total,
//         "planType": planType,
//         "schemeType": schemeType,
//         "pricingPlanName": pricingPlanName,
//         "benefits": benefits,
//         "serviceChargesWaiver": serviceChargesWaiver,
//         "buyBac": buyBac,
//         "rentalGuarantee": rentalGuarantee,
//         "items": items?.map((x) => x.toJson()).toList(),
//         "pricingSchedule": pricingSchedule?.map((x) => x.toJson()).toList(),
//         "__v": v,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//       };
// }

// // ====================== Item ======================

// class Item {
//   String? description;
//   String? department;
//   int? discount;
//   int? discountPercentage;
//   int? discountAmount;
//   String? serviceInvoice;
//   String? propertyName;
//   String? unitName;
//   PropertyServiceType? propertyServiceType;
//   String? generateInvoice;
//   String? generateSchedule;
//   String? item;
//   int? grossAmount;
//   String? unitSegment;
//   String? buildingSegment;
//   String? taxCode;
//   int? taxPercentage;
//   int? taxAmount;
//   int? estimatedGrossProfit;
//   int? estimatedGrossPercent;
//   String? id;

//   Item({
//     this.description,
//     this.department,
//     this.discount,
//     this.discountPercentage,
//     this.discountAmount,
//     this.serviceInvoice,
//     this.propertyServiceType,
//     this.generateInvoice,
//     this.generateSchedule,
//     this.item,
//     this.grossAmount,
//     this.unitSegment,
//     this.buildingSegment,
//     this.taxCode,
//     this.taxPercentage,
//     this.taxAmount,
//     this.estimatedGrossProfit,
//     this.estimatedGrossPercent,
//     this.propertyName,
//     this.unitName,
//     this.id,
//   });

//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//         description: json["description"],
//         department: json["department"],
//         discount: json["discount"] == null
//             ? null
//             : int.tryParse(json["discount"].toString()),
//         discountPercentage: json["discountPercentage"] == null
//             ? null
//             : int.tryParse(json["discountPercentage"].toString()),
//         discountAmount: json["discountAmount"] == null
//             ? null
//             : int.tryParse(json["discountAmount"].toString()),
//         serviceInvoice: json["serviceInvoice"],
//         propertyServiceType:
//             propertyServiceTypeValues.map[json["propertyServiceType"]],
//         generateInvoice: json["generateInvoice"],
//         propertyName: json["propertyName"],
//         unitName: json["unitName"],
//         generateSchedule: json["generateSchedule"],
//         item: json["item"],
//         grossAmount: json["grossAmount"] == null
//             ? null
//             : int.tryParse(json["grossAmount"].toString()),
//         unitSegment: json["unitSegment"],
//         buildingSegment: json["buildingSegment"],
//         taxCode: json["taxCode"],
//         taxPercentage: json["taxPercentage"] == null
//             ? null
//             : int.tryParse(json["taxPercentage"].toString()),
//         taxAmount: json["taxAmount"] == null
//             ? null
//             : int.tryParse(json["taxAmount"].toString()),
//         estimatedGrossProfit: json["estimatedGrossProfit"] == null
//             ? null
//             : int.tryParse(json["estimatedGrossProfit"].toString()),
//         estimatedGrossPercent: json["estimatedGrossPercent"] == null
//             ? null
//             : int.tryParse(json["estimatedGrossPercent"].toString()),
//         id: json["_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "description": description,
//         "department": department,
//         "discount": discount,
//         "discountPercentage": discountPercentage,
//         "discountAmount": discountAmount,
//         "serviceInvoice": serviceInvoice,
//         "propertyServiceType":
//             propertyServiceTypeValues.reverse[propertyServiceType],
//         "generateInvoice": generateInvoice,
//         "generateSchedule": generateSchedule,
//         "item": item,
//         "propertyName": propertyName,
//         "unitName": unitName,
//         "grossAmount": grossAmount,
//         "unitSegment": unitSegment,
//         "buildingSegment": buildingSegment,
//         "taxCode": taxCode,
//         "taxPercentage": taxPercentage,
//         "taxAmount": taxAmount,
//         "estimatedGrossProfit": estimatedGrossProfit,
//         "estimatedGrossPercent": estimatedGrossPercent,
//         "_id": id,
//       };
// }

// enum PropertyServiceType { ADDITIONAL_CHARGES, PROPERTY_SALES }

// final propertyServiceTypeValues = EnumValues({
//   "Additional Charges": PropertyServiceType.ADDITIONAL_CHARGES,
//   "Property Sales": PropertyServiceType.PROPERTY_SALES
// });

// // ====================== Pricing Schedule ======================
// class PricingSchedule {
//   int? pricingPercent;
//   String? date;
//   double? amount;
//   String? remarks;
//   String? allocate;
//   int? autoUniqueNumber;
//   String? installment;
//   String? installmentNumber;
//   String? paymentIntervalMonth;
//   String? paymentStatus;
//   String? stageName;
//   String? paymentIntervalDays;
//   String? id;

//   PricingSchedule({
//     this.pricingPercent,
//     this.date,
//     this.amount,
//     this.remarks,
//     this.allocate,
//     this.autoUniqueNumber,
//     this.installment,
//     this.installmentNumber,
//     this.paymentIntervalMonth,
//     this.paymentStatus,
//     this.stageName,
//     this.paymentIntervalDays,
//     this.id,
//   });

//   factory PricingSchedule.fromJson(Map<String, dynamic> json) => PricingSchedule(
//         pricingPercent: json["pricingPercent"] == null
//             ? null
//             : int.tryParse(json["pricingPercent"].toString()),
//         date: json["date"],
//         amount: json["amount"] == null
//             ? null
//             : double.tryParse(json["amount"].toString()),
//         remarks: json["remarks"],
//         allocate: json["allocate"],
//         autoUniqueNumber: json["autoUniqueNumber"] == null
//             ? null
//             : int.tryParse(json["autoUniqueNumber"].toString()),
//         installment: json["installment"],
//         installmentNumber: json["installmentNumber"],
//         paymentIntervalMonth: json["paymentIntervalMonth"],
//         paymentStatus: json["paymentStatus"],
//         stageName: json["stageName"],
//         paymentIntervalDays: json["paymentIntervalDays"],
//         id: json["_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "pricingPercent": pricingPercent,
//         "date": date,
//         "amount": amount,
//         "remarks": remarks,
//         "allocate": allocate,
//         "autoUniqueNumber": autoUniqueNumber,
//         "installment": installment,
//         "installmentNumber": installmentNumber,
//         "paymentIntervalMonth": paymentIntervalMonth,
//         "paymentStatus": paymentStatus,
//         "stageName": stageName,
//         "paymentIntervalDays": paymentIntervalDays,
//         "_id": id,
//       };
// }

// // ====================== Enum Helper ======================
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }



import 'dart:convert';

SalesreservationModel salesReservationModelFromJson(String str) =>
    SalesreservationModel.fromJson(json.decode(str));

String salesReservationModelToJson(SalesreservationModel data) =>
    json.encode(data.toJson());

// =========================================================
// MAIN MODEL
// =========================================================
class SalesreservationModel {
  bool status;
  String message;
  List<SalesreservationList> data;

  SalesreservationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SalesreservationModel.fromJson(Map<String, dynamic> json) =>
      SalesreservationModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] == null
            ? []
            : List<SalesreservationList>.from(
                json["data"].map((x) => SalesreservationList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

// =========================================================
// RESERVATION LIST
// =========================================================
class SalesreservationList {
  String? id;
  String? internalId;
  DateTime? date;
  String? orderId;
  String? customerId;
  String? customerName;
  String? createdFrom;
  String? targetRef;
  String? subsidiary;
  String? annexure;
  String? propertyName;
  String? unitName;
  String? unitNo;
  String? unitType;
  String? buildingSegment;
  String? unitSegment;
  double? totalArea;
  double? finalPricePerSqft;
  String? salesRep;
  String? agentName;
  String? agent;
  String? agentOrBroker;
  String? createdBy;
  String? leadSource;
  String? incomeSource;
  dynamic cashAmount;
  String? anticipatedCompletionDate;
  String? nextApprovalRole;
  String? approvalStatus;
  String? reasonForRejection;
  double? total;
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

  SalesreservationList({
    this.id,
    this.internalId,
    this.date,
    this.orderId,
    this.customerId,
    this.customerName,
    this.createdFrom,
    this.targetRef,
    this.subsidiary,
    this.annexure,
    this.propertyName,
    this.unitName,
    this.unitNo,
    this.unitType,
    this.buildingSegment,
    this.unitSegment,
    this.totalArea,
    this.finalPricePerSqft,
    this.salesRep,
    this.agentName,
    this.agent,
    this.agentOrBroker,
    this.createdBy,
    this.leadSource,
    this.incomeSource,
    this.cashAmount,
    this.anticipatedCompletionDate,
    this.nextApprovalRole,
    this.approvalStatus,
    this.reasonForRejection,
    this.total,
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

  factory SalesreservationList.fromJson(Map<String, dynamic> json) =>
      SalesreservationList(
        id: json["_id"],
        internalId: json["internalId"],
        date: json["date"] == null ? null : DateTime.tryParse(json["date"]),
        orderId: json["orderId"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        createdFrom: json["createdFrom"],
        targetRef: json["targetRef"],
        subsidiary: json["subsidiary"],
        annexure: json["annexure"],

        // FIXED FIELDS (always show)
        propertyName: json["propertyName"]?.toString() ?? "",
        unitName: json["unitName"]?.toString() ?? "",

        unitNo: json["unitNo"],
        unitType: json["unitType"],
        buildingSegment: json["buildingSegment"],
        unitSegment: json["unitSegment"],

        // SAFE NUMBER PARSING
        totalArea: _toDouble(json["totalArea"]),
        finalPricePerSqft: _toDouble(json["finalPricePerSqft"]),

        salesRep: json["salesRep"],
        agentName: json["AgentName"],
        agent: json["Agent"],
        agentOrBroker: json["AgentOrBroker"],
        createdBy: json["createdBy"],
        leadSource: json["leadSource"],
        incomeSource: json["incomeSource"],
        cashAmount: json["cashAmount"],
        anticipatedCompletionDate: json["anticipatedCompletionDate"],
        nextApprovalRole: json["nextApprovalRole"],
        approvalStatus: json["approvalStatus"],
        reasonForRejection: json["reasonForRejection"],
        total: _toDouble(json["total"]),

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
                json["pricingSchedule"].map((x) => PricingSchedule.fromJson(x)),
              ),

        v: json["__v"] == null ? null : int.tryParse(json["__v"].toString()),
        createdAt:
            json["createdAt"] == null ? null : DateTime.tryParse(json["createdAt"]),
        updatedAt:
            json["updatedAt"] == null ? null : DateTime.tryParse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "internalId": internalId,
        "date": date?.toIso8601String(),
        "orderId": orderId,
        "customerId": customerId,
        "customerName": customerName,
        "createdFrom": createdFrom,
        "targetRef": targetRef,
        "subsidiary": subsidiary,
        "annexure": annexure,
        "propertyName": propertyName,
        "unitName": unitName,
        "unitNo": unitNo,
        "unitType": unitType,
        "buildingSegment": buildingSegment,
        "unitSegment": unitSegment,
        "totalArea": totalArea,
        "finalPricePerSqft": finalPricePerSqft,
        "salesRep": salesRep,
        "AgentName": agentName,
        "Agent": agent,
        "AgentOrBroker": agentOrBroker,
        "createdBy": createdBy,
        "leadSource": leadSource,
        "incomeSource": incomeSource,
        "cashAmount": cashAmount,
        "anticipatedCompletionDate": anticipatedCompletionDate,
        "nextApprovalRole": nextApprovalRole,
        "approvalStatus": approvalStatus,
        "reasonForRejection": reasonForRejection,
        "total": total,
        "planType": planType,
        "schemeType": schemeType,
        "pricingPlanName": pricingPlanName,
        "benefits": benefits,
        "serviceChargesWaiver": serviceChargesWaiver,
        "buyBac": buyBac,
        "rentalGuarantee": rentalGuarantee,
        "items": items?.map((x) => x.toJson()).toList(),
        "pricingSchedule": pricingSchedule?.map((x) => x.toJson()).toList(),
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

// =========================================================
// ITEM MODEL
// =========================================================
class Item {
  String? description;
  String? department;
  double? discount;
  double? discountPercentage;
  double? discountAmount;
  String? serviceInvoice;
  String? propertyName;
  String? unitName;
  PropertyServiceType? propertyServiceType;
  String? generateInvoice;
  String? generateSchedule;
  String? item;
  double? grossAmount;
  String? unitSegment;
  String? buildingSegment;
  String? taxCode;
  double? taxPercentage;
  double? taxAmount;
  double? estimatedGrossProfit;
  double? estimatedGrossPercent;
  String? id;

  Item({
    this.description,
    this.department,
    this.discount,
    this.discountPercentage,
    this.discountAmount,
    this.serviceInvoice,
    this.propertyName,
    this.unitName,
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
    this.estimatedGrossProfit,
    this.estimatedGrossPercent,
    this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        description: json["description"],
        department: json["department"],
        discount: _toDouble(json["discount"]),
        discountPercentage: _toDouble(json["discountPercentage"]),
        discountAmount: _toDouble(json["discountAmount"]),
        serviceInvoice: json["serviceInvoice"],
        propertyServiceType:
            propertyServiceTypeValues.map[json["propertyServiceType"]],
        generateInvoice: json["generateInvoice"],
        propertyName: json["propertyName"],
        unitName: json["unitName"],
        generateSchedule: json["generateSchedule"],
        item: json["item"],
        grossAmount: _toDouble(json["grossAmount"]),
        unitSegment: json["unitSegment"],
        buildingSegment: json["buildingSegment"],
        taxCode: json["taxCode"],
        taxPercentage: _toDouble(json["taxPercentage"]),
        taxAmount: _toDouble(json["taxAmount"]),
        estimatedGrossProfit: _toDouble(json["estimatedGrossProfit"]),
        estimatedGrossPercent: _toDouble(json["estimatedGrossPercent"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "department": department,
        "discount": discount,
        "discountPercentage": discountPercentage,
        "discountAmount": discountAmount,
        "serviceInvoice": serviceInvoice,
        "propertyServiceType":
            propertyServiceTypeValues.reverse[propertyServiceType],
        "generateInvoice": generateInvoice,
        "generateSchedule": generateSchedule,
        "item": item,
        "propertyName": propertyName,
        "unitName": unitName,
        "grossAmount": grossAmount,
        "unitSegment": unitSegment,
        "buildingSegment": buildingSegment,
        "taxCode": taxCode,
        "taxPercentage": taxPercentage,
        "taxAmount": taxAmount,
        "estimatedGrossProfit": estimatedGrossProfit,
        "estimatedGrossPercent": estimatedGrossPercent,
        "_id": id,
      };
}

// =========================================================
// PRICING SCHEDULE
// =========================================================
class PricingSchedule {
  double? pricingPercent;
  String? date;
  double? amount;
  String? remarks;
  String? allocate;
  double? autoUniqueNumber;
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
        pricingPercent: _toDouble(json["pricingPercent"]),
        date: json["date"],
        amount: _toDouble(json["amount"]),
        remarks: json["remarks"],
        allocate: json["allocate"],
        autoUniqueNumber: _toDouble(json["autoUniqueNumber"]),
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

// =========================================================
// ENUMS
// =========================================================
enum PropertyServiceType { ADDITIONAL_CHARGES, PROPERTY_SALES }

final propertyServiceTypeValues = EnumValues({
  "Additional Charges": PropertyServiceType.ADDITIONAL_CHARGES,
  "Property Sales": PropertyServiceType.PROPERTY_SALES
});

// =========================================================
// ENUM HELPER
// =========================================================
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// =========================================================
// UNIVERSAL SAFE DOUBLE PARSER
// =========================================================
double? _toDouble(dynamic value) {
  if (value == null) return null;

  if (value is int) return value.toDouble();
  if (value is double) return value;

  final s = value.toString().trim();
  if (s.isEmpty || s == "null") return null;

  return double.tryParse(s);
}
