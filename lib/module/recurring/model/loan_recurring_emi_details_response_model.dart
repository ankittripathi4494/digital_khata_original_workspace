// ignore_for_file: no_leading_underscores_for_local_identifiers

class LoanRecurringEmiDetailResponseModel {
  String? status;
  String? response;
  String? message;
  LoanRecurringEmiDetailResponseData? data;

  LoanRecurringEmiDetailResponseModel(
      {this.status, this.response, this.message, this.data});

  LoanRecurringEmiDetailResponseModel.fromJson(Map<String, dynamic> json) {
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
          : LoanRecurringEmiDetailResponseData.fromJson(json["data"]);
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

class LoanRecurringEmiDetailResponseData {
  String? id;
  String? userId;
  String? customerId;
  String? branchId;
  String? title;
  String? emiType;
  String? noOfEmi;
  String? amount;
  dynamic images;
  String? startDate;
  String? endDate;
  String? notes;
  String? createdOn;
  String? updatedOn;
  String? createdBy;
  List<LoanRecurringEmiDetailResponseEmiList>? emiList;

  LoanRecurringEmiDetailResponseData(
      {this.id,
      this.userId,
      this.customerId,
      this.branchId,
      this.title,
      this.emiType,
      this.noOfEmi,
      this.amount,
      this.images,
      this.startDate,
      this.endDate,
      this.notes,
      this.createdOn,
      this.updatedOn,
      this.createdBy,
      this.emiList});

  LoanRecurringEmiDetailResponseData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["user_id"] is String) {
      userId = json["user_id"];
    }
    if (json["customer_id"] is String) {
      customerId = json["customer_id"];
    }
    if (json["branch_id"] is String) {
      branchId = json["branch_id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["emi_type"] is String) {
      emiType = json["emi_type"];
    }
    if (json["no_of_EMI"] is String) {
      noOfEmi = json["no_of_EMI"];
    }
    if (json["amount"] is String) {
      amount = json["amount"];
    }
    images = json["images"];
    if (json["start_date"] is String) {
      startDate = json["start_date"];
    }
    if (json["end_date"] is String) {
      endDate = json["end_date"];
    }
    if (json["notes"] is String) {
      notes = json["notes"];
    }
    if (json["created_on"] is String) {
      createdOn = json["created_on"];
    }
    if (json["updated_on"] is String) {
      updatedOn = json["updated_on"];
    }
    if (json["created_by"] is String) {
      createdBy = json["created_by"];
    }
    if (json["EMI_list"] is List) {
      emiList = json["EMI_list"] == null
          ? null
          : (json["EMI_list"] as List)
              .map((e) => LoanRecurringEmiDetailResponseEmiList.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["customer_id"] = customerId;
    _data["branch_id"] = branchId;
    _data["title"] = title;
    _data["emi_type"] = emiType;
    _data["no_of_EMI"] = noOfEmi;
    _data["amount"] = amount;
    _data["images"] = images;
    _data["start_date"] = startDate;
    _data["end_date"] = endDate;
    _data["notes"] = notes;
    _data["created_on"] = createdOn;
    _data["updated_on"] = updatedOn;
    _data["created_by"] = createdBy;
    if (emiList != null) {
      _data["EMI_list"] = emiList?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class LoanRecurringEmiDetailResponseEmiList {
  String? id;
  String? recurringTransId;
  String? emiMonth;
  String? emiAmount;
  String? emiDate;
  String? status;
  String? createdOn;
  dynamic paymentDate;

  LoanRecurringEmiDetailResponseEmiList(
      {this.id,
      this.recurringTransId,
      this.emiMonth,
      this.emiAmount,
      this.emiDate,
      this.status,
      this.createdOn,
      this.paymentDate});

  LoanRecurringEmiDetailResponseEmiList.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["recurring_trans_id"] is String) {
      recurringTransId = json["recurring_trans_id"];
    }
    if (json["emi_month"] is String) {
      emiMonth = json["emi_month"];
    }
    if (json["emi_amount"] is String) {
      emiAmount = json["emi_amount"];
    }
    if (json["emi_date"] is String) {
      emiDate = json["emi_date"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["created_on"] is String) {
      createdOn = json["created_on"];
    }
    paymentDate = json["payment_date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["recurring_trans_id"] = recurringTransId;
    _data["emi_month"] = emiMonth;
    _data["emi_amount"] = emiAmount;
    _data["emi_date"] = emiDate;
    _data["status"] = status;
    _data["created_on"] = createdOn;
    _data["payment_date"] = paymentDate;
    return _data;
  }
}
