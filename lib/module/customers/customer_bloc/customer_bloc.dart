// ignore_for_file: avoid_print

import 'package:dkapp/module/customers/customer_bloc/customer_event.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_state.dart';
import 'package:dkapp/module/customers/model/add_new_customer_response_model.dart';
import 'package:dkapp/module/customers/model/customer_response_model.dart';
import 'package:dkapp/module/customers/model/delete_customer_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/customers/model/update_customer_response_model.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerInitial()) {
    on<AddCustomerTextChangeEvent>((event, emit) async {
      if ((event.customerName!.isNotEmpty) &&
          ((event.customerMobile!.isNotEmpty) &&
              (event.customerMobile!.length == 10)) &&
          ((event.customerEmail!.isNotEmpty) &&
              (event.customerEmail!.isValidEmail())) &&
          (event.customerUserGroup!.isNotEmpty)) {
        emit(AddNewCustomerValidState());
      } else {
        emit(AddNewCustomerTextChangedErrorState(
            customerNameError: (event.customerName!.isEmpty)
                ? "Please enter customer name"
                : null,
            customerMobileError: (event.customerMobile!.isEmpty)
                ? "Please enter customer contact number"
                : ((event.customerMobile!.length < 10)
                    ? "Please enter contact number upto 10 digits"
                    : null),
            customerEmailError: (event.customerEmail!.isEmpty)
                ? "Please enter customer email"
                : ((!event.customerEmail!.isValidEmail())
                    ? "Please enter valid customer email"
                    : null),
            userGroupResponseDataError: (event.customerUserGroup!.isEmpty)
                ? "Please select customer user group"
                : null));
      }
    });

    on<UpdateCustomerTextChangeEvent>((event, emit) async {
      if ((event.customerName!.isNotEmpty) &&
          ((event.customerMobile!.isNotEmpty) &&
              (event.customerMobile!.length == 10)) &&
          ((event.customerEmail!.isNotEmpty) &&
              (event.customerEmail!.isValidEmail())) &&
          (event.customerUserGroup!.isNotEmpty) &&
          (event.customerAddress!.isNotEmpty) &&
          (event.customerBilling!.isNotEmpty) &&
          (event.customerDob!.isNotEmpty)) {
        emit(UpdateCustomerValidState());
      } else {
        emit(UpdateCustomerTextChangedErrorState(
          customerNameError: (event.customerName!.isEmpty)
              ? "Please enter customer name"
              : null,
          customerMobileError: (event.customerMobile!.isEmpty)
              ? "Please enter customer contact number"
              : ((event.customerMobile!.length < 10)
                  ? "Please enter contact number upto 10 digits"
                  : null),
          customerEmailError: (event.customerEmail!.isEmpty)
              ? "Please enter customer email"
              : ((!event.customerEmail!.isValidEmail())
                  ? "Please enter valid customer email"
                  : null),
          userGroupResponseDataError: (event.customerUserGroup!.isEmpty)
              ? "Please select customer user group"
              : null,
          customerAddressError: (event.customerAddress!.isEmpty)
              ? "Please select customer address"
              : null,
          customerBillingError: (event.customerBilling!.isEmpty)
              ? "Please enter customer billing cycle"
              : null,
          customerDobError: (event.customerDob!.isEmpty)
              ? "Please select customer date of birth"
              : null,
        ));
      }
    });

    on<AddCustomerEvent>((event, emit) async {
      emit(CustomerListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['group_id'] = event.customerUserGroup?.id;
        map['fullname'] = event.customerName;
        map['mobile'] = event.customerMobile;
        map['email'] = event.customerEmail;
        print(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createCustomer),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        print(response.body);
        if (response.statusCode == 200) {
          AddNewCustomerResponseModel jsonResponse =
              AddNewCustomerResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              print(jsonResponse.message!.toString());
            }

            emit(AddNewCustomerSuccessState(
              successMessage: jsonResponse.message!,
            ));
          } else {
            emit(AddNewCustomerFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(AddNewCustomerFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(AddNewCustomerFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<UpdateCustomerEvent>((event, emit) async {
      emit(CustomerListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['id'] = event.customerId;
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['group_id'] = event.customerUserGroup?.id;
        map['fullname'] = event.customerName;
        map['mobile'] = event.customerMobile;
        map['email'] = event.customerEmail;
        map['billing_cycle'] = event.customerBilling;
        map['dob'] = event.customerDob;
        map['address'] = event.customerAddress;
        print(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.updateCustomer),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        print(response.body);
        if (response.statusCode == 200) {
          UpdateCustomerResponseModel jsonResponse =
              UpdateCustomerResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              print(jsonResponse.message!.toString());
            }

            emit(UpdateCustomerSuccessState(
              successMessage: jsonResponse.message!,
            ));
          } else {
            emit(UpdateCustomerFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(UpdateCustomerFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(UpdateCustomerFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<CustomerListFetchEvent>((event, emit) async {
      emit(CustomerListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        print(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getCustomerList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        // print(response.body);
        if (response.statusCode == 200) {
          CustomerResponseModel jsonResponse =
              CustomerResponseModel.fromJson(convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              print(jsonResponse.data!.toString());
            }

            emit(CustomerListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(CustomerListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(CustomerListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(CustomerListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<SelectedCustomerFetchEvent>((event, emit) async {
      emit(SelectedCustomerDetailsLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['id'] = event.customerId;
        print(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getCustomerDetails),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        // print(response.body);
        if (response.statusCode == 200) {
          SelectedCustomerResponseModel jsonResponse =
              SelectedCustomerResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              print(jsonResponse.data!.toString());
            }

            emit(SelectedCustomerDetailsLoadedState(
              selectedCustomerDetailedData: jsonResponse.data!,
            ));
          } else {
            emit(SelectedCustomerDetailsFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(SelectedCustomerDetailsFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(SelectedCustomerDetailsFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<CustomerDeleteEvent>((event, emit) async {
      emit(CustomerListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['id'] = event.customerId;
        print(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.deleteCustomer),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        print(response.body);
        if (response.statusCode == 200) {
          DeleteCustomerResponseModel jsonResponse =
              DeleteCustomerResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              print(jsonResponse.message!.toString());
            }

            emit(DeleteCustomerSuccessState(
              successMessage: jsonResponse.message!,
            ));
          } else {
            emit(DeleteCustomerFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(DeleteCustomerFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(DeleteCustomerFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
  }
}
