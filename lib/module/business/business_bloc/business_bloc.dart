// ignore_for_file: avoid_print, invalid_use_of_visible_for_testing_member

import 'package:dkapp/module/business/model/add_new_business_response_model.dart';
import 'package:dkapp/module/business/model/delete_business_response_model.dart';
import 'package:dkapp/module/business/model/update_new_business_response_model.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/exceptions.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/business_list_response_model.dart';
import 'business_event.dart';
import 'business_state.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  List<BusinessListResponseData> businessList = [];
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  late BusinessListResponseData selectedBusiness;
  BusinessBloc() : super(BusinessInitial()) {
    on<BusinessListFetchEvent>((event, emit) async {
      emit(BusinessListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        LoggerUtil().infoData(map.toString());

        http.Response response = await http.post(
            Uri.http(
                APIPathList.mainDomain, APIPathList.getBusinessListUserWise),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          BusinessListResponseModel jsonResponse =
              BusinessListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.data!
                  .map((c) {
                    return c.toJson();
                  })
                  .toList()
                  .toString());
            }

            for (var i = 0; i < jsonResponse.data!.length; i++) {
              if (sph.containsKey("selectedBusiness") == true) {
                var decodedJson =
                    convert.jsonDecode(sph.getString("selectedBusiness")!);
                Map<String, dynamic> jsonMap =
                    decodedJson as Map<String, dynamic>;
                selectedBusiness = BusinessListResponseData.fromJson(jsonMap);
                if (selectedBusiness.bName == jsonResponse.data![i].bName) {
                  businessList.add(BusinessListResponseData(
                      id: selectedBusiness.id,
                      userId: selectedBusiness.userId,
                      bName: selectedBusiness.bName,
                      email: selectedBusiness.email,
                      mobile: selectedBusiness.mobile,
                      gstNo: selectedBusiness.gstNo,
                      website: selectedBusiness.website,
                      address: selectedBusiness.address,
                      profile: selectedBusiness.profile,
                      businessType: selectedBusiness.businessType,
                      updatedBy: selectedBusiness.updatedBy,
                      updatedOn: selectedBusiness.updatedOn,
                      createdBy: selectedBusiness.createdBy,
                      createdOn: selectedBusiness.createdOn,
                      deletedBy: selectedBusiness.deletedBy,
                      status: selectedBusiness.status,
                      accountId: selectedBusiness.accountId,
                      isSelected: true));
                } else {
                  businessList.add(BusinessListResponseData(
                      id: jsonResponse.data![i].id,
                      userId: jsonResponse.data![i].userId,
                      bName: jsonResponse.data![i].bName,
                      email: jsonResponse.data![i].email,
                      mobile: jsonResponse.data![i].mobile,
                      gstNo: jsonResponse.data![i].gstNo,
                      website: jsonResponse.data![i].website,
                      address: jsonResponse.data![i].address,
                      profile: jsonResponse.data![i].profile,
                      businessType: jsonResponse.data![i].businessType,
                      updatedBy: jsonResponse.data![i].updatedBy,
                      updatedOn: jsonResponse.data![i].updatedOn,
                      createdBy: jsonResponse.data![i].createdBy,
                      createdOn: jsonResponse.data![i].createdOn,
                      deletedBy: jsonResponse.data![i].deletedBy,
                      status: jsonResponse.data![i].status,
                      accountId: jsonResponse.data![i].accountId,
                      isSelected: false));
                }
              } else {
                if (i == 0) {
                  selectedBusiness = jsonResponse.data![i];
                  businessList.add(BusinessListResponseData(
                      id: jsonResponse.data![i].id,
                      userId: jsonResponse.data![i].userId,
                      bName: jsonResponse.data![i].bName,
                      email: jsonResponse.data![i].email,
                      mobile: jsonResponse.data![i].mobile,
                      gstNo: jsonResponse.data![i].gstNo,
                      website: jsonResponse.data![i].website,
                      address: jsonResponse.data![i].address,
                      profile: jsonResponse.data![i].profile,
                      businessType: jsonResponse.data![i].businessType,
                      updatedBy: jsonResponse.data![i].updatedBy,
                      updatedOn: jsonResponse.data![i].updatedOn,
                      createdBy: jsonResponse.data![i].createdBy,
                      createdOn: jsonResponse.data![i].createdOn,
                      deletedBy: jsonResponse.data![i].deletedBy,
                      status: jsonResponse.data![i].status,
                      accountId: jsonResponse.data![i].accountId,
                      isSelected: true));
                } else {
                  businessList.add(BusinessListResponseData(
                      id: jsonResponse.data![i].id,
                      userId: jsonResponse.data![i].userId,
                      bName: jsonResponse.data![i].bName,
                      email: jsonResponse.data![i].email,
                      mobile: jsonResponse.data![i].mobile,
                      gstNo: jsonResponse.data![i].gstNo,
                      website: jsonResponse.data![i].website,
                      address: jsonResponse.data![i].address,
                      profile: jsonResponse.data![i].profile,
                      businessType: jsonResponse.data![i].businessType,
                      updatedBy: jsonResponse.data![i].updatedBy,
                      updatedOn: jsonResponse.data![i].updatedOn,
                      createdBy: jsonResponse.data![i].createdBy,
                      createdOn: jsonResponse.data![i].createdOn,
                      deletedBy: jsonResponse.data![i].deletedBy,
                      status: jsonResponse.data![i].status,
                      accountId: jsonResponse.data![i].accountId,
                      isSelected: false));
                }
              }
            }

            sph.setString(
                "selectedBusiness", convert.jsonEncode(selectedBusiness));
            emit(BusinessListLoadedState(
                successData: businessList,
                selectedBusinessData: selectedBusiness));
          } else {
            emit(BusinessListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(BusinessListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(BusinessListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<AddNewBusinessTextChangedEvent>((event, emit) async {
      if (event.businessTaxNumber.isEmpty &&
          event.businessWebsite.isEmpty &&
          event.businessType.isEmpty &&
          event.businessAddress.isEmpty &&
          event.businessEmail.isEmpty &&
          event.businessName.isEmpty) {
        emit(AddNewBusinessTextChangedErrorState(
            businessNameError: "Please enter business name",
            businessEmailError: "Please enter business email",
            businessAddressError: "Please select business address",
            businessWebsiteError: "Please enter business website",
            businessTypeError: "Please select business type",
            businessTaxNumberError: "Please enter business GST Number"));
      } else if (event.businessName.isEmpty) {
        emit(AddNewBusinessTextChangedErrorState(
            businessNameError: "Please enter business name",
            businessEmailError: null,
            businessAddressError: null,
            businessWebsiteError: null,
            businessTypeError: null,
            businessTaxNumberError: null));
      } else if ((event.businessEmail.isEmpty) ||
          (!event.businessEmail.isValidEmail())) {
        emit(AddNewBusinessTextChangedErrorState(
            businessEmailError: "Please enter proper business email",
            businessNameError: null,
            businessAddressError: null,
            businessWebsiteError: null,
            businessTypeError: null,
            businessTaxNumberError: null));
      } else if (event.businessAddress.isEmpty) {
        emit(AddNewBusinessTextChangedErrorState(
            businessNameError: null,
            businessEmailError: null,
            businessAddressError: "Please select business address",
            businessWebsiteError: null,
            businessTypeError: null,
            businessTaxNumberError: null));
      } else if (event.businessType.isEmpty) {
        emit(AddNewBusinessTextChangedErrorState(
            businessNameError: null,
            businessEmailError: null,
            businessWebsiteError: null,
            businessTaxNumberError: null,
            businessAddressError: null,
            businessTypeError: "Please select business type"));
      } else if (event.businessWebsite.isEmpty) {
        emit(AddNewBusinessTextChangedErrorState(
            businessNameError: null,
            businessEmailError: null,
            businessTypeError: null,
            businessTaxNumberError: null,
            businessAddressError: null,
            businessWebsiteError: "Please enter business website"));
      } else if (event.businessTaxNumber.isEmpty) {
        emit(AddNewBusinessTextChangedErrorState(
            businessNameError: null,
            businessEmailError: null,
            businessTypeError: null,
            businessWebsiteError: null,
            businessAddressError: null,
            businessTaxNumberError: "Please enter business GST Number"));
      } else {
        emit(AddNewBusinessValidState());
      }
    });

    on<AddNewBusinessEvent>((event, emit) async {
      emit(AddNewBusinessLoadingState());
      var map = {};

      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['b_name'] = event.businessName;
        map['email'] = event.businessEmail;
        map['mobile'] = '';
        map['gst_no'] = event.businessTaxNumber;
        map['website'] = event.businessWebsite;
        map['address'] = event.businessAddress;
        map['business_type'] = event.businessType;
        LoggerUtil().infoData("Input Map :- $map");
        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createBusiness),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          AddNewBusinessResponseModel jsonResponse =
              AddNewBusinessResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.response.toString());
            }

            emit(AddNewBusinessSuccessState(
                successMessage: jsonResponse.message!));
          } else {
            emit(AddNewBusinessFailedState(
                failedMessage: jsonResponse.message!));
          }
        } else {
          emit(AddNewBusinessFailedState(
              failedMessage:
                  'Request failed with status: ${response.statusCode}.'));
        }
      } on PlatformException {
        emit(AddNewBusinessFailedState(
            failedMessage: 'Failed to get platform version.'));
      }
    });

    on<SelectBusinessEvent>((event, emit) async {
      businessList.clear();
      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        LoggerUtil().infoData(map.toString());

        http.Response response = await http.post(
            Uri.http(
                APIPathList.mainDomain, APIPathList.getBusinessListUserWise),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          BusinessListResponseModel jsonResponse =
              BusinessListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.data!
                  .map((c) {
                    return c.toJson();
                  })
                  .toList()
                  .toString());
            }

            for (var i = 0; i < jsonResponse.data!.length; i++) {
              if (jsonResponse.data![i].bName == event.businessData.bName) {
                LoggerUtil().infoData(jsonResponse.data![i].bName == event.businessData.bName);
                LoggerUtil().infoData(event.businessData.toJson());
                selectedBusiness = BusinessListResponseData(
                    id: jsonResponse.data![i].id,
                    userId: jsonResponse.data![i].userId,
                    bName: jsonResponse.data![i].bName,
                    email: jsonResponse.data![i].email,
                    mobile: jsonResponse.data![i].mobile,
                    gstNo: jsonResponse.data![i].gstNo,
                    website: jsonResponse.data![i].website,
                    address: jsonResponse.data![i].address,
                    profile: jsonResponse.data![i].profile,
                    businessType: jsonResponse.data![i].businessType,
                    updatedBy: jsonResponse.data![i].updatedBy,
                    updatedOn: jsonResponse.data![i].updatedOn,
                    createdBy: jsonResponse.data![i].createdBy,
                    createdOn: jsonResponse.data![i].createdOn,
                    deletedBy: jsonResponse.data![i].deletedBy,
                    status: jsonResponse.data![i].status,
                    accountId: jsonResponse.data![i].accountId,
                    isSelected: true);
                businessList.add(BusinessListResponseData(
                    id: jsonResponse.data![i].id,
                    userId: jsonResponse.data![i].userId,
                    bName: jsonResponse.data![i].bName,
                    email: jsonResponse.data![i].email,
                    mobile: jsonResponse.data![i].mobile,
                    gstNo: jsonResponse.data![i].gstNo,
                    website: jsonResponse.data![i].website,
                    address: jsonResponse.data![i].address,
                    profile: jsonResponse.data![i].profile,
                    businessType: jsonResponse.data![i].businessType,
                    updatedBy: jsonResponse.data![i].updatedBy,
                    updatedOn: jsonResponse.data![i].updatedOn,
                    createdBy: jsonResponse.data![i].createdBy,
                    createdOn: jsonResponse.data![i].createdOn,
                    deletedBy: jsonResponse.data![i].deletedBy,
                    status: jsonResponse.data![i].status,
                    accountId: jsonResponse.data![i].accountId,
                    isSelected: true));
              } else {
                businessList.add(BusinessListResponseData(
                    id: jsonResponse.data![i].id,
                    userId: jsonResponse.data![i].userId,
                    bName: jsonResponse.data![i].bName,
                    email: jsonResponse.data![i].email,
                    mobile: jsonResponse.data![i].mobile,
                    gstNo: jsonResponse.data![i].gstNo,
                    website: jsonResponse.data![i].website,
                    address: jsonResponse.data![i].address,
                    profile: jsonResponse.data![i].profile,
                    businessType: jsonResponse.data![i].businessType,
                    updatedBy: jsonResponse.data![i].updatedBy,
                    updatedOn: jsonResponse.data![i].updatedOn,
                    createdBy: jsonResponse.data![i].createdBy,
                    createdOn: jsonResponse.data![i].createdOn,
                    deletedBy: jsonResponse.data![i].deletedBy,
                    status: jsonResponse.data![i].status,
                    accountId: jsonResponse.data![i].accountId,
                    isSelected: false));
              }
            }
            sph.remove("selectedBusiness");
            sph.setString(
                "selectedBusiness", convert.jsonEncode(selectedBusiness));
            emit(BusinessListLoadedState(
                successData: businessList,
                selectedBusinessData: selectedBusiness));
          } else {
            emit(BusinessListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(BusinessListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(BusinessListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<FetchSelectedBusinessEvent>((event, emit) async {
      emit(FetchSelectedBusinessLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        LoggerUtil().infoData(map);

        http.Response response = await http.post(
            Uri.http(
                APIPathList.mainDomain, APIPathList.getBusinessListUserWise),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          BusinessListResponseModel jsonResponse =
              BusinessListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.data!
                  .map((c) {
                    return c.toJson();
                  })
                  .toList()
                  .toString());
            }

            if (sph.containsKey("selectedBusiness") == true) {
              var decodedJson =
                  convert.jsonDecode(sph.getString("selectedBusiness")!);
              Map<String, dynamic> jsonMap =
                  decodedJson as Map<String, dynamic>;

              for (BusinessListResponseData blrm in jsonResponse.data!) {
                if (blrm.id == BusinessListResponseData.fromJson(jsonMap).id) {
                  emit(FetchSelectedBusinessSuccessState(
                      selectedBusinessData: blrm));
                }
              }
            } else {
              emit(FetchSelectedBusinessFailedState(
                  failedMessage: "Cannot Fetched Business"));
            }
          } else {
            emit(FetchSelectedBusinessFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(FetchSelectedBusinessFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(FetchSelectedBusinessFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<SelectedBusinessDeleteEvent>((event, emit) async {
      emit(FetchSelectedBusinessLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['id'] = event.businessId;
        LoggerUtil().infoData(map);

        http.Response response = await http.post(
            Uri.http(
                APIPathList.mainDomain, APIPathList.deleteSelectedBusiness),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          DeleteSelectedBusinessResponseModel jsonResponse =
              DeleteSelectedBusinessResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.message!.toString());
            }

            businessList.clear();

            var map2 = {};
            try {
              map2['token'] = 'bnbuujn';
              map2['user_id'] = event.userId;
              LoggerUtil().infoData(map2);

              http.Response response2 = await http.post(
                  Uri.http(APIPathList.mainDomain,
                      APIPathList.getBusinessListUserWise),
                  body: map2,
                  headers: {
                    "HTTP_AUTHORIZATION":
                        '${DateTime.now().millisecondsSinceEpoch}',
                  });
              LoggerUtil().infoData(response2.body);
              if (response2.statusCode == 200) {
                BusinessListResponseModel jsonResponse2 =
                    BusinessListResponseModel.fromJson(
                        convert.jsonDecode(response2.body));

                if (jsonResponse2.response != "failure") {
                  if (kDebugMode) {
                    LoggerUtil().infoData(jsonResponse2.data!
                        .map((c) {
                          return c.toJson();
                        })
                        .toList()
                        .toString());
                  }

                  for (var i = 0; i < jsonResponse2.data!.length; i++) {
                    if (i == 0) {
                      selectedBusiness = jsonResponse2.data![i];
                      businessList.add(BusinessListResponseData(
                          id: jsonResponse2.data![i].id,
                          userId: jsonResponse2.data![i].userId,
                          bName: jsonResponse2.data![i].bName,
                          email: jsonResponse2.data![i].email,
                          mobile: jsonResponse2.data![i].mobile,
                          gstNo: jsonResponse2.data![i].gstNo,
                          website: jsonResponse2.data![i].website,
                          address: jsonResponse2.data![i].address,
                          profile: jsonResponse2.data![i].profile,
                          businessType: jsonResponse2.data![i].businessType,
                          updatedBy: jsonResponse2.data![i].updatedBy,
                          updatedOn: jsonResponse2.data![i].updatedOn,
                          createdBy: jsonResponse2.data![i].createdBy,
                          createdOn: jsonResponse2.data![i].createdOn,
                          deletedBy: jsonResponse2.data![i].deletedBy,
                          status: jsonResponse2.data![i].status,
                          accountId: jsonResponse2.data![i].accountId,
                          isSelected: true));
                    } else {
                      businessList.add(BusinessListResponseData(
                          id: jsonResponse2.data![i].id,
                          userId: jsonResponse2.data![i].userId,
                          bName: jsonResponse2.data![i].bName,
                          email: jsonResponse2.data![i].email,
                          mobile: jsonResponse2.data![i].mobile,
                          gstNo: jsonResponse2.data![i].gstNo,
                          website: jsonResponse2.data![i].website,
                          address: jsonResponse2.data![i].address,
                          profile: jsonResponse2.data![i].profile,
                          businessType: jsonResponse2.data![i].businessType,
                          updatedBy: jsonResponse2.data![i].updatedBy,
                          updatedOn: jsonResponse2.data![i].updatedOn,
                          createdBy: jsonResponse2.data![i].createdBy,
                          createdOn: jsonResponse2.data![i].createdOn,
                          deletedBy: jsonResponse2.data![i].deletedBy,
                          status: jsonResponse2.data![i].status,
                          accountId: jsonResponse2.data![i].accountId,
                          isSelected: false));
                    }
                  }

                  sph.setString(
                      "selectedBusiness", convert.jsonEncode(selectedBusiness));

                  emit(DeleteSelectedBusinessSuccessState(
                      successData: businessList,
                      selectedBusinessData: selectedBusiness,
                      successMessage: jsonResponse.message));
                } else {
                  emit(BusinessListFailedState(
                    failedMessage: jsonResponse2.message!,
                  ));
                }
              } else {
                emit(BusinessListFailedState(
                  failedMessage:
                      'Request failed with status: ${response2.statusCode}.',
                ));
              }
            } on PlatformException {
              emit(BusinessListFailedState(
                failedMessage: 'Failed to get platform version.',
              ));
            }
          } else {
            emit(DeleteSelectedBusinessFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(DeleteSelectedBusinessFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(DeleteSelectedBusinessFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<UpdateBusinessTextChangedEvent>((event, emit) async {
      if (event.businessTaxNumber.isEmpty &&
          event.businessContactNumber.isEmpty &&
          (event.businessCountry == null) &&
          event.businessWebsite.isEmpty &&
          event.businessType.isEmpty &&
          event.businessAddress.isEmpty &&
          event.businessEmail.isEmpty &&
          event.businessName.isEmpty) {
        emit(UpdateBusinessTextChangedErrorState(
            businessNameError: "Please enter business name",
            businessEmailError: "Please enter business email",
            businessAddressError: "Please select business address",
            businessWebsiteError: "Please enter business website",
            businessTypeError: "Please select business type",
            businessTaxNumberError: "Please enter business GST Number"));
      } else if (event.businessName.isEmpty) {
        emit(UpdateBusinessTextChangedErrorState(
            businessNameError: "Please enter business name",
            businessCountryError: null,
            businessContactNumberError: null,
            businessEmailError: null,
            businessAddressError: null,
            businessWebsiteError: null,
            businessTypeError: null,
            businessTaxNumberError: null));
      } else if (event.businessCountry == null) {
        emit(UpdateBusinessTextChangedErrorState(
            businessCountryError: "Please select Country name",
            businessContactNumberError: null,
            businessNameError: null,
            businessEmailError: null,
            businessAddressError: null,
            businessWebsiteError: null,
            businessTypeError: null,
            businessTaxNumberError: null));
      } else if ((event.businessContactNumber.isEmpty) ||
          (!event.businessContactNumber.isValidContact())) {
        emit(UpdateBusinessTextChangedErrorState(
            businessContactNumberError: "Please enter proper Contact number",
            businessCountryError: null,
            businessEmailError: null,
            businessNameError: null,
            businessAddressError: null,
            businessWebsiteError: null,
            businessTypeError: null,
            businessTaxNumberError: null));
      } else if ((event.businessEmail.isEmpty) ||
          (!event.businessEmail.isValidEmail())) {
        emit(UpdateBusinessTextChangedErrorState(
            businessEmailError: "Please enter proper business email",
            businessCountryError: null,
            businessContactNumberError: null,
            businessNameError: null,
            businessAddressError: null,
            businessWebsiteError: null,
            businessTypeError: null,
            businessTaxNumberError: null));
      } else if (event.businessAddress.isEmpty) {
        emit(UpdateBusinessTextChangedErrorState(
            businessCountryError: null,
            businessContactNumberError: null,
            businessNameError: null,
            businessEmailError: null,
            businessAddressError: "Please select business address",
            businessWebsiteError: null,
            businessTypeError: null,
            businessTaxNumberError: null));
      } else if (event.businessType.isEmpty) {
        emit(UpdateBusinessTextChangedErrorState(
            businessCountryError: null,
            businessContactNumberError: null,
            businessNameError: null,
            businessEmailError: null,
            businessWebsiteError: null,
            businessTaxNumberError: null,
            businessAddressError: null,
            businessTypeError: "Please select business type"));
      } else if (event.businessWebsite.isEmpty) {
        emit(UpdateBusinessTextChangedErrorState(
            businessCountryError: null,
            businessContactNumberError: null,
            businessNameError: null,
            businessEmailError: null,
            businessTypeError: null,
            businessTaxNumberError: null,
            businessAddressError: null,
            businessWebsiteError: "Please enter business website"));
      } else if (event.businessTaxNumber.isEmpty) {
        emit(UpdateBusinessTextChangedErrorState(
            businessCountryError: null,
            businessContactNumberError: null,
            businessNameError: null,
            businessEmailError: null,
            businessTypeError: null,
            businessWebsiteError: null,
            businessAddressError: null,
            businessTaxNumberError: "Please enter business GST Number"));
      } else {
        emit(UpdateBusinessValidState());
      }
    });

    on<UpdateBusinessEvent>((event, emit) async {
      emit(UpdateBusinessLoadingState());
      if (event.businessImage != null) {
        await updateBusinessProfileImage(event, emit);
      } else {
        await updatePersonalProfile(event, emit);
      }
    });
  }

  updateBusinessProfileImage(
      UpdateBusinessEvent event, Emitter<BusinessState> emit) async {
    try {
      var requestForImage = http.MultipartRequest(
          'POST',
          Uri.http(
              APIPathList.mainDomain, APIPathList.updateBusinessProfileImage));
      requestForImage.fields['id'] = event.businessId;
      requestForImage.fields['token'] = 'bnbuujn';
      requestForImage.fields['user_id'] = event.userId;

      requestForImage.headers["HTTP_AUTHORIZATION"] =
          '${DateTime.now().millisecondsSinceEpoch}';
      requestForImage.files.add(await http.MultipartFile.fromPath(
          "profile_image",
          (event.businessImage != null) ? event.businessImage!.path : ''));

      var responseBusinessProfileImage = await requestForImage.send();
      if (responseBusinessProfileImage.statusCode == 200) {
        LoggerUtil().infoData("Image uplodade success");
        await updatePersonalProfile(event, emit);
      } else {
        emit(UpdateBusinessFailedState(
            failedMessage:
                'Request failed with status: ${responseBusinessProfileImage.statusCode}.'));
      }
    } on PlatformException {
      emit(UpdateBusinessFailedState(
          failedMessage: 'Failed to get platform version.'));
    }
  }

  updatePersonalProfile(
      UpdateBusinessEvent event, Emitter<BusinessState> emit) async {
    var map = {};
    try {
      map['token'] = 'bnbuujn';
      map['id'] = event.businessId;
      map['user_id'] = event.userId;
      map['b_name'] = event.businessName;
      map['email'] = event.businessEmail;
      map['mobile'] = event.businessContactNumber;
      map['gst_no'] = event.businessTaxNumber;
      map['website'] = event.businessWebsite;
      map['address'] = event.businessAddress;
      map['business_type'] = event.businessType;
      LoggerUtil().infoData("Input Map :- $map");
      http.Response response = await http.post(
          Uri.http(
              APIPathList.mainDomain, APIPathList.updateBusinessProfileData),
          body: map,
          headers: {
            "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
          });
      LoggerUtil().infoData(response.body);
      if (response.statusCode == 200) {
        UpdateBusinessResponseModel jsonResponse =
            UpdateBusinessResponseModel.fromJson(
                convert.jsonDecode(response.body));

        if (jsonResponse.response != "failure") {
          if (kDebugMode) {
            LoggerUtil().infoData(jsonResponse.response.toString());
          }

          emit(UpdateBusinessSuccessState(
              successMessage: jsonResponse.message!));
        } else {
          emit(UpdateBusinessFailedState(failedMessage: jsonResponse.message!));
        }
      } else {
        emit(UpdateBusinessFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.'));
      }
    } on PlatformException {
      emit(UpdateBusinessFailedState(
          failedMessage: 'Failed to get platform version.'));
    }
  }

}
