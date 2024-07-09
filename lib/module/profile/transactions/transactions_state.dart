import 'package:dkapp/module/profile/model/transaction_list_response_model.dart';

class TransactionsState {}

final class TransactionsInitialState extends TransactionsState {}

//! States for Add New Cash In Transaction Event

class AddNewCashTransactionLoadingState extends TransactionsState {}

class AddNewCashTransactionSuccessState extends TransactionsState {
  late final String successMessage;
  late final bool samePageRedirection;
  AddNewCashTransactionSuccessState({
    required this.successMessage,
    required this.samePageRedirection,
  });
}

class AddNewCashTransactionFailedState extends TransactionsState {
  late final String failedMessage;
  AddNewCashTransactionFailedState({
    required this.failedMessage,
  });
}

//! States for Update Cash In Transaction Event

class UpdateCashTransactionLoadingState extends TransactionsState {}

class UpdateCashTransactionSuccessState extends TransactionsState {
  late final String successMessage;

  UpdateCashTransactionSuccessState({
    required this.successMessage,
  });
}

class UpdateCashTransactionFailedState extends TransactionsState {
  late final String failedMessage;
  UpdateCashTransactionFailedState({
    required this.failedMessage,
  });
}

//! States for Transaction List Fetch Event

class TransactionListLoadingState extends TransactionsState {}

class TransactionListLoadedState extends TransactionsState {
  late final List<TransactionListResponseData>? successData;
  TransactionListLoadedState({
    this.successData,
  });
}

class TransactionListFailedState extends TransactionsState {
  late final String failedMessage;
  TransactionListFailedState({required this.failedMessage});
}
