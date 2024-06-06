// ignore_for_file: no_leading_underscores_for_local_identifiers

class CountryResponseModel {
    String? status;
    String? response;
    String? message;
    List<CountryResponseData>? data;

    CountryResponseModel({this.status, this.response, this.message, this.data});

    CountryResponseModel.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        response = json["response"];
        message = json["message"];
        data = json["data"] == null ? null : (json["data"] as List).map((e) => CountryResponseData.fromJson(e)).toList();
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

class CountryResponseData {
    String? id;
    String? name;

    CountryResponseData({this.id, this.name});

    CountryResponseData.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        return _data;
    }
}