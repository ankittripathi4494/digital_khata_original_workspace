// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../model/business_list_response_model.dart';

class BusinessState {}

final class BusinessInitial extends BusinessState {}

//! States for Business List Fetch Event and Select Business event

class BusinessListLoadingState extends BusinessState {}

class BusinessListLoadedState extends BusinessState {
  late final List<BusinessListResponseData>? successData;
  late final BusinessListResponseData? selectedBusinessData;
  BusinessListLoadedState({
    this.successData,
    this.selectedBusinessData,
  });
}

class BusinessListFailedState extends BusinessState {
  late final String failedMessage;
  BusinessListFailedState({required this.failedMessage});
}

//! States for Add New Business Event

class AddNewBusinessLoadingState extends BusinessState {}

class AddNewBusinessSuccessState extends BusinessState {
  late final String successMessage;
  AddNewBusinessSuccessState({
    required this.successMessage,
  });
}

class AddNewBusinessFailedState extends BusinessState {
  late final String failedMessage;
  AddNewBusinessFailedState({
    required this.failedMessage,
  });
}

//! States for Add New Business Text Change Event

class AddNewBusinessValidState extends BusinessState {}

class AddNewBusinessTextChangedErrorState extends BusinessState {
  late String? businessNameError;
  late String? businessTypeError;
  late String? businessAddressError;
  late String? businessEmailError;
  late String? businessWebsiteError;
  late String? businessTaxNumberError;
  AddNewBusinessTextChangedErrorState({
    this.businessNameError,
    this.businessTypeError,
    this.businessAddressError,
    this.businessEmailError,
    this.businessWebsiteError,
    this.businessTaxNumberError,
  });
}

//! States for Fetch Selected Business Event

class FetchSelectedBusinessLoadingState extends BusinessState {}

class FetchSelectedBusinessSuccessState extends BusinessState {
  late final BusinessListResponseData? selectedBusinessData;
  FetchSelectedBusinessSuccessState({
    this.selectedBusinessData,
  });
}

class FetchSelectedBusinessFailedState extends BusinessState {
  late final String failedMessage;
  FetchSelectedBusinessFailedState({
    required this.failedMessage,
  });
}

//! States for Delete Selected Business Event

class DeleteSelectedBusinessSuccessState extends BusinessState {
  late final String? successMessage;
  late final List<BusinessListResponseData>? successData;
  late final BusinessListResponseData? selectedBusinessData;
  DeleteSelectedBusinessSuccessState({
    required this.successMessage,
    required this.successData,
    required this.selectedBusinessData,
  });
  
}

class DeleteSelectedBusinessFailedState extends BusinessState {
  late final String failedMessage;
  DeleteSelectedBusinessFailedState({
    required this.failedMessage,
  });
}