// ignore_for_file: avoid_Talker().info

import 'package:dkapp/module/account/account_bloc/account_event.dart';
import 'package:dkapp/module/account/account_bloc/account_state.dart';
import 'package:dkapp/module/account/model/account_response_model.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:talker/talker.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<UserAccountFetchEvent>((event, emit) async {
      emit(AccountDetailLoadingState());
      var map = {};

      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.fetchUserProfile),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        Talker().info(response.body);
        if (response.statusCode == 200) {
          AccountResponseModel jsonResponse =
              AccountResponseModel.fromJson(convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              Talker().info(jsonResponse.response.toString());
            }

            if (kDebugMode) {
              Talker().info(jsonResponse.data!.first.dob);
              Talker().info(jsonResponse.data!.first.fullname);
            }
            emit(AccountDetailSuccessState(
                successData: jsonResponse.data!.first));
          } else {
            emit(AccountDetailFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(AccountDetailFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(AccountDetailFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
  }
}
