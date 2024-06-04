

import 'package:dkapp/module/login/model/login_response_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

//! Phone Number State

class LoginPhoneNumberValidState extends LoginState {}

class LoginPhoneNumberLoadingState extends LoginState {}

class LoginPhoneNumberSuccessState extends LoginState {
  late final LoginResponseData successData;
  LoginPhoneNumberSuccessState({required this.successData});
}

class LoginPhoneNumberFailedState extends LoginState {
  late final String failedMessage;
  LoginPhoneNumberFailedState({required this.failedMessage});
}

class LoginPhoneNumberErrorState extends LoginState {
  late final String errorMessage;
  LoginPhoneNumberErrorState({required this.errorMessage});
}

//! Email ID State

class LoginEmailIDValidState extends LoginState {}

class LoginEmailIDLoadingState extends LoginState {}

class LoginEmailIDSuccessState extends LoginState {
  late final LoginResponseData successData;
  LoginEmailIDSuccessState({required this.successData});
}

class LoginEmailIDFailedState extends LoginState {
  late final String failedMessage;
  LoginEmailIDFailedState({required this.failedMessage});
}

class LoginEmailIDErrorState extends LoginState {
  late final String errorMessage;
  LoginEmailIDErrorState({required this.errorMessage});
}
