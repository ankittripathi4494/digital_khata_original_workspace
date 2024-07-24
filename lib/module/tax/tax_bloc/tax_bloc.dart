import 'package:dkapp/module/tax/model/add_new_tax_response_model.dart';
import 'package:dkapp/module/tax/model/tax_list_response_model.dart';
import 'package:dkapp/module/tax/tax_bloc/tax_event.dart';
import 'package:dkapp/module/tax/tax_bloc/tax_state.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  TaxBloc() : super(TaxInitial()) {
    on<TaxListFetchEvent>((event, emit) async {
      // emit(TaxListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        Talker().debug(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getTaxList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        Talker().debug("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          TaxListResponseModel jsonResponse =
              TaxListResponseModel.fromJson(convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              Talker().info(jsonResponse.data!.toString());
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
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(TaxListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
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
        Talker().info("Input Map :- $map");
        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createTax),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        Talker().info(response.body);
        if (response.statusCode == 200) {
          AddNewTaxResponseModel jsonResponse = AddNewTaxResponseModel.fromJson(
              convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              Talker().info(jsonResponse.response.toString());
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
}
