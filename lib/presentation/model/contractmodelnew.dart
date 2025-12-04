class ContractModelNew {
  bool? status;
  String? message;
  List<Activecontract>? activecontract;
  List<Inactivecontract>? inactivecontract;
  List<Pendingcontract>? pendingcontract;

  ContractModelNew(
      {this.status,
      this.message,
      this.activecontract,
      this.inactivecontract,
      this.pendingcontract});

  ContractModelNew.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['activecontract'] != null) {
      activecontract = <Activecontract>[];
      json['activecontract'].forEach((v) {
        activecontract!.add(Activecontract.fromJson(v));
      });
    }
    if (json['inactivecontract'] != null) {
      inactivecontract = <Inactivecontract>[];
      json['inactivecontract'].forEach((v) {
        inactivecontract!.add(Inactivecontract.fromJson(v));
      });
    }
    if (json['pendingcontract'] != null) {
      pendingcontract = <Pendingcontract>[];
      json['pendingcontract'].forEach((v) {
        pendingcontract!.add(Pendingcontract.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (activecontract != null) {
      data['activecontract'] = activecontract!.map((v) => v.toJson()).toList();
    }
    if (inactivecontract != null) {
      data['inactivecontract'] =
          inactivecontract!.map((v) => v.toJson()).toList();
    }
    if (pendingcontract != null) {
      data['pendingcontract'] =
          pendingcontract!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activecontract {
  String? sId;
  String? contractInternalid;
  String? contractNo;
  String? contractSecuritydeposit;
  String? contractErajno;
  String? contractUnitno;
  String? contractBuilding;
  String? contractStartdate;
  String? contractEnddate;
  String? contractRentamount;
  String? contractTenantid;
  String? contractTenantname;
  String? contractServiceallowed;
  String? contractStatus;
  String? active;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Activecontract(
      {this.sId,
      this.contractInternalid,
      this.contractNo,
      this.contractSecuritydeposit,
      this.contractErajno,
      this.contractUnitno,
      this.contractBuilding,
      this.contractStartdate,
      this.contractEnddate,
      this.contractRentamount,
      this.contractTenantid,
      this.contractTenantname,
      this.contractServiceallowed,
      this.contractStatus,
      this.active,
      this.iV,
      this.createdAt,
      this.updatedAt});

  Activecontract.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contractInternalid = json['contract_internalid'];
    contractNo = json['contract_no'];
    contractSecuritydeposit = json['contract_securitydeposit'];
    contractErajno = json['contract_erajno'];
    contractUnitno = json['contract_unitno'];
    contractBuilding = json['contract_building'];
    contractStartdate = json['contract_startdate'];
    contractEnddate = json['contract_enddate'];
    contractRentamount = json['contract_rentamount'];
    contractTenantid = json['contract_tenantid'];
    contractTenantname = json['contract_tenantname'];
    contractServiceallowed = json['contract_serviceallowed'];
    contractStatus = json['contractStatus'];
    active = json['active'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['contract_internalid'] = contractInternalid;
    data['contract_no'] = contractNo;
    data['contract_securitydeposit'] = contractSecuritydeposit;
    data['contract_erajno'] = contractErajno;
    data['contract_unitno'] = contractUnitno;
    data['contract_building'] = contractBuilding;
    data['contract_startdate'] = contractStartdate;
    data['contract_enddate'] = contractEnddate;
    data['contract_rentamount'] = contractRentamount;
    data['contract_tenantid'] = contractTenantid;
    data['contract_tenantname'] = contractTenantname;
    data['contract_serviceallowed'] = contractServiceallowed;
    data['contractStatus'] = contractStatus;
    data['active'] = active;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Inactivecontract {
  String? sId;
  String? contractInternalid;
  String? contractNo;
  String? contractSecuritydeposit;
  String? contractErajno;
  String? contractUnitno;
  String? contractBuilding;
  String? contractStartdate;
  String? contractEnddate;
  String? contractRentamount;
  String? contractTenantid;
  String? contractTenantname;
  String? contractServiceallowed;
  String? contractStatus;
  String? active;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Inactivecontract(
      {this.sId,
      this.contractInternalid,
      this.contractNo,
      this.contractSecuritydeposit,
      this.contractErajno,
      this.contractUnitno,
      this.contractBuilding,
      this.contractStartdate,
      this.contractEnddate,
      this.contractRentamount,
      this.contractTenantid,
      this.contractTenantname,
      this.contractServiceallowed,
      this.contractStatus,
      this.active,
      this.iV,
      this.createdAt,
      this.updatedAt});

  Inactivecontract.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contractInternalid = json['contract_internalid'];
    contractNo = json['contract_no'];
    contractSecuritydeposit = json['contract_securitydeposit'];
    contractErajno = json['contract_erajno'];
    contractUnitno = json['contract_unitno'];
    contractBuilding = json['contract_building'];
    contractStartdate = json['contract_startdate'];
    contractEnddate = json['contract_enddate'];
    contractRentamount = json['contract_rentamount'];
    contractTenantid = json['contract_tenantid'];
    contractTenantname = json['contract_tenantname'];
    contractServiceallowed = json['contract_serviceallowed'];
    contractStatus = json['contractStatus'];
    active = json['active'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['contract_internalid'] = contractInternalid;
    data['contract_no'] = contractNo;
    data['contract_securitydeposit'] = contractSecuritydeposit;
    data['contract_erajno'] = contractErajno;
    data['contract_unitno'] = contractUnitno;
    data['contract_building'] = contractBuilding;
    data['contract_startdate'] = contractStartdate;
    data['contract_enddate'] = contractEnddate;
    data['contract_rentamount'] = contractRentamount;
    data['contract_tenantid'] = contractTenantid;
    data['contract_tenantname'] = contractTenantname;
    data['contract_serviceallowed'] = contractServiceallowed;
    data['contractStatus'] = contractStatus;
    data['active'] = active;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Pendingcontract {
  String? sId;
  String? contractInternalid;
  String? contractNo;
  String? contractSecuritydeposit;
  String? contractErajno;
  String? contractUnitno;
  String? contractBuilding;
  String? contractStartdate;
  String? contractEnddate;
  String? contractRentamount;
  String? contractTenantid;
  String? contractTenantname;
  String? contractServiceallowed;
  String? contractStatus;
  String? active;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Pendingcontract(
      {this.sId,
      this.contractInternalid,
      this.contractNo,
      this.contractSecuritydeposit,
      this.contractErajno,
      this.contractUnitno,
      this.contractBuilding,
      this.contractStartdate,
      this.contractEnddate,
      this.contractRentamount,
      this.contractTenantid,
      this.contractTenantname,
      this.contractServiceallowed,
      this.contractStatus,
      this.active,
      this.iV,
      this.createdAt,
      this.updatedAt});

  Pendingcontract.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contractInternalid = json['contract_internalid'];
    contractNo = json['contract_no'];
    contractSecuritydeposit = json['contract_securitydeposit'];
    contractErajno = json['contract_erajno'];
    contractUnitno = json['contract_unitno'];
    contractBuilding = json['contract_building'];
    contractStartdate = json['contract_startdate'];
    contractEnddate = json['contract_enddate'];
    contractRentamount = json['contract_rentamount'];
    contractTenantid = json['contract_tenantid'];
    contractTenantname = json['contract_tenantname'];
    contractServiceallowed = json['contract_serviceallowed'];
    contractStatus = json['contractStatus'];
    active = json['active'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['contract_internalid'] = contractInternalid;
    data['contract_no'] = contractNo;
    data['contract_securitydeposit'] = contractSecuritydeposit;
    data['contract_erajno'] = contractErajno;
    data['contract_unitno'] = contractUnitno;
    data['contract_building'] = contractBuilding;
    data['contract_startdate'] = contractStartdate;
    data['contract_enddate'] = contractEnddate;
    data['contract_rentamount'] = contractRentamount;
    data['contract_tenantid'] = contractTenantid;
    data['contract_tenantname'] = contractTenantname;
    data['contract_serviceallowed'] = contractServiceallowed;
    data['contractStatus'] = contractStatus;
    data['active'] = active;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
