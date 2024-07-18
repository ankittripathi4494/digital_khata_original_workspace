// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dkapp/module/recurring/model/loan_recurring_emi_details_response_model.dart';
import 'package:dkapp/module/recurring/model/loan_recurring_emi_list_response_model.dart';

class RecurringState {}

final class RecurringInitial extends RecurringState {}

//! States for Add New Recurring Transaction Event

class AddNewRecurringTransactionLoadingState extends RecurringState {}

class AddNewRecurringTransactionSuccessState extends RecurringState {
  late final String successMessage;
  AddNewRecurringTransactionSuccessState({
    required this.successMessage,
  });
}

class AddNewRecurringTransactionFailedState extends RecurringState {
  late final String failedMessage;
  AddNewRecurringTransactionFailedState({
    required this.failedMessage,
  });
}

//! States for Recurring Transaction List Fetch Event

class RecurringTransactionListLoadingState extends RecurringState {}

class RecurringTransactionListLoadedState extends RecurringState {
  late final List<LoanRecurringEmiListResponseData>? successData;
  RecurringTransactionListLoadedState({
    this.successData,
  });
}

class RecurringTransactionListFailedState extends RecurringState {
  late final String failedMessage;
  RecurringTransactionListFailedState({required this.failedMessage});
}

//! States for Recurring Transaction Details Fetch Event

class RecurringTransactionDetailLoadingState extends RecurringState {}

class RecurringTransactionDetailLoadedState extends RecurringState {
  late final LoanRecurringEmiDetailResponseData? successData;
  RecurringTransactionDetailLoadedState({
    this.successData,
  });
}

class RecurringTransactionDetailFailedState extends RecurringState {
  late final String failedMessage;
  RecurringTransactionDetailFailedState({
    required this.failedMessage,
  });
}
