class ContractModel {
  String? sId;
  String? contractInternalid;
  String? contractNo;
  double? contractSecuritydeposit;
  String? contractErajno;
  String? contractUnitno;
  String? contractBuilding;
  String? contractStartdate;
  String? contractEnddate;
  double? contractRentamount;
  String? contractTenantid;
  String? contractTenantname;
  String? contractServiceallowed;
  String? contractStatus;
  String? active;
  String? buildingid;
  String? unitid;
  int? iV;
  String? createdAt;
  String? updatedAt;
  String? buildingtype;

  ContractModel({
    this.sId,
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
    this.buildingid,
    this.unitid,
    this.iV,
    this.createdAt,
    this.updatedAt,
    this.buildingtype,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      sId: json['_id'],
      contractInternalid: json['contract_internalid'],
      contractNo: json['contract_no'],
      contractSecuritydeposit:
          double.tryParse(json['contract_securitydeposit']?.toString() ?? '') ??
              0.00,
      contractErajno: json['contract_erajno'],
      contractUnitno: json['contract_unitno'],
      contractBuilding: json['contract_building'],
      contractStartdate: json['contract_startdate'],
      contractEnddate: json['contract_enddate'],
      contractRentamount:
          double.tryParse(json['contract_rentamount']?.toString() ?? '') ??
              0.00,
      contractTenantid: json['contract_tenantid'],
      contractTenantname: json['contract_tenantname'],
      contractServiceallowed: json['contract_serviceallowed'],
      contractStatus: json['contractStatus'],
      active: json['active'],
      buildingid: json['buildingid'],
      unitid: json['unitid'],
      iV: json['__v'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      buildingtype: json['buildingtype'],
    );
  }
}
