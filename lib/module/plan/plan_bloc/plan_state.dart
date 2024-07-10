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
