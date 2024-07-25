
// ignore_for_file: no_leading_underscores_for_local_identifiers

class ProductModifierListResponseModel {
    String? status;
    String? response;
    String? message;
    List<ProductModifierListResponseData>? data;

    ProductModifierListResponseModel({this.status, this.response, this.message, this.data});

    ProductModifierListResponseModel.fromJson(Map<String, dynamic> json) {
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
            data = json["data"] == null ? null : (json["data"] as List).map((e) => ProductModifierListResponseData.fromJson(e)).toList();
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

class ProductModifierListResponseData {
  String? accountId;
    String? title;
    String? itemCount;

    ProductModifierListResponseData({this.accountId, this.title, this.itemCount});

    ProductModifierListResponseData.fromJson(Map<String, dynamic> json) {
        if(json["account_id"] is String) {
            accountId = json["account_id"];
        }
        if(json["title"] is String) {
            title = json["title"];
        }
        if(json["itemCount"] is String) {
            itemCount = json["itemCount"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["account_id"] = accountId;
        _data["title"] = title;
        _data["itemCount"] = itemCount;
        return _data;
    }
}