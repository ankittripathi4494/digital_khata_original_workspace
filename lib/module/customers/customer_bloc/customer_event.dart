// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dkapp/module/business/model/user_group_model.dart';

class CustomerEvent {}

class AddCustomerTextChangeEvent extends CustomerEvent {
  late String? customerName;
  late String? customerMobile;
  late String? customerEmail;
  late String? customerUserGroup;
  AddCustomerTextChangeEvent({
    this.customerName,
    this.customerMobile,
    this.customerEmail,
    this.customerUserGroup,
  });
}

class UpdateCustomerTextChangeEvent extends CustomerEvent {
  late String? customerName;
  late String? customerMobile;
  late String? customerEmail;
  late String? customerUserGroup;
  late String? customerDob;
  late String? customerAddress;
  late String? customerBilling;
  UpdateCustomerTextChangeEvent({
    this.customerName,
    this.customerMobile,
    this.customerEmail,
    this.customerUserGroup,
    this.customerDob,
    this.customerAddress,
    this.customerBilling,
  });
}

class AddCustomerEvent extends CustomerEvent {
  late final String userId;
  late final String businessId;
  late String? customerName;
  late String? customerMobile;
  late String? customerEmail;
  late UserGroupResponseData? customerUserGroup;
  AddCustomerEvent({
    required this.userId,
    required this.businessId,
    this.customerName,
    this.customerMobile,
    this.customerEmail,
    this.customerUserGroup,
  });
}

class UpdateCustomerEvent extends CustomerEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late String? customerName;
  late String? customerMobile;
  late String? customerEmail;
  late String? customerDob;
  late String? customerAddress;
  late String? customerBilling;
  late UserGroupResponseData? customerUserGroup;
  UpdateCustomerEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    this.customerName,
    this.customerMobile,
    this.customerEmail,
    this.customerDob,
    this.customerAddress,
    this.customerBilling,
    this.customerUserGroup,
  });
}

class CustomerListFetchEvent extends CustomerEvent {
  late final String userId;
  late final String businessId;
  CustomerListFetchEvent({
    required this.userId,
    required this.businessId,
  });
}

class SelectedCustomerFetchEvent extends CustomerEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  SelectedCustomerFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}

class CustomerDeleteEvent extends CustomerEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  CustomerDeleteEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}
