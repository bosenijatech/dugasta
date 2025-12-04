// class Receipt {
//   final String id;
//   final String receiptId;
//   final int internalId;
//   final String contractName;
//   final String building;
//   final String unitNo;
//   final String receiptNo;
//   final String receiptDate;
//   final double amount;
//   final String contractId;
//   final String tenantId;
//   final String tenantName;
//   final String active;
//   final int isSync;
//   final List<ReceiptDetail> details;

//   Receipt({
//     required this.id,
//     required this.receiptId,
//     required this.internalId,
//     required this.contractName,
//     required this.building,
//     required this.unitNo,
//     required this.receiptNo,
//     required this.receiptDate,
//     required this.amount,
//     required this.contractId,
//     required this.tenantId,
//     required this.tenantName,
//     required this.active,
//     required this.isSync,
//     required this.details,
//   });

//   factory Receipt.fromJson(Map<String, dynamic> json) {
//     var detailList = (json['details'] as List)
//         .map((e) => ReceiptDetail.fromJson(e))
//         .toList();

//     return Receipt(
//       id: json['_id'],
//       receiptId: json['receiptid'].toString(),
//       internalId: json['internalid'],
//       contractName: json['contractname'],
//       building: json['building'],
//       unitNo: json['unitno'],
//       receiptNo: json['receiptno'],
//       receiptDate: json['receiptdate'],
//       amount: (json['amount'] as num).toDouble(),
      
//       contractId: json['contractid'],
//       tenantId: json['tenantid'],
//       tenantName: json['tenantname'],
//       active: json['active'],
//       isSync: json['issync'],
//       details: detailList,
//     );
//   }
// }

// class ReceiptDetail {
//   final String id;
//   final String receiptId;
//   final int internalId;
//   final String receiptDate;
//   final String payMode;
//   final String chequeDate;
//   final String refNo;
//   final double paymentAmount;
//   final String chequeStatus;
//   final int sync;

//   ReceiptDetail({
//     required this.id,
//     required this.receiptId,
//     required this.internalId,
//     required this.receiptDate,
//     required this.payMode,
//     required this.chequeDate,
//     required this.refNo,
//     required this.paymentAmount,
//     required this.chequeStatus,
//     required this.sync,
//   });

//   factory ReceiptDetail.fromJson(Map<String, dynamic> json) {
//     return ReceiptDetail(
//       id: json['_id'],
//       receiptId: json['receiptid'].toString(),
//       internalId: json['internalid'],
//       receiptDate: json['receiptdate'],
//       payMode: json['paymode'],
//       chequeDate: json['chequedate'],
//       refNo: json['refno'],
//       paymentAmount: (json['paymentamount'] as num).toDouble(),
//       chequeStatus: json['chequestatus'],
//       sync: json['Sync'],
//     );
//   }
// }


class Receipt {
  final String id;
  final String receiptId;
  final int internalId;
  final String contractName;
  final String building;
  final String unitNo;
  final String receiptNo;
  final String receiptDate;
  final double amount;
  final String contractId;
  final String tenantId;
  final String tenantName;
  final String active;
  final int isSync;
  final List<ReceiptDetail> details;

  Receipt({
    required this.id,
    required this.receiptId,
    required this.internalId,
    required this.contractName,
    required this.building,
    required this.unitNo,
    required this.receiptNo,
    required this.receiptDate,
    required this.amount,
    required this.contractId,
    required this.tenantId,
    required this.tenantName,
    required this.active,
    required this.isSync,
    required this.details,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    var detailList = (json['details'] as List? ?? [])
        .map((e) => ReceiptDetail.fromJson(e))
        .toList();

    return Receipt(
      id: json['_id']?.toString() ?? '',
      receiptId: json['receiptid']?.toString() ?? '',
      internalId: json['internalid'] ?? 0,
      contractName: json['contractname'] ?? '',
      building: json['building'] ?? '',
      unitNo: json['unitno'] ?? '',
      receiptNo: json['receiptno'] ?? '',
      receiptDate: json['receiptdate'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      contractId: json['contractid'] ?? '',
      tenantId: json['tenantid'] ?? '',
      tenantName: json['tenantname'] ?? '',
      active: json['active']?.toString() ?? '',
      isSync: json['issync'] ?? 0,
      details: detailList,
    );
  }
}

class ReceiptDetail {
  final String id;
  final String receiptId;
  final int internalId;
  final String receiptDate;
  final String payMode;
  final String chequeDate;
  final String refNo;
  final double paymentAmount;
  final String chequeStatus;
  final int sync;

  ReceiptDetail({
    required this.id,
    required this.receiptId,
    required this.internalId,
    required this.receiptDate,
    required this.payMode,
    required this.chequeDate,
    required this.refNo,
    required this.paymentAmount,
    required this.chequeStatus,
    required this.sync,
  });

  factory ReceiptDetail.fromJson(Map<String, dynamic> json) {
    return ReceiptDetail(
      id: json['_id']?.toString() ?? '',
      receiptId: json['receiptid']?.toString() ?? '',
      internalId: json['internalid'] ?? 0,
      receiptDate: json['receiptdate'] ?? '',
      payMode: json['paymode'] ?? '',
      chequeDate: json['chequedate'] ?? '',
      refNo: json['refno'] ?? '',
      paymentAmount: (json['paymentamount'] as num?)?.toDouble() ?? 0.0,
      chequeStatus: json['chequestatus'] ?? '',
      sync: json['Sync'] ?? 0,
    );
  }
}
