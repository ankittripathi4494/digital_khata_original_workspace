import 'package:dkapp/module/service/model/add_new_service_category_response_model.dart';
import 'package:dkapp/module/service/model/service_category_list_response_model.dart';
import 'package:dkapp/module/service/model/service_list_response_model.dart';
import 'package:dkapp/module/service/service_bloc/service_event.dart';
import 'package:dkapp/module/service/service_bloc/service_state.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitial()) {
    on<ServiceCategoryListFetchEvent>((event, emit) async {
      emit(ServiceCategoryListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        LoggerUtil().infoData(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getCategogyList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          ServiceCategoryListResponseModel jsonResponse =
              ServiceCategoryListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.data!.toString());
            }

            emit(ServiceCategoryListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(ServiceCategoryListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(ServiceCategoryListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(ServiceCategoryListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
    on<AddServiceCategoryEvent>((event, emit) async {
      emit(AddNewServiceCategoryLoadingState());
      var map = {};

      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        map['category_name'] = event.serviceCategoryName;
        LoggerUtil().infoData("Input Map :- $map");
        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createCategory),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          AddNewServiceCategoryResponseModel jsonResponse =
              AddNewServiceCategoryResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.response.toString());
            }

            emit(AddNewServiceCategorySuccessState(
                successMessage: jsonResponse.message!));
          } else {
            emit(AddNewServiceCategoryFailedState(
                failedMessage: jsonResponse.message!));
          }
        } else {
          emit(AddNewServiceCategoryFailedState(
              failedMessage:
                  'Request failed with status: ${response.statusCode}.'));
        }
      } on PlatformException {
        emit(AddNewServiceCategoryFailedState(
            failedMessage: 'Failed to get platform version.'));
      }
    });
    on<ServiceListFetchEvent>((event, emit) async {
      emit(ServiceListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        map['type'] = 'S';
        LoggerUtil().infoData(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getServiceList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          ServiceListResponseModel jsonResponse =
              ServiceListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.data!.toString());
            }

            emit(ServiceListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(ServiceListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(ServiceListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(ServiceListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
    on<AddServiceEvent>((event, emit) async {
      await addProduct(emit, event);
    });
  }
  Future<void> addProduct(
      Emitter<ServiceState> emit, AddServiceEvent event) async {
    emit(AddNewServiceLoadingState());
    try {
      var requestForImage = http.MultipartRequest(
          'POST', Uri.http(APIPathList.mainDomain, APIPathList.createService));
      requestForImage.fields['branch_id'] = event.businessId;
      requestForImage.fields['token'] = 'bnbuujn';
      requestForImage.fields['user_id'] = event.userId;
      requestForImage.fields['customer_id'] = event.customerId;
      requestForImage.fields['product_name'] = event.productName;
      requestForImage.fields['modifier_id'] = event.productModifiersIds;
      requestForImage.fields['discount_id'] = event.productDiscountIds;
      requestForImage.fields['tax_id'] = event.productTaxIds;
      requestForImage.fields['description'] = event.productDescription;
      requestForImage.fields['type'] = 'S';

      requestForImage.fields['productArray'] = event.productArray.toString();
      requestForImage.headers["HTTP_AUTHORIZATION"] =
          '${DateTime.now().millisecondsSinceEpoch}';

      if ((event.productImages != null)) {
        for (XFile? element in event.productImages!) {
          requestForImage.files
              .add(await http.MultipartFile.fromPath("images", element!.path));
        }
      } else {
        requestForImage.files
            .add(http.MultipartFile.fromBytes("images", [], filename: ''));
      }
      requestForImage.fields
          .forEach((key, value) => LoggerUtil().infoData("$key and $value"));

      for (MultipartFile rx in requestForImage.files) {
        LoggerUtil().infoData(rx.filename);
      }
      var responsePlanImage = await requestForImage.send();
      if (responsePlanImage.statusCode == 200) {
        LoggerUtil().infoData("Image uplodade success with plan Creation");
        // await updateCashTransaction(event, emit);
        emit(AddNewServiceSuccessState(
          successMessage: responsePlanImage.reasonPhrase!,
        ));
      } else {
        emit(AddNewServiceFailedState(
            failedMessage:
                'Request failed with status: ${responsePlanImage.statusCode}.'));
      }
    } on PlatformException {
      emit(AddNewServiceFailedState(
          failedMessage: 'Failed to get platform version.'));
    }
  }
}
