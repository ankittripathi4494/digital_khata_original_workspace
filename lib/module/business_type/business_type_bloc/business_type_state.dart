// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dkapp/module/business_type/model/business_type_list_response_model.dart';

class BusinessTypeState {}

final class BusinessTypeInitial extends BusinessTypeState {}

//! States for Business Type List Fetch Event

class BusinessTypeListLoadingState extends BusinessTypeState {}

class BusinessTypeListLoadedState extends BusinessTypeState {
  late final List<BusinessTypeListResponseData>? businessTypeList;
  late final List<String>? choicesList;
  BusinessTypeListLoadedState({this.businessTypeList, this.choicesList});
}

class BusinessTypeListFailedState extends BusinessTypeState {
  late final String failedMessage;
  BusinessTypeListFailedState({
    required this.failedMessage,
  });
}
