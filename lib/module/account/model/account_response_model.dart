// ignore_for_file: no_leading_underscores_for_local_identifiers

class AccountResponseModel {
    String? status;
    String? response;
    String? message;
    List<AccountResponseData>? data;

    AccountResponseModel({this.status, this.response, this.message, this.data});

    AccountResponseModel.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        response = json["response"];
        message = json["message"];
        data = json["data"] == null ? null : (json["data"] as List).map((e) => AccountResponseData.fromJson(e)).toList();
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

class AccountResponseData {
    String? id;
    String? fullname;
    String? email;
    String? phone;
    String? countryId;
    String? dob;
    String? profileImage;

    AccountResponseData({this.id, this.fullname, this.email, this.phone, this.countryId, this.dob, this.profileImage});

    AccountResponseData.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        fullname = json["fullname"];
        email = json["email"];
        phone = json["phone"];
        countryId = json["country_id"];
        dob = json["dob"];
        profileImage = json["profile_image"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["fullname"] = fullname;
        _data["email"] = email;
        _data["phone"] = phone;
        _data["country_id"] = countryId;
        _data["dob"] = dob;
        _data["profile_image"] = profileImage;
        return _data;
    }
}