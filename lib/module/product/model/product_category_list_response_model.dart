
// ignore_for_file: no_leading_underscores_for_local_identifiers

class ProductCategoryListResponseModel {
    String? status;
    String? response;
    String? message;
    List<ProductCategoryListResponseData>? data;

    ProductCategoryListResponseModel({this.status, this.response, this.message, this.data});

    ProductCategoryListResponseModel.fromJson(Map<String, dynamic> json) {
        if(json["status"] is String) {
            status = json["status"];
        }
        if(json["response"] is String) {
            response = json["response"];
        }
        if(json["message"] is String) {
            message = json["message"];
        }
        if(json["data"] is List) {
            data = json["data"] == null ? null : (json["data"] as List).map((e) => ProductCategoryListResponseData.fromJson(e)).toList();
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["status"] = status;
        _data["response"] = response;
        _data["message"] = message;
        if(data != null) {
            _data["data"] = data?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class ProductCategoryListResponseData {
    String? id;
    String? userId;
    String? customerId;
    String? branchId;
    String? categoryName;
    String? createdOn;
    String? createdBy;

    ProductCategoryListResponseData({this.id, this.userId, this.customerId, this.branchId, this.categoryName, this.createdOn, this.createdBy});

    ProductCategoryListResponseData.fromJson(Map<String, dynamic> json) {
        if(json["id"] is String) {
            id = json["id"];
        }
        if(json["user_id"] is String) {
            userId = json["user_id"];
        }
        if(json["customer_id"] is String) {
            customerId = json["customer_id"];
        }
        if(json["branch_id"] is String) {
            branchId = json["branch_id"];
        }
        if(json["category_name"] is String) {
            categoryName = json["category_name"];
        }
        if(json["created_on"] is String) {
            createdOn = json["created_on"];
        }
        if(json["created_by"] is String) {
            createdBy = json["created_by"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["user_id"] = userId;
        _data["customer_id"] = customerId;
        _data["branch_id"] = branchId;
        _data["category_name"] = categoryName;
        _data["created_on"] = createdOn;
        _data["created_by"] = createdBy;
        return _data;
    }
}