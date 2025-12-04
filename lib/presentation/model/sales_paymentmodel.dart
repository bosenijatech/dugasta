


// To parse this JSON data, do
//
//     final salespaymentdetailsModel = salespaymentdetailsModelFromJson(jsonString);

import 'dart:convert';

SalespaymentdetailsModel salespaymentdetailsModelFromJson(String str) => SalespaymentdetailsModel.fromJson(json.decode(str));

String salespaymentdetailsModelToJson(SalespaymentdetailsModel data) => json.encode(data.toJson());

class SalespaymentdetailsModel {
    bool status;
    String message;
    List<SalespaymentList> data;

    SalespaymentdetailsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory SalespaymentdetailsModel.fromJson(Map<String, dynamic> json) => SalespaymentdetailsModel(
        status: json["status"],
        message: json["message"],
        data: List<SalespaymentList>.from(json["data"].map((x) => SalespaymentList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class SalespaymentList {
    String? id;
    String? internalId;
    DateTime? date;
    String? customerId;
    String? customerName;
    Subsidiary? subsidiary;
    EdBy? receivedBy;
    CustomerType? customerType;
    ReceivablesAccount? receivablesAccount;
    bool? receiptCreated;
    ReceiptType? receiptType;
    String? paymentType;
    String? transactionType;
    double? contractValue;
    String? buildingName;
    Unit? unitName;
    String? contractBasis;
    String? approvalStatus;
    EdBy? createdBy;
    int? v;
    List<DetailsInfo>? detailsInfo;

    SalespaymentList({
         this.id,
         this.internalId,
         this.date,
         this.customerId,
         this.customerName,
         this.subsidiary,
         this.receivedBy,
         this.customerType,
         this.receivablesAccount,
         this.receiptCreated,
         this.receiptType,
         this.paymentType,
         this.transactionType,
         this.contractValue,
         this.buildingName,
         this.unitName,
         this.contractBasis,
         this.approvalStatus,
         this.createdBy,
         this.v,
         this.detailsInfo,
    });

    factory SalespaymentList.fromJson(Map<String, dynamic> json) => SalespaymentList(
        id: json["_id"],
        internalId: json["internalId"],
        date: DateTime.parse(json["date"]),
        customerId: json["customerId"],
        customerName: json["customerName"],
        subsidiary: subsidiaryValues.map[json["subsidiary"]]!,
        receivedBy: edByValues.map[json["receivedBy"]]!,
        customerType: customerTypeValues.map[json["customerType"]]!,
        receivablesAccount: receivablesAccountValues.map[json["receivablesAccount"]]!,
        receiptCreated: json["receiptCreated"],
        receiptType: receiptTypeValues.map[json["receiptType"]]!,
        paymentType: json["paymentType"],
        transactionType: json["transactionType"],
        contractValue: json["contractValue"]?.toDouble(),
        buildingName:json["buildingName"],
        unitName: unitValues.map[json["unitName"]]!,
        contractBasis: json["contractBasis"],
        approvalStatus: json["approvalStatus"],
        createdBy: edByValues.map[json["createdBy"]]!,
        v: json["__v"],
        detailsInfo: List<DetailsInfo>.from(json["detailsInfo"].map((x) => DetailsInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "internalId": internalId,
        "date": date!.toIso8601String(),
        "customerId": customerId,
        "customerName": customerValues.reverse[customerName],
        "subsidiary": subsidiaryValues.reverse[subsidiary],
        "receivedBy": edByValues.reverse[receivedBy],
        "customerType": customerTypeValues.reverse[customerType],
        "receivablesAccount": receivablesAccountValues.reverse[receivablesAccount],
        "receiptCreated": receiptCreated,
        "receiptType": receiptTypeValues.reverse[receiptType],
        "paymentType": paymentType,
        "transactionType":transactionType,
        "contractValue": contractValue,
        "buildingName":buildingName,
        "unitName": unitValues.reverse[unitName],
        "contractBasis": contractBasis,
        "approvalStatus": approvalStatus,
        "createdBy": edByValues.reverse[createdBy],
        "__v": v,
        "detailsInfo": List<dynamic>.from(detailsInfo!.map((x) => x.toJson())),
    };
}






enum EdBy {
    FAHAD_ABDUL_KADIR_FAQUI,
    NOMAN_ALI
}

final edByValues = EnumValues({
    "Fahad Abdul Kadir Faqui": EdBy.FAHAD_ABDUL_KADIR_FAQUI,
    "Noman  Ali": EdBy.NOMAN_ALI
});

enum Customer {
    THE_2129_GANGADHAR_SOMASUNDAR_RAJU
}

final customerValues = EnumValues({
    "2129 Gangadhar Somasundar Raju": Customer.THE_2129_GANGADHAR_SOMASUNDAR_RAJU
});

enum CustomerType {
    SALES
}

final customerTypeValues = EnumValues({
    "Sales": CustomerType.SALES
});

class DetailsInfo {
    String? id;
    String? installmentType;
    String? paymentReceipt;
    String? paymentMode;
    AccountCode? accountCode;
    String? checkReferenceNo;
    dynamic? checkReferenceDate;
    double? amount;
    String? customerBank;
    String? bankTransferJournal;
    String? journalEntry;
    String? relatedPaymentReceipt;
    Subsidiary? subsidiary;
    Customer? customer;
    String? remarks1;
    String? remarks;
    List<Unit>? unit;
    String? onAccount;
    dynamic? holdDate;
    String? checkStatus;
    dynamic? paymentAmount;
    String? invoiceAllocation;
    Contract? contract;
    bool? isApplied;
    bool? receiptCreated;
    String? errorMessage;
    bool? movementProcessed;
    String? remark;
    String? receivableAccount;
    bool? allocationProcessed;
    String? bankReferenceNumber;
    dynamic? bankRefDate;
    dynamic? chequeClearedDate;
    dynamic? chequeBouncedDate;
    String? cancelledPrd;
    String? cancellationInvoice;
    dynamic? relatedPaymentReceiptDate;
    String? psId;
    Unit? unitSegment;
    String? buildingSegment;
    int? v;
    DateTime? createdAt;
    DateTime? updatedAt;

    DetailsInfo({
         this.id,
         this.installmentType,
         this.paymentReceipt,
         this.paymentMode,
         this.accountCode,
         this.checkReferenceNo,
         this.checkReferenceDate,
         this.amount,
         this.customerBank,
         this.bankTransferJournal,
         this.journalEntry,
         this.relatedPaymentReceipt,
         this.subsidiary,
         this.customer,
         this.remarks1,
         this.remarks,
         this.unit,
         this.onAccount,
         this.holdDate,
         this.checkStatus,
         this.paymentAmount,
         this.invoiceAllocation,
         this.contract,
         this.isApplied,
         this.receiptCreated,
         this.errorMessage,
         this.movementProcessed,
         this.remark,
         this.receivableAccount,
         this.allocationProcessed,
         this.bankReferenceNumber,
         this.bankRefDate,
         this.chequeClearedDate,
         this.chequeBouncedDate,
         this.cancelledPrd,
         this.cancellationInvoice,
         this.relatedPaymentReceiptDate,
         this.psId,
         this.unitSegment,
         this.buildingSegment,
         this.v,
         this.createdAt,
         this.updatedAt,
    });

    factory DetailsInfo.fromJson(Map<String, dynamic> json) => DetailsInfo(
        id: json["_id"],
        installmentType:json["installmentType"],
        paymentReceipt: json["paymentReceipt"],
        paymentMode:json["paymentMode"],
        accountCode: accountCodeValues.map[json["accountCode"]]!,
        checkReferenceNo: json["checkReferenceNo"],
        checkReferenceDate: json["checkReferenceDate"],
        amount: json["amount"]?.toDouble(),
        customerBank: json["customerBank"],
        bankTransferJournal: json["bankTransferJournal"],
        journalEntry: json["journalEntry"],
        relatedPaymentReceipt: json["relatedPaymentReceipt"],
        subsidiary: subsidiaryValues.map[json["subsidiary"]]!,
        customer: customerValues.map[json["customer"]]!,
        remarks1: json["remarks1"],
        remarks: json["remarks"],
        unit: List<Unit>.from(json["unit"].map((x) => unitValues.map[x]!)),
        onAccount: json["onAccount"],
        holdDate: json["holdDate"],
        checkStatus: json["checkStatus"],
        paymentAmount: json["paymentAmount"],
        invoiceAllocation: json["invoiceAllocation"],
        contract: contractValues.map[json["contract"]]!,
        isApplied: json["isApplied"],
        receiptCreated: json["receiptCreated"],
        errorMessage: json["errorMessage"],
        movementProcessed: json["movementProcessed"],
        remark: json["remark"],
        receivableAccount: json["receivableAccount"],
        allocationProcessed: json["allocationProcessed"],
        bankReferenceNumber: json["bankReferenceNumber"],
        bankRefDate: json["bankRefDate"],
        chequeClearedDate: json["chequeClearedDate"],
        chequeBouncedDate: json["chequeBouncedDate"],
        cancelledPrd: json["cancelledPRD"],
        cancellationInvoice: json["cancellationInvoice"],
        relatedPaymentReceiptDate: json["relatedPaymentReceiptDate"],
        psId: json["psId"],
        unitSegment: unitValues.map[json["unitSegment"]]!,
        buildingSegment: json["buildingSegment"],
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "installmentType": installmentType,
        "paymentReceipt": paymentReceipt,
        "paymentMode": paymentMode,
        "accountCode": accountCodeValues.reverse[accountCode],
        "checkReferenceNo": checkReferenceNo,
        "checkReferenceDate": checkReferenceDate,
        "amount": amount,
        "customerBank": customerBank,
        "bankTransferJournal": bankTransferJournal,
        "journalEntry": journalEntry,
        "relatedPaymentReceipt": relatedPaymentReceipt,
        "subsidiary": subsidiaryValues.reverse[subsidiary],
        "customer": customerValues.reverse[customer],
        "remarks1": remarks1,
        "remarks": remarks,
        "unit": List<dynamic>.from(unit!.map((x) => unitValues.reverse[x])),
        "onAccount": onAccount,
        "holdDate": holdDate,
        "checkStatus": checkStatus,
        "paymentAmount": paymentAmount,
        "invoiceAllocation": invoiceAllocation,
        "contract": contractValues.reverse[contract],
        "isApplied": isApplied,
        "receiptCreated": receiptCreated,
        "errorMessage": errorMessage,
        "movementProcessed": movementProcessed,
        "remark": remark,
        "receivableAccount": receivableAccount,
        "allocationProcessed": allocationProcessed,
        "bankReferenceNumber": bankReferenceNumber,
        "bankRefDate": bankRefDate,
        "chequeClearedDate": chequeClearedDate,
        "chequeBouncedDate": chequeBouncedDate,
        "cancelledPRD": cancelledPrd,
        "cancellationInvoice": cancellationInvoice,
        "relatedPaymentReceiptDate": relatedPaymentReceiptDate,
        "psId": psId,
        "unitSegment": unitValues.reverse[unitSegment],
        "buildingSegment": buildingSegment,
        "__v": v,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
    };
}

enum AccountCode {
    THE_11101004_CASH_COLLECTION_OFF_PLAN_BUILDINGS
}

final accountCodeValues = EnumValues({
    "11101004 Cash Collection - Off Plan Buildings": AccountCode.THE_11101004_CASH_COLLECTION_OFF_PLAN_BUILDINGS
});



enum Contract {
    RESERVATION_FORM_DPD_RF_062500004,
    RESERVATION_FORM_DPD_RF_072500097,
    RESERVATION_FORM_DPD_RF_072500098
}

final contractValues = EnumValues({
    "Reservation Form #DPD/RF-06-25/00004": Contract.RESERVATION_FORM_DPD_RF_062500004,
    "Reservation Form #DPD/RF-07-25/00097": Contract.RESERVATION_FORM_DPD_RF_072500097,
    "Reservation Form #DPD/RF-07-25/00098": Contract.RESERVATION_FORM_DPD_RF_072500098
});




enum Subsidiary {
    DUGASTA_HOLDING_DUGASTA_PROPERTIES_DEVELOPMENT
}

final subsidiaryValues = EnumValues({
    "DUGASTA HOLDING : DUGASTA PROPERTIES DEVELOPMENT": Subsidiary.DUGASTA_HOLDING_DUGASTA_PROPERTIES_DEVELOPMENT
});

enum Unit {
    AHR4_350,
    AHR4_440,
    EMPTY
}

final unitValues = EnumValues({
    "AHR4 - 350": Unit.AHR4_350,
    "AHR4 - 440": Unit.AHR4_440,
    "": Unit.EMPTY
});




enum ReceiptType {
    INSTALLMENTS
}

final receiptTypeValues = EnumValues({
    "Installments": ReceiptType.INSTALLMENTS
});

enum ReceivablesAccount {
    THE_11301001_ACCOUNTS_RECEIVABLE
}

final receivablesAccountValues = EnumValues({
    "11301001 Accounts Receivable": ReceivablesAccount.THE_11301001_ACCOUNTS_RECEIVABLE
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
