import 'package:dkapp/module/discount/discount_bloc/discount_event.dart';
import 'package:dkapp/module/discount/discount_bloc/discount_state.dart';
import 'package:dkapp/module/discount/model/add_new_discount_response_model.dart';
import 'package:dkapp/module/discount/model/discount_list_response_model.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  DiscountBloc() : super(DiscountInitial()) {
    on<DiscountListFetchEvent>((event, emit) async {
      // emit(DiscountListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        Talker().debug(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getDiscountList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        Talker().debug("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          DiscountListResponseModel jsonResponse =
              DiscountListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              Talker().info(jsonResponse.data!.toString());
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
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(DiscountListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
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
        Talker().info("Input Map :- $map");
        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createDiscount),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        Talker().info(response.body);
        if (response.statusCode == 200) {
          AddNewDiscountResponseModel jsonResponse =
              AddNewDiscountResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              Talker().info(jsonResponse.response.toString());
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
}
