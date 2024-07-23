import 'package:dkapp/module/service/model/add_new_service_category_response_model.dart';
import 'package:dkapp/module/service/model/service_category_list_response_model.dart';
import 'package:dkapp/module/service/service_bloc/service_event.dart';
import 'package:dkapp/module/service/service_bloc/service_state.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

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
        Talker().debug(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getCategogyList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        Talker().debug("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          ServiceCategoryListResponseModel jsonResponse =
              ServiceCategoryListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              Talker().info(jsonResponse.data!.toString());
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
        Talker().info("Input Map :- $map");
        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createCategory),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        Talker().info(response.body);
        if (response.statusCode == 200) {
          AddNewServiceCategoryResponseModel jsonResponse =
              AddNewServiceCategoryResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              Talker().info(jsonResponse.response.toString());
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
  }
}
