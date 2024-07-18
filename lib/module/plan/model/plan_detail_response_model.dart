// ignore_for_file: no_leading_underscores_for_local_identifiers

class PlanDetailResponseModel {
    String? status;
    String? response;
    String? message;
    List<PlanDetailResponseData>? data;

    PlanDetailResponseModel({this.status, this.response, this.message, this.data});

    PlanDetailResponseModel.fromJson(Map<String, dynamic> json) {
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
            data = json["data"] == null ? null : (json["data"] as List).map((e) => PlanDetailResponseData.fromJson(e)).toList();
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

class PlanDetailResponseData {
    String? id;
    String? customerId;
    String? userId;
    String? branchId;
    String? title;
    String? amount;
    String? emiType;
    String? noOfEmi;
    String? image;
    String? notes;
    String? createdDate;
    String? updatedDate;

    PlanDetailResponseData({this.id, this.customerId, this.userId, this.branchId, this.title, this.amount, this.emiType, this.noOfEmi, this.image, this.notes, this.createdDate, this.updatedDate});

    PlanDetailResponseData.fromJson(Map<String, dynamic> json) {
        if(json["id"] is String) {
            id = json["id"];
        }
        if(json["customer_id"] is String) {
            customerId = json["customer_id"];
        }
        if(json["user_id"] is String) {
            userId = json["user_id"];
        }
        if(json["branch_id"] is String) {
            branchId = json["branch_id"];
        }
        if(json["title"] is String) {
            title = json["title"];
        }
        if(json["amount"] is String) {
            amount = json["amount"];
        }
        if(json["emi_type"] is String) {
            emiType = json["emi_type"];
        }
        if(json["no_of_EMI"] is String) {
            noOfEmi = json["no_of_EMI"];
        }
        if(json["image"] is String) {
            image = json["image"];
        }
        if(json["notes"] is String) {
            notes = json["notes"];
        }
        if(json["created_date"] is String) {
            createdDate = json["created_date"];
        }
        if(json["updated_date"] is String) {
            updatedDate = json["updated_date"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["customer_id"] = customerId;
        _data["user_id"] = userId;
        _data["branch_id"] = branchId;
        _data["title"] = title;
        _data["amount"] = amount;
        _data["emi_type"] = emiType;
        _data["no_of_EMI"] = noOfEmi;
        _data["image"] = image;
        _data["notes"] = notes;
        _data["created_date"] = createdDate;
        _data["updated_date"] = updatedDate;
        return _data;
    }
}