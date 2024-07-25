import 'package:dkapp/module/recurring/model/loan_recurring_emi_details_response_model.dart';
import 'package:dkapp/module/recurring/model/loan_recurring_emi_list_response_model.dart';
import 'package:dkapp/module/recurring/recurring_bloc/recurring_event.dart';
import 'package:dkapp/module/recurring/recurring_bloc/recurring_state.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RecurringBloc extends Bloc<RecurringEvent, RecurringState> {
  RecurringBloc() : super(RecurringInitial()) {
    on<RecurringTransactionListFetchEvent>((event, emit) async {
      emit(RecurringTransactionListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        LoggerUtil().infoData(map);

        http.Response response = await http.post(
            Uri.http(
                APIPathList.mainDomain, APIPathList.getLoanRecurringEMIList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          LoanRecurringEmiListResponseModel jsonResponse =
              LoanRecurringEmiListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.data!.toString());
            }

            emit(RecurringTransactionListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(RecurringTransactionListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(RecurringTransactionListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(RecurringTransactionListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<AddRecurringTransactionEvent>((event, emit) async {
      emit(AddNewRecurringTransactionLoadingState());
      await addRecurringTransactionImage(event, emit);
    });

    on<RecurringTransactionDetailFetchEvent>((event, emit) async {
      emit(RecurringTransactionDetailLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        map['recurring_emi_ID'] = event.recurringEmiId;
        LoggerUtil().infoData(map);

        http.Response response = await http.post(
            Uri.http(
                APIPathList.mainDomain, APIPathList.getRecurringEMIDetails),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData("Recurring Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          LoanRecurringEmiDetailResponseModel jsonResponse =
              LoanRecurringEmiDetailResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.data!.toString());
            }

            emit(RecurringTransactionDetailLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(RecurringTransactionDetailFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(RecurringTransactionDetailFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(RecurringTransactionDetailFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
  }
  addRecurringTransactionImage(
      AddRecurringTransactionEvent event, Emitter<RecurringState> emit) async {
    try {
      var requestForImage = http.MultipartRequest(
          'POST',
          Uri.http(
              APIPathList.mainDomain, APIPathList.createRecurringTransaction));
      requestForImage.fields['branch_id'] = event.businessId;
      requestForImage.fields['token'] = 'bnbuujn';
      requestForImage.fields['user_id'] = event.userId;
      requestForImage.fields['customer_id'] = event.customerId;
      requestForImage.fields['title'] = event.planTitle;
      requestForImage.fields['amount'] = event.planAmount;
      requestForImage.fields['notes'] = event.planNotes;
      requestForImage.fields['emi_type'] = event.planType;
      requestForImage.fields['no_of_EMI'] = event.noOfEmis;
      requestForImage.fields['start_date'] = event.planStartDate;
      requestForImage.fields['end_date'] = event.planEndDate;

      requestForImage.headers["HTTP_AUTHORIZATION"] =
          '${DateTime.now().millisecondsSinceEpoch}';

      if ((event.recurringTransactionImages != null)) {
        requestForImage.files.add(await http.MultipartFile.fromPath(
            "images", event.recurringTransactionImages!.path));
      } else {
        requestForImage.files
            .add(http.MultipartFile.fromBytes("images", [], filename: ''));
      }

      var responsePlanImage = await requestForImage.send();
      if (responsePlanImage.statusCode == 200) {
        LoggerUtil().infoData("Image uplodade success with plan Creation");
        // await updateCashTransaction(event, emit);
        emit(AddNewRecurringTransactionSuccessState(
          successMessage: responsePlanImage.reasonPhrase!,
        ));
      } else {
        emit(AddNewRecurringTransactionFailedState(
            failedMessage:
                'Request failed with status: ${responsePlanImage.statusCode}.'));
      }
    } on PlatformException {
      emit(AddNewRecurringTransactionFailedState(
          failedMessage: 'Failed to get platform version.'));
    }
  }

}
