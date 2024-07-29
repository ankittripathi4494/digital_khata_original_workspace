import 'package:dkapp/module/discount/discount_bloc/discount_event.dart';
import 'package:dkapp/module/discount/discount_bloc/discount_state.dart';
import 'package:dkapp/module/discount/model/add_new_discount_response_model.dart';
import 'package:dkapp/module/discount/model/discount_list_response_model.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  DiscountBloc() : super(DiscountInitial()) {
    on<DiscountListFetchEvent>(_fetchDiscountList);

    on<ToggleDiscountSelection>(_onToggleSelection);

    on<AddDiscountEvent>((event, emit) async {
      emit(AddNewDiscountLoadingState());
      var map = {};

      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        map['title'] = event.discountTitle;
        map['amount'] = event.discountAmount;
        map['dis_type'] = event.discountType;
        LoggerUtil().infoData("Input Map :- $map");
        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createDiscount),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          AddNewDiscountResponseModel jsonResponse =
              AddNewDiscountResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.response.toString());
            }

            emit(AddNewDiscountSuccessState(
                successMessage: jsonResponse.message!));
          } else {
            emit(AddNewDiscountFailedState(
                failedMessage: jsonResponse.message!));
          }
        } else {
          emit(AddNewDiscountFailedState(
              failedMessage:
                  'Request failed with status: ${response.statusCode}.'));
        }
      } on PlatformException {
        emit(AddNewDiscountFailedState(
            failedMessage: 'Failed to get platform version.'));
      }
    });
  }

  _fetchDiscountList(
      DiscountListFetchEvent event, Emitter<DiscountState> emit) async {
    // emit(DiscountListLoadingState());

    var map = {};
    try {
      map['token'] = 'bnbuujn';
      map['user_id'] = event.userId;
      map['branch_id'] = event.businessId;
      map['customer_id'] = event.customerId;
      LoggerUtil().infoData(map);

      http.Response response = await http.post(
          Uri.http(APIPathList.mainDomain, APIPathList.getDiscountList),
          body: map,
          headers: {
            "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
          });
      LoggerUtil().infoData("Response Data :- ${response.body}");
      if (response.statusCode == 200) {
        DiscountListResponseModel jsonResponse =
            DiscountListResponseModel.fromJson(
                convert.jsonDecode(response.body));

        if (jsonResponse.response != "failure") {
          if (kDebugMode) {
            LoggerUtil().infoData(jsonResponse.data!.toString());
          }

          emit(DiscountListLoadedState(
            successData: jsonResponse.data,
          ));
        } else {
          emit(DiscountListFailedState(
            failedMessage: jsonResponse.message!,
          ));
        }
      } else {
        emit(DiscountListFailedState(
          failedMessage: 'Request failed with status: ${response.statusCode}.',
        ));
      }
    } on PlatformException {
      emit(DiscountListFailedState(
        failedMessage: 'Failed to get platform version.',
      ));
    }
  }

  _onToggleSelection(
    ToggleDiscountSelection event,
    Emitter<DiscountState> emit,
  ) async {
    // emit(DiscountListLoadingState());

    var map = {};
    try {
      map['token'] = 'bnbuujn';
      map['user_id'] = event.userId;
      map['branch_id'] = event.businessId;
      map['customer_id'] = event.customerId;
      LoggerUtil().infoData(map);

      http.Response response = await http.post(
          Uri.http(APIPathList.mainDomain, APIPathList.getDiscountList),
          body: map,
          headers: {
            "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
          });
      LoggerUtil().infoData("Response Data :- ${response.body}");
      if (response.statusCode == 200) {
        DiscountListResponseModel jsonResponse =
            DiscountListResponseModel.fromJson(
                convert.jsonDecode(response.body));

        if (jsonResponse.response != "failure") {
          if (kDebugMode) {
            LoggerUtil().infoData(jsonResponse.data!.toString());
          }
          final updatedDiscounts = jsonResponse.data!.map((discount) {
            if (discount.id == event.discount.id) {
              return DiscountListResponseData(
                id: discount.id,
                customerId: discount.customerId,
                branchId: discount.branchId,
                userId: discount.userId,
                title: discount.title,
                amount: discount.amount,
                disType: discount.disType,
                createdOn: discount.createdOn,
                createdBy: discount.createdBy,
                isSelected: true,
              );
            } else {
              return DiscountListResponseData(
                id: discount.id,
                customerId: discount.customerId,
                branchId: discount.branchId,
                userId: discount.userId,
                title: discount.title,
                amount: discount.amount,
                disType: discount.disType,
                createdOn: discount.createdOn,
                createdBy: discount.createdBy,
                isSelected: false,
              );
            }
          }).toList();

          emit(DiscountListLoadedState(
            successData: updatedDiscounts,
          ));
        } else {
          emit(DiscountListFailedState(
            failedMessage: jsonResponse.message!,
          ));
        }
      } else {
        emit(DiscountListFailedState(
          failedMessage: 'Request failed with status: ${response.statusCode}.',
        ));
      }
    } on PlatformException {
      emit(DiscountListFailedState(
        failedMessage: 'Failed to get platform version.',
      ));
    }
  }
}
