
// ignore_for_file: no_leading_underscores_for_local_identifiers

class ProductListResponseModel {
    String? status;
    String? response;
    String? message;
    List<ProductListResponseData>? data;

    ProductListResponseModel({this.status, this.response, this.message, this.data});

    ProductListResponseModel.fromJson(Map<String, dynamic> json) {
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
            data = json["data"] == null ? null : (json["data"] as List).map((e) => ProductListResponseData.fromJson(e)).toList();
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

class ProductListResponseData {
    String? id;
    String? customerId;
    String? branchId;
    String? userId;
    String? productName;
    String? modifierId;
    String? discountId;
    String? taxId;
    String? description;
    dynamic images;
    String? type;
    String? createdOn;
    String? updatedOn;
    String? itemCount;
    dynamic totalPrice;
   

    ProductListResponseData({this.id, this.customerId, this.branchId, this.userId, this.productName, this.modifierId, this.discountId, this.taxId, this.description, this.images, this.type, this.createdOn, this.updatedOn, this.itemCount, this.totalPrice});

    ProductListResponseData.fromJson(Map<String, dynamic> json) {
        if(json["id"] is String) {
            id = json["id"];
        }
        if(json["customer_id"] is String) {
            customerId = json["customer_id"];
        }
        if(json["branch_id"] is String) {
            branchId = json["branch_id"];
        }
        if(json["user_id"] is String) {
            userId = json["user_id"];
        }
        if(json["product_name"] is String) {
            productName = json["product_name"];
        }
        if(json["modifier_id"] is String) {
            modifierId = json["modifier_id"];
        }
        if(json["discount_id"] is String) {
            discountId = json["discount_id"];
        }
        if(json["tax_id"] is String) {
            taxId = json["tax_id"];
        }
        if(json["description"] is String) {
            description = json["description"];
        }
        images = json["images"];
        if(json["type"] is String) {
            type = json["type"];
        }
        if(json["created_on"] is String) {
            createdOn = json["created_on"];
        }
        if(json["updated_on"] is String) {
            updatedOn = json["updated_on"];
        }
        if(json["itemCount"] is String) {
            itemCount = json["itemCount"];
        }
        totalPrice = json["total_price"];
        
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["customer_id"] = customerId;
        _data["branch_id"] = branchId;
        _data["user_id"] = userId;
        _data["product_name"] = productName;
        _data["modifier_id"] = modifierId;
        _data["discount_id"] = discountId;
        _data["tax_id"] = taxId;
        _data["description"] = description;
        _data["images"] = images;
        _data["type"] = type;
        _data["created_on"] = createdOn;
        _data["updated_on"] = updatedOn;
        _data["itemCount"] = itemCount;
        _data["total_price"] = totalPrice;
        
        return _data;
    }
}