// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: no_leading_underscores_for_local_identifiers

class BusinessTypeListResponseModel {
  String? status;
  String? response;
  String? message;
  List<BusinessTypeListResponseData>? data;

  BusinessTypeListResponseModel(
      {this.status, this.response, this.message, this.data});

  BusinessTypeListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    response = json["response"];
    message = json["message"];
    data = json["data"] == null
        ? null
        : (json["data"] as List)
            .map((e) => BusinessTypeListResponseData.fromJson(e))
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

class BusinessTypeListResponseData {
  String? id;
  String? name;
  late bool isChecked;
  BusinessTypeListResponseData({
    this.id,
    this.name,
    required this.isChecked,
  });

  BusinessTypeListResponseData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    isChecked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["isChecked"] = isChecked;
    return _data;
  }
}
