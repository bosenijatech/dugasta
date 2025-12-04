class ViewReqModel {
  String? status;
  List<Message>? message;

  ViewReqModel({this.status, this.message});

  ViewReqModel.fromJson(Map<String, dynamic> json) {
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
  String? srInternalid;
  String? srCasenumber;
  String? srDate;
  String? iscancelled;
  String? srContractid;
  String? srContractname;
  String? srBuilding;
  String? srUnitVilla;
  String? srContractenddate;
  String? srTenantid;
  String? srTenantname;
  String? srTenantmobile;
  String? srTenantemail;
  String? srRequesttype;
  String? srCallstype;
  String? srMaincategoryId;
  String? srMaincategoryName;
  String? srSubcategoryId;
  String? srSubcategoryName;
  String? srRemarks;
  String? srAttachment;
  String? srStatus;
  String? srIstechnicianAllocated;
  String? techAllocatedDate;
  String? techAllocatedTime;
  String? techId;
  String? techName;
  String? isTechClosedstatus;
  String? isTechClosedRemarks;
  String? techClosedDateandtime;
  String? createdBy;
  int? isSync;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? srContractstartdate;

  Message(
      {this.sId,
      this.srInternalid,
      this.srCasenumber,
      this.srDate,
      this.iscancelled,
      this.srContractid,
      this.srContractname,
      this.srBuilding,
      this.srUnitVilla,
      this.srContractenddate,
      this.srTenantid,
      this.srTenantname,
      this.srTenantmobile,
      this.srTenantemail,
      this.srRequesttype,
      this.srCallstype,
      this.srMaincategoryId,
      this.srMaincategoryName,
      this.srSubcategoryId,
      this.srSubcategoryName,
      this.srRemarks,
      this.srAttachment,
      this.srStatus,
      this.srIstechnicianAllocated,
      this.techAllocatedDate,
      this.techAllocatedTime,
      this.techId,
      this.techName,
      this.isTechClosedstatus,
      this.isTechClosedRemarks,
      this.techClosedDateandtime,
      this.createdBy,
      this.isSync,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.srContractstartdate});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    srInternalid = json['sr_internalid'];
    srCasenumber = json['sr_casenumber'];
    srDate = json['sr_date'];
    iscancelled = json['iscancelled'];
    srContractid = json['sr_contractid'];
    srContractname = json['sr_contractname'];
    srBuilding = json['sr_building'];
    srUnitVilla = json['sr_unit_villa'];
    srContractenddate = json['sr_contractenddate'];
    srTenantid = json['sr_tenantid'];
    srTenantname = json['sr_tenantname'];
    srTenantmobile = json['sr_tenantmobile'];
    srTenantemail = json['sr_tenantemail'];
    srRequesttype = json['sr_requesttype'];
    srCallstype = json['sr_callstype'];
    srMaincategoryId = json['sr_maincategory_id'];
    srMaincategoryName = json['sr_maincategory_name'];
    srSubcategoryId = json['sr_subcategory_id'];
    srSubcategoryName = json['sr_subcategory_name'];
    srRemarks = json['sr_remarks'];
    srAttachment = json['sr_attachment'];
    srStatus = json['sr_status'];
    srIstechnicianAllocated = json['sr_istechnician_allocated'];
    techAllocatedDate = json['tech_allocated_date'];
    techAllocatedTime = json['tech_allocated_time'];
    techId = json['tech_id'];
    techName = json['tech_name'];
    isTechClosedstatus = json['is_tech_closedstatus'];
    isTechClosedRemarks = json['is_tech_closed_remarks'];
    techClosedDateandtime = json['tech_closed_dateandtime'];
    createdBy = json['created_by'];
    isSync = json['isSync'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    srContractstartdate = json['sr_contractstartdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sr_internalid'] = srInternalid;
    data['sr_casenumber'] = srCasenumber;
    data['sr_date'] = srDate;
    data['iscancelled'] = iscancelled;
    data['sr_contractid'] = srContractid;
    data['sr_contractname'] = srContractname;
    data['sr_building'] = srBuilding;
    data['sr_unit_villa'] = srUnitVilla;
    data['sr_contractenddate'] = srContractenddate;
    data['sr_tenantid'] = srTenantid;
    data['sr_tenantname'] = srTenantname;
    data['sr_tenantmobile'] = srTenantmobile;
    data['sr_tenantemail'] = srTenantemail;
    data['sr_requesttype'] = srRequesttype;
    data['sr_callstype'] = srCallstype;
    data['sr_maincategory_id'] = srMaincategoryId;
    data['sr_maincategory_name'] = srMaincategoryName;
    data['sr_subcategory_id'] = srSubcategoryId;
    data['sr_subcategory_name'] = srSubcategoryName;
    data['sr_remarks'] = srRemarks;
    data['sr_attachment'] = srAttachment;
    data['sr_status'] = srStatus;
    data['sr_istechnician_allocated'] = srIstechnicianAllocated;
    data['tech_allocated_date'] = techAllocatedDate;
    data['tech_allocated_time'] = techAllocatedTime;
    data['tech_id'] = techId;
    data['tech_name'] = techName;
    data['is_tech_closedstatus'] = isTechClosedstatus;
    data['is_tech_closed_remarks'] = isTechClosedRemarks;
    data['tech_closed_dateandtime'] = techClosedDateandtime;
    data['created_by'] = createdBy;
    data['isSync'] = isSync;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['sr_contractstartdate'] = srContractstartdate;
    return data;
  }
}
