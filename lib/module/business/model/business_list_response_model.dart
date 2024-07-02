// ignore_for_file: no_leading_underscores_for_local_identifiers

class BusinessListResponseModel {
  String? status;
  String? response;
  String? message;
  List<BusinessListResponseData>? data;

  BusinessListResponseModel(
      {this.status, this.response, this.message, this.data});

  BusinessListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    response = json["response"];
    message = json["message"];
    data = json["data"] == null
        ? null
        : (json["data"] as List)
            .map((e) => BusinessListResponseData.fromJson(e))
            .toList();
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

class BusinessListResponseData {
  String? id;
  String? userId;
  String? bName;
  String? email;
  String? mobile;
  String? gstNo;
  String? website;
  String? address;
  dynamic profile;
  String? businessType;
  String? updatedBy;
  dynamic updatedOn;
  String? createdBy;
  String? createdOn;
  String? deletedBy;
  String? status;
  String? accountId;
  late bool isSelected;

  BusinessListResponseData(
      {this.id,
      this.userId,
      this.bName,
      this.email,
      this.mobile,
      this.gstNo,
      this.website,
      this.address,
      this.profile,
      this.businessType,
      this.updatedBy,
      this.updatedOn,
      this.createdBy,
      this.createdOn,
      this.deletedBy,
      this.status,
      this.accountId,
      required this.isSelected});

  BusinessListResponseData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    bName = json["b_name"];
    email = json["email"];
    mobile = json["mobile"];
    gstNo = json["gst_no"];
    website = json["website"];
    address = json["address"];
    profile = json["profile"];
    businessType = json["business_type"];
    updatedBy = json["updated_by"];
    updatedOn = json["updated_on"];
    createdBy = json["created_by"];
    createdOn = json["created_on"];
    deletedBy = json["deleted_by"];
    status = json["status"];
    accountId = json["account_id"];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["b_name"] = bName;
    _data["email"] = email;
    _data["mobile"] = mobile;
    _data["gst_no"] = gstNo;
    _data["website"] = website;
    _data["address"] = address;
    _data["profile"] = profile;
    _data["business_type"] = businessType;
    _data["updated_by"] = updatedBy;
    _data["updated_on"] = updatedOn;
    _data["created_by"] = createdBy;
    _data["created_on"] = createdOn;
    _data["deleted_by"] = deletedBy;
    _data["status"] = status;
    _data["account_id"] = accountId;
    _data["is_selected"] = isSelected;
    return _data;
  }
}
