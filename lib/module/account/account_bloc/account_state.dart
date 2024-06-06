import 'package:dkapp/module/account/model/account_response_model.dart';

class AccountState {}

final class AccountInitial extends AccountState {}

class AccountDetailLoadingState extends AccountState {}

class AccountDetailSuccessState extends AccountState {
  late final AccountResponseData successData;
  AccountDetailSuccessState({required this.successData});
}

class AccountDetailFailedState extends AccountState {
  late final String failedMessage;
  AccountDetailFailedState({required this.failedMessage});
}
