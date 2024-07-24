// ignore_for_file: no_leading_underscores_for_local_identifiers

class TaxListResponseModel {
  String? status;
  String? response;
  String? message;
  List<TaxListResponseData>? data;

  TaxListResponseModel(
      {this.status, this.response, this.message, this.data});

  TaxListResponseModel.fromJson(Map<String, dynamic> json) {
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
              .map((e) => TaxListResponseData.fromJson(e))
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

class TaxListResponseData {
  String? id;
  String? customerId;
  String? branchId;
  String? userId;
  String? title;
  String? amount;
  String? disType;
  String? createdOn;
  String? createdBy;

  TaxListResponseData(
      {this.id,
      this.customerId,
      this.branchId,
      this.userId,
      this.title,
      this.amount,
      this.disType,
      this.createdOn,
      this.createdBy});

  TaxListResponseData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["customer_id"] is String) {
      customerId = json["customer_id"];
    }
    if (json["branch_id"] is String) {
      branchId = json["branch_id"];
    }
    if (json["user_id"] is String) {
      userId = json["user_id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["amount"] is String) {
      amount = json["amount"];
    }
    if (json["dis_type"] is String) {
      disType = json["dis_type"];
    }
    if (json["created_on"] is String) {
      createdOn = json["created_on"];
    }
    if (json["created_by"] is String) {
      createdBy = json["created_by"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["customer_id"] = customerId;
    _data["branch_id"] = branchId;
    _data["user_id"] = userId;
    _data["title"] = title;
    _data["amount"] = amount;
    _data["dis_type"] = disType;
    _data["created_on"] = createdOn;
    _data["created_by"] = createdBy;
    return _data;
  }
}
