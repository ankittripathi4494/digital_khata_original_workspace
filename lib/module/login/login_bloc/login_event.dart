abstract class LoginEvent {}

//! Phone Number Event
class LoginPhoneNumberTextChangedEvent extends LoginEvent {
  late final String phoneNumberValue;

  LoginPhoneNumberTextChangedEvent({required this.phoneNumberValue});
}

class LoginPhoneNumberFormSubmissionEvent extends LoginEvent {
  late final String phoneNumber;

  LoginPhoneNumberFormSubmissionEvent({required this.phoneNumber});
}

//! Email ID Event
class LoginEmailTextChangedEvent extends LoginEvent {
  late final String emailValue;

  LoginEmailTextChangedEvent({required this.emailValue});
}

class LoginEmailFormSubmissionEvent extends LoginEvent {
  late final String email;

  LoginEmailFormSubmissionEvent({required this.email});
}
