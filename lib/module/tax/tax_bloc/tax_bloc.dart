import 'package:dkapp/module/tax/model/add_new_tax_response_model.dart';
import 'package:dkapp/module/tax/model/tax_list_response_model.dart';
import 'package:dkapp/module/tax/tax_bloc/tax_event.dart';
import 'package:dkapp/module/tax/tax_bloc/tax_state.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  TaxBloc() : super(TaxInitial()) {
    on<TaxListFetchEvent>(_fetchTaxList);
     on<ToggleTaxSelection>(_onToggleSelection);
    on<AddTaxEvent>((event, emit) async {
      emit(AddNewTaxLoadingState());
      var map = {};

      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        map['title'] = event.taxTitle;
        map['amount'] = event.taxAmount;
        LoggerUtil().infoData("Input Map :- $map");
        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createTax),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          AddNewTaxResponseModel jsonResponse = AddNewTaxResponseModel.fromJson(
              convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.response.toString());
            }

            emit(AddNewTaxSuccessState(successMessage: jsonResponse.message!));
          } else {
            emit(AddNewTaxFailedState(failedMessage: jsonResponse.message!));
          }
        } else {
          emit(AddNewTaxFailedState(
              failedMessage:
                  'Request failed with status: ${response.statusCode}.'));
        }
      } on PlatformException {
        emit(AddNewTaxFailedState(
            failedMessage: 'Failed to get platform version.'));
      }
    });
  }

  _fetchTaxList(TaxListFetchEvent event, Emitter<TaxState> emit) async {
    // emit(TaxListLoadingState());

    var map = {};
    try {
      map['token'] = 'bnbuujn';
      map['user_id'] = event.userId;
      map['branch_id'] = event.businessId;
      map['customer_id'] = event.customerId;
      LoggerUtil().infoData(map);

      http.Response response = await http.post(
          Uri.http(APIPathList.mainDomain, APIPathList.getTaxList),
          body: map,
          headers: {
            "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
          });
      LoggerUtil().infoData("Response Data :- ${response.body}");
      if (response.statusCode == 200) {
        TaxListResponseModel jsonResponse =
            TaxListResponseModel.fromJson(convert.jsonDecode(response.body));

        if (jsonResponse.response != "failure") {
          if (kDebugMode) {
            LoggerUtil().infoData(jsonResponse.data!.toString());
          }

          emit(TaxListLoadedState(
            successData: jsonResponse.data,
          ));
        } else {
          emit(TaxListFailedState(
            failedMessage: jsonResponse.message!,
          ));
        }
      } else {
        emit(TaxListFailedState(
          failedMessage: 'Request failed with status: ${response.statusCode}.',
        ));
      }
    } on PlatformException {
      emit(TaxListFailedState(
        failedMessage: 'Failed to get platform version.',
      ));
    }
  }
  _onToggleSelection(
    ToggleTaxSelection event,
    Emitter<TaxState> emit,
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
          Uri.http(APIPathList.mainDomain, APIPathList.getTaxList),
          body: map,
          headers: {
            "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
          });
      LoggerUtil().infoData("Response Data :- ${response.body}");
      if (response.statusCode == 200) {
        TaxListResponseModel jsonResponse =
            TaxListResponseModel.fromJson(
                convert.jsonDecode(response.body));

        if (jsonResponse.response != "failure") {
          if (kDebugMode) {
            LoggerUtil().infoData(jsonResponse.data!.toString());
          }
          final updatedDiscounts = jsonResponse.data!.map((tax) {
            if (tax.id == event.tax.id) {
              return TaxListResponseData(
                id: tax.id,
                customerId: tax.customerId,
                branchId: tax.branchId,
                userId: tax.userId,
                title: tax.title,
                amount: tax.amount,
                disType: tax.disType,
                createdOn: tax.createdOn,
                createdBy: tax.createdBy,
                isSelected: true,
              );
            } else {
              return TaxListResponseData(
                id: tax.id,
                customerId: tax.customerId,
                branchId: tax.branchId,
                userId: tax.userId,
                title: tax.title,
                amount: tax.amount,
                disType: tax.disType,
                createdOn: tax.createdOn,
                createdBy: tax.createdBy,
                isSelected: false,
              );
            }
          }).toList();

          emit(TaxListLoadedState(
            successData: updatedDiscounts,
          ));
        } else {
          emit(TaxListFailedState(
            failedMessage: jsonResponse.message!,
          ));
        }
      } else {
        emit(TaxListFailedState(
          failedMessage: 'Request failed with status: ${response.statusCode}.',
        ));
      }
    } on PlatformException {
      emit(TaxListFailedState(
        failedMessage: 'Failed to get platform version.',
      ));
    }
   
  }


}
