// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dkapp/module/customers/model/customer_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';

class CustomerState {}

final class CustomerInitial extends CustomerState {}

class CustomerListLoadingState extends CustomerState {}

//! States for Customer List Fetch Event

class CustomerListLoadedState extends CustomerState {
  late final List<CustomerResponseData>? successData;
  CustomerListLoadedState({
    this.successData,
  });
}

class CustomerListFailedState extends CustomerState {
  late final String failedMessage;
  CustomerListFailedState({required this.failedMessage});
}

//! States for Add New Customer Event

class AddNewCustomerSuccessState extends CustomerState {
  late final String successMessage;
  AddNewCustomerSuccessState({
    required this.successMessage,
  });
}

class AddNewCustomerFailedState extends CustomerState {
  late final String failedMessage;
  AddNewCustomerFailedState({
    required this.failedMessage,
  });
}

//! States for Update Customer Event

class UpdateCustomerSuccessState extends CustomerState {
  late final String successMessage;
  UpdateCustomerSuccessState({
    required this.successMessage,
  });
}

class UpdateCustomerFailedState extends CustomerState {
  late final String failedMessage;
  UpdateCustomerFailedState({
    required this.failedMessage,
  });
}

//! States for Add New User customer Text Change Event

class AddNewCustomerValidState extends CustomerState {}

class AddNewCustomerTextChangedErrorState extends CustomerState {
  late String? customerNameError;
  late String? customerMobileError;
  late String? customerEmailError;
  late String? userGroupResponseDataError;
  AddNewCustomerTextChangedErrorState(
      {this.customerNameError,
      this.customerMobileError,
      this.customerEmailError,
      this.userGroupResponseDataError});
}

//! States for Update customer Text Change Event

class UpdateCustomerValidState extends CustomerState {}

class UpdateCustomerTextChangedErrorState extends CustomerState {
  late String? customerNameError;
  late String? customerMobileError;
  late String? customerEmailError;
  late String? userGroupResponseDataError;
  late String? customerDobError;
  late String? customerAddressError;
  late String? customerBillingError;
  UpdateCustomerTextChangedErrorState({
    this.customerNameError,
    this.customerMobileError,
    this.customerEmailError,
    this.userGroupResponseDataError,
    this.customerDobError,
    this.customerAddressError,
    this.customerBillingError,
  });
}

//! States for Selected Customer Details Fetch Event
class SelectedCustomerDetailsLoadingState extends CustomerState {}

class SelectedCustomerDetailsLoadedState extends CustomerState {
  late final SelectedCustomerResponseData selectedCustomerDetailedData;
  SelectedCustomerDetailsLoadedState({
    required this.selectedCustomerDetailedData,
  });
}

class SelectedCustomerDetailsFailedState extends CustomerState {
  late final String failedMessage;
  SelectedCustomerDetailsFailedState({
    required this.failedMessage,
  });
}

//! States for Delete Customer Event

class DeleteCustomerSuccessState extends CustomerState {
  late final String successMessage;
  DeleteCustomerSuccessState({
    required this.successMessage,
  });
}

class DeleteCustomerFailedState extends CustomerState {
  late final String failedMessage;
  DeleteCustomerFailedState({
    required this.failedMessage,
  });
}
