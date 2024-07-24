// ignore_for_file: no_leading_underscores_for_local_identifiers

class ProductMasterUnitListResponseModel {
  String? status;
  String? response;
  String? message;
  List<ProductMasterUnitListResponseData>? data;

  ProductMasterUnitListResponseModel(
      {this.status, this.response, this.message, this.data});

  ProductMasterUnitListResponseModel.fromJson(Map<String, dynamic> json) {
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
              .map((e) => ProductMasterUnitListResponseData.fromJson(e))
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

class ProductMasterUnitListResponseData {
  String? id;
  String? title;
  String? createdOn;

  ProductMasterUnitListResponseData({this.id, this.title, this.createdOn});

  ProductMasterUnitListResponseData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["created_on"] is String) {
      createdOn = json["created_on"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["created_on"] = createdOn;
    return _data;
  }
}
