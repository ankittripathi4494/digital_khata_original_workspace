// ignore_for_file: no_leading_underscores_for_local_identifiers

class TransactionListResponseModel {
  String? status;
  String? response;
  String? message;
  List<TransactionListResponseData>? data;

  TransactionListResponseModel(
      {this.status, this.response, this.message, this.data});

  TransactionListResponseModel.fromJson(Map<String, dynamic> json) {
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
              .map((e) => TransactionListResponseData.fromJson(e))
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

class TransactionListResponseData {
  String? id;
  String? customerId;
  String? userId;
  String? branchId;
  String? beforeTransAmount;
  String? transAmount;
  String? afterTransAmount;
  String? notes;
  String? image;
  String? transType;
  String? createdDate;

  TransactionListResponseData(
      {this.id,
      this.customerId,
      this.userId,
      this.branchId,
      this.beforeTransAmount,
      this.transAmount,
      this.afterTransAmount,
      this.notes,
      this.image,
      this.transType,
      this.createdDate});

  TransactionListResponseData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["customer_id"] is String) {
      customerId = json["customer_id"];
    }
    if (json["user_id"] is String) {
      userId = json["user_id"];
    }
    if (json["branch_id"] is String) {
      branchId = json["branch_id"];
    }
    if (json["before_trans_amount"] is String) {
      beforeTransAmount = json["before_trans_amount"];
    }
    if (json["trans_amount"] is String) {
      transAmount = json["trans_amount"];
    }
    if (json["after_trans_amount"] is String) {
      afterTransAmount = json["after_trans_amount"];
    }
    if (json["notes"] is String) {
      notes = json["notes"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["trans_type"] is String) {
      transType = json["trans_type"];
    }
    if (json["created_date"] is String) {
      createdDate = json["created_date"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["customer_id"] = customerId;
    _data["user_id"] = userId;
    _data["branch_id"] = branchId;
    _data["before_trans_amount"] = beforeTransAmount;
    _data["trans_amount"] = transAmount;
    _data["after_trans_amount"] = afterTransAmount;
    _data["notes"] = notes;
    _data["image"] = image;
    _data["trans_type"] = transType;
    _data["created_date"] = createdDate;
    return _data;
  }
}
