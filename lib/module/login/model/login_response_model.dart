// ignore_for_file: no_leading_underscores_for_local_identifiers

class LoginResponseModel {
  String? status;
  String? response;
  String? message;
  String? loginType;

  LoginResponseData? data;

  LoginResponseModel(
      {this.status, this.response, this.message, this.loginType, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    response = json["response"];
    message = json["message"];
    if (json["login_type"] is String) {
      loginType = json["login_type"];
    }
    data =
        json["data"] == null ? null : LoginResponseData.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["response"] = response;
    _data["message"] = message;
    _data["login_type"] = loginType;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class LoginResponseData {
  String? userId;
  String? otp;
  String? emailORmobile;

  LoginResponseData({this.userId, this.otp, this.emailORmobile});

  LoginResponseData.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"].toString().trim();
    otp = json["otp"].toString().trim();
    emailORmobile = json["emailORmobile"].toString().trim();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user_id"] = userId;
    _data["otp"] = otp;
    _data["emailORmobile"] = emailORmobile;
    return _data;
  }
}
