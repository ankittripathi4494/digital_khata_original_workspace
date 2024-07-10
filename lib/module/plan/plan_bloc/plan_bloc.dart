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
  }
}
