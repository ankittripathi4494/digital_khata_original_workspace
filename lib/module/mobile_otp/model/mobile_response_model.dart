// ignore_for_file: no_leading_underscores_for_local_identifiers

class MobileOtpResponseModel {
    String? status;
    String? response;
    String? message;
    MobileOtpResponseData? data;

    MobileOtpResponseModel({this.status, this.response, this.message, this.data});

    MobileOtpResponseModel.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        response = json["response"];
        message = json["message"];
        data = json["data"] == null ? null : MobileOtpResponseData.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["status"] = status;
        _data["response"] = response;
        _data["message"] = message;
        if(data != null) {
            _data["data"] = data?.toJson();
        }
        return _data;
    }
}

class MobileOtpResponseData {
    String? otp;
    String? emailORmobile;

    MobileOtpResponseData({this.otp, this.emailORmobile});

    MobileOtpResponseData.fromJson(Map<String, dynamic> json) {
        otp = json["otp"];
        emailORmobile = json["emailORmobile"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["otp"] = otp;
        _data["emailORmobile"] = emailORmobile;
        return _data;
    }
}