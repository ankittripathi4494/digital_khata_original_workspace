// ignore_for_file: no_leading_underscores_for_local_identifiers

class ProductUnitListResponseModel {
  String? status;
  String? response;
  String? message;
  List<ProductUnitListResponseData>? data;

  ProductUnitListResponseModel(
      {this.status, this.response, this.message, this.data});

  ProductUnitListResponseModel.fromJson(Map<String, dynamic> json) {
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
              .map((e) => ProductUnitListResponseData.fromJson(e))
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

class ProductUnitListResponseData {
  String? id;
  String? userId;
  String? customerId;
  String? branchId;
  String? unitName;
  String? unitQty;
  String? createdOn;
  String? createdBy;

  ProductUnitListResponseData(
      {this.id,
      this.userId,
      this.customerId,
      this.branchId,
      this.unitName,
      this.unitQty,
      this.createdOn,
      this.createdBy});

  ProductUnitListResponseData.fromJson(Map<String, dynamic> json) {
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
    if (json["unit_name"] is String) {
      unitName = json["unit_name"];
    }
    if (json["unit_qty"] is String) {
      unitQty = json["unit_qty"];
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
    _data["user_id"] = userId;
    _data["customer_id"] = customerId;
    _data["branch_id"] = branchId;
    _data["unit_name"] = unitName;
    _data["unit_qty"] = unitQty;
    _data["created_on"] = createdOn;
    _data["created_by"] = createdBy;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductUnitListResponseData &&
        other.unitName == unitName &&
        other.unitQty == unitQty;
  }

  @override
  int get hashCode => unitName.hashCode ^ unitQty.hashCode;
}
