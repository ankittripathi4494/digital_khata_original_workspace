// ignore_for_file: no_leading_underscores_for_local_identifiers

class AddNewRecurringTransactionResponseModel {
  String? status;
  String? response;
  String? message;

  AddNewRecurringTransactionResponseModel({this.status, this.response, this.message});

  AddNewRecurringTransactionResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["response"] is String) {
      response = json["response"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["response"] = response;
    _data["message"] = message;
    return _data;
  }
}
