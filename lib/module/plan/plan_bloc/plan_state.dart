// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dkapp/module/plan/model/plan_detail_response_model.dart';
import 'package:dkapp/module/plan/model/plan_list_response_model.dart';

class PlanState {}

final class PlanInitial extends PlanState {}

//! States for Plan List Fetch Event

class PlanListLoadingState extends PlanState {}

class PlanListLoadedState extends PlanState {
  late final List<PlanListResponseData>? successData;
  PlanListLoadedState({
    this.successData,
  });
}

class PlanListFailedState extends PlanState {
  late final String failedMessage;
  PlanListFailedState({required this.failedMessage});
}

//! States for Add New Plan Transaction Event

class AddNewPlanLoadingState extends PlanState {}

class AddNewPlanSuccessState extends PlanState {
  late final String successMessage;
  AddNewPlanSuccessState({
    required this.successMessage,
  });
}

class AddNewPlanFailedState extends PlanState {
  late final String failedMessage;
  AddNewPlanFailedState({
    required this.failedMessage,
  });
}

//! States for Plan Details Fetch Event

class PlanDetailLoadingState extends PlanState {}

class PlanDetailLoadedState extends PlanState {
  late final List<PlanDetailResponseData>? successData;
  PlanDetailLoadedState({
    this.successData,
  });
}

class PlanDetailFailedState extends PlanState {
  late final String failedMessage;
  PlanDetailFailedState({
    required this.failedMessage,
  });
}
