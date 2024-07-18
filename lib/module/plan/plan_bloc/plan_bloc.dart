import 'package:dkapp/module/plan/model/plan_detail_response_model.dart';
import 'package:dkapp/module/plan/model/plan_list_response_model.dart';
import 'package:dkapp/module/plan/plan_bloc/plan_event.dart';
import 'package:dkapp/module/plan/plan_bloc/plan_state.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc() : super(PlanInitial()) {
    on<PlanListFetchEvent>((event, emit) async {
      emit(PlanListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        Talker().debug(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getPlanList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        Talker().debug("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          PlanListResponseModel jsonResponse =
              PlanListResponseModel.fromJson(convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              Talker().info(jsonResponse.data!.toString());
            }

            emit(PlanListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(PlanListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(PlanListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(PlanListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
    on<AddPlanEvent>((event, emit) async {
      emit(AddNewPlanLoadingState());
      await addPlanImage(event, emit);
    });
    on<PlanDetailFetchEvent>((event, emit) async {
      emit(PlanDetailLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        map['loan_Plan_id'] = event.loanPlanId;
        Talker().debug(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getLoanPlanDetails),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        Talker().debug("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          PlanDetailResponseModel jsonResponse =
              PlanDetailResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              Talker().info(jsonResponse.data!.toString());
            }

            emit(PlanDetailLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(PlanDetailFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(PlanDetailFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(PlanDetailFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
  }

  addPlanImage(AddPlanEvent event, Emitter<PlanState> emit) async {
    try {
      var requestForImage = http.MultipartRequest(
          'POST', Uri.http(APIPathList.mainDomain, APIPathList.createLoanPlan));
      requestForImage.fields['branch_id'] = event.businessId;
      requestForImage.fields['token'] = 'bnbuujn';
      requestForImage.fields['user_id'] = event.userId;
      requestForImage.fields['customer_id'] = event.customerId;
      requestForImage.fields['title'] = event.planTile;
      requestForImage.fields['amount'] = event.planAmount;
      requestForImage.fields['notes'] = event.planNotes;
      requestForImage.fields['emi_type'] = event.planType;
      requestForImage.fields['no_of_EMI'] = event.noOfEmis;

      requestForImage.headers["HTTP_AUTHORIZATION"] =
          '${DateTime.now().millisecondsSinceEpoch}';

      if ((event.planImages != null)) {
        requestForImage.files.add(await http.MultipartFile.fromPath(
            "images", event.planImages!.path));
      } else {
        requestForImage.files
            .add(http.MultipartFile.fromBytes("images", [], filename: ''));
      }

      var responsePlanImage = await requestForImage.send();
      if (responsePlanImage.statusCode == 200) {
        Talker().info("Image uplodade success with plan Creation");
        // await updateCashTransaction(event, emit);
        emit(AddNewPlanSuccessState(
          successMessage: responsePlanImage.reasonPhrase!,
        ));
      } else {
        emit(AddNewPlanFailedState(
            failedMessage:
                'Request failed with status: ${responsePlanImage.statusCode}.'));
      }
    } on PlatformException {
      emit(AddNewPlanFailedState(
          failedMessage: 'Failed to get platform version.'));
    }
  }
}
