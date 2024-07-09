// ignore_for_file: no_leading_underscores_for_local_identifiers

class CustomerResponseModel {
  String? status;
  String? response;
  String? message;
  List<CustomerResponseData>? data;

  CustomerResponseModel({this.status, this.response, this.message, this.data});

  CustomerResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["response"] is String) {
      response = json["response"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List)
              .map((e) => CustomerResponseData.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["response"] = response;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class CustomerResponseData {
  String? id;
  String? accountId;
  String? userId;
  String? branchId;
  String? groupId;
  String? fullname;
  String? mobile;
  String? isMobileVarified;
  String? email;
  String? dob;
  String? billingCycle;
  String? status;
  String? createdBy;
  dynamic createdDate;
  String? updatedBy;
  dynamic updatedDate;
  String? address;
  dynamic customerFcm;
  String? amount;

  CustomerResponseData(
      {this.id,
      this.accountId,
      this.userId,
      this.branchId,
      this.groupId,
      this.fullname,
      this.mobile,
      this.isMobileVarified,
      this.email,
      this.dob,
      this.billingCycle,
      this.status,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.address,
      this.customerFcm,
      this.amount});

  CustomerResponseData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["account_id"] is String) {
      accountId = json["account_id"];
    }
    if (json["user_id"] is String) {
      userId = json["user_id"];
    }
    if (json["branch_id"] is String) {
      branchId = json["branch_id"];
    }
    if (json["group_id"] is String) {
      groupId = json["group_id"];
    }
    if (json["fullname"] is String) {
      fullname = json["fullname"];
    }
    if (json["mobile"] is String) {
      mobile = json["mobile"];
    }
    if (json["is_mobile_varified"] is String) {
      isMobileVarified = json["is_mobile_varified"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["dob"] is String) {
      dob = json["dob"];
    }
    if (json["billing_cycle"] is String) {
      billingCycle = json["billing_cycle"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["created_by"] is String) {
      createdBy = json["created_by"];
    }
    createdDate = json["created_date"];
    if (json["updated_by"] is String) {
      updatedBy = json["updated_by"];
    }
    updatedDate = json["updated_date"];
    if (json["address"] is String) {
      address = json["address"];
    }
    customerFcm = json["customer_fcm"];
    if (json["amount"] is String) {
      amount = json["amount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["account_id"] = accountId;
    _data["user_id"] = userId;
    _data["branch_id"] = branchId;
    _data["group_id"] = groupId;
    _data["fullname"] = fullname;
    _data["mobile"] = mobile;
    _data["is_mobile_varified"] = isMobileVarified;
    _data["email"] = email;
    _data["dob"] = dob;
    _data["billing_cycle"] = billingCycle;
    _data["status"] = status;
    _data["created_by"] = createdBy;
    _data["created_date"] = createdDate;
    _data["updated_by"] = updatedBy;
    _data["updated_date"] = updatedDate;
    _data["address"] = address;
    _data["customer_fcm"] = customerFcm;
    _data["amount"] = amount;
    return _data;
  }
}
