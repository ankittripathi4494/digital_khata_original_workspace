// ignore_for_file: no_leading_underscores_for_local_identifiers

class LoanRecurringEmiListResponseModel {
    String? status;
    String? response;
    String? message;
    List<LoanRecurringEmiListResponseData>? data;

    LoanRecurringEmiListResponseModel({this.status, this.response, this.message, this.data});

    LoanRecurringEmiListResponseModel.fromJson(Map<String, dynamic> json) {
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
            data = json["data"] == null ? null : (json["data"] as List).map((e) => LoanRecurringEmiListResponseData.fromJson(e)).toList();
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

class LoanRecurringEmiListResponseData {
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

    LoanRecurringEmiListResponseData({this.id, this.userId, this.customerId, this.branchId, this.title, this.emiType, this.noOfEmi, this.amount, this.images, this.startDate, this.endDate, this.notes, this.createdOn, this.updatedOn, this.createdBy});

    LoanRecurringEmiListResponseData.fromJson(Map<String, dynamic> json) {
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
        if(json["title"] is String) {
            title = json["title"];
        }
        if(json["emi_type"] is String) {
            emiType = json["emi_type"];
        }
        if(json["no_of_EMI"] is String) {
            noOfEmi = json["no_of_EMI"];
        }
        if(json["amount"] is String) {
            amount = json["amount"];
        }
        images = json["images"];
        if(json["start_date"] is String) {
            startDate = json["start_date"];
        }
        if(json["end_date"] is String) {
            endDate = json["end_date"];
        }
        if(json["notes"] is String) {
            notes = json["notes"];
        }
        if(json["created_on"] is String) {
            createdOn = json["created_on"];
        }
        if(json["updated_on"] is String) {
            updatedOn = json["updated_on"];
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
        return _data;
    }
}