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
