// ignore_for_file: avoid_print

import 'package:dkapp/module/profile/model/transaction_list_response_model.dart';
import 'package:dkapp/module/profile/transactions/transactions_event.dart';
import 'package:dkapp/module/profile/transactions/transactions_state.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsInitialState()) {
    on<AddCashTransactionEvent>((event, emit) async {
      emit(AddNewCashTransactionLoadingState());
      await addCashTransactionImage(event, emit);
    });
    on<UpdateCashTransactionEvent>((event, emit) async {
      emit(UpdateCashTransactionLoadingState());
      await updateCashTransactionImage(event, emit);
    });

    on<TransactionListFetchEvent>((event, emit) async {
      emit(TransactionListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        print(map);

        http.Response response = await http.post(
            Uri.http(
                APIPathList.mainDomain, APIPathList.getCashTransactionList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        print(response.body);
        if (response.statusCode == 200) {
          TransactionListResponseModel jsonResponse =
              TransactionListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              print(jsonResponse.data!.toString());
            }

            emit(TransactionListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(TransactionListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(TransactionListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(TransactionListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
  }

  addCashTransactionImage(
      AddCashTransactionEvent event, Emitter<TransactionsState> emit) async {
    try {
      var requestForImage = http.MultipartRequest('POST',
          Uri.http(APIPathList.mainDomain, APIPathList.cashTransaction));
      requestForImage.fields['branch_id'] = event.businessId;
      requestForImage.fields['token'] = 'bnbuujn';
      requestForImage.fields['user_id'] = event.userId;
      requestForImage.fields['customer_id'] = event.customerId;
      requestForImage.fields['trans_type'] = event.transactionType;
      requestForImage.fields['trans_amount'] = event.transactionAmount;
      requestForImage.fields['notes'] = event.transactionNotes;

      requestForImage.headers["HTTP_AUTHORIZATION"] =
          '${DateTime.now().millisecondsSinceEpoch}';

      if ((event.transactionImages != null)) {
        requestForImage.files.add(await http.MultipartFile.fromPath(
            "images", event.transactionImages!.path));
      } else {
        requestForImage.files
            .add(http.MultipartFile.fromBytes("images", [], filename: ''));
      }

      var responseBusinessProfileImage = await requestForImage.send();
      if (responseBusinessProfileImage.statusCode == 200) {
        print("Image uplodade success");
        // await updateCashTransaction(event, emit);
        emit(AddNewCashTransactionSuccessState(
            successMessage: responseBusinessProfileImage.reasonPhrase!,
            samePageRedirection: event.samePageRedirection));
      } else {
        emit(AddNewCashTransactionFailedState(
            failedMessage:
                'Request failed with status: ${responseBusinessProfileImage.statusCode}.'));
      }
    } on PlatformException {
      emit(AddNewCashTransactionFailedState(
          failedMessage: 'Failed to get platform version.'));
    }
  }

  updateCashTransactionImage(
      UpdateCashTransactionEvent event, Emitter<TransactionsState> emit) async {
    try {
      var requestForImage = http.MultipartRequest('POST',
          Uri.http(APIPathList.mainDomain, APIPathList.cashTransactionUpdate));
      requestForImage.fields['branch_id'] = event.businessId;
      requestForImage.fields['token'] = 'bnbuujn';
      requestForImage.fields['user_id'] = event.userId;
      requestForImage.fields['customer_id'] = event.customerId;
      requestForImage.fields['transaction_id'] = event.transactionId;
      requestForImage.fields['notes'] = event.transactionNotes;

      requestForImage.headers["HTTP_AUTHORIZATION"] =
          '${DateTime.now().millisecondsSinceEpoch}';

      if ((event.transactionImages != null)) {
        requestForImage.files.add(await http.MultipartFile.fromPath(
            "images", event.transactionImages!.path));
      } else {
        requestForImage.files
            .add(http.MultipartFile.fromBytes("images", [], filename: ''));
      }

      var responseBusinessProfileImage = await requestForImage.send();
      if (responseBusinessProfileImage.statusCode == 200) {
        print("Image uplodade success");
        // await updateCashTransaction(event, emit);
        emit(UpdateCashTransactionSuccessState(
          successMessage: responseBusinessProfileImage.reasonPhrase!,
        ));
      } else {
        emit(UpdateCashTransactionFailedState(
            failedMessage:
                'Request failed with status: ${responseBusinessProfileImage.statusCode}.'));
      }
    } on PlatformException {
      emit(UpdateCashTransactionFailedState(
          failedMessage: 'Failed to get platform version.'));
    }
  }
}
