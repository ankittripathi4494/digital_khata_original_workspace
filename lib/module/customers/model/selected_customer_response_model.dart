// ignore_for_file: no_leading_underscores_for_local_identifiers

class SelectedCustomerResponseModel {
  String? status;
  String? response;
  String? message;
  SelectedCustomerResponseData? data;

  SelectedCustomerResponseModel(
      {this.status, this.response, this.message, this.data});

  SelectedCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["response"] is String) {
      response = json["response"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is Map) {
      data = json["data"] == null
          ? null
          : SelectedCustomerResponseData.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["response"] = response;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class SelectedCustomerResponseData {
  String? id;
  String? userId;
  String? branchId;
  String? groupId;
  String? fullname;
  String? email;
  String? mobile;
  String? dob;
  String? billingCycle;
  String? address;

  SelectedCustomerResponseData(
      {this.id,
      this.userId,
      this.branchId,
      this.groupId,
      this.fullname,
      this.email,
      this.mobile,
      this.dob,
      this.billingCycle,
      this.address});

  SelectedCustomerResponseData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
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
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["mobile"] is String) {
      mobile = json["mobile"];
    }
    if (json["dob"] is String) {
      dob = json["dob"];
    }
    if (json["billing_cycle"] is String) {
      billingCycle = json["billing_cycle"];
    }
    if (json["address"] is String) {
      address = json["address"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["branch_id"] = branchId;
    _data["group_id"] = groupId;
    _data["fullname"] = fullname;
    _data["email"] = email;
    _data["mobile"] = mobile;
    _data["dob"] = dob;
    _data["billing_cycle"] = billingCycle;
    _data["address"] = address;
    return _data;
  }
}
