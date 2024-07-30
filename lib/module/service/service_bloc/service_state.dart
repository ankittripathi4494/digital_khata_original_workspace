import 'package:dkapp/module/service/model/service_category_list_response_model.dart';
import 'package:dkapp/module/service/model/service_list_response_model.dart';

class ServiceState {}

final class ServiceInitial extends ServiceState {}

//! States for ServiceCategory List Fetch Event

class ServiceCategoryListLoadingState extends ServiceState {}

class ServiceCategoryListLoadedState extends ServiceState {
  late final List<ServiceCategoryListResponseData>? successData;
  ServiceCategoryListLoadedState({
    this.successData,
  });
}

class ServiceCategoryListFailedState extends ServiceState {
  late final String failedMessage;
  ServiceCategoryListFailedState({required this.failedMessage});
}

//! States for Add New ServiceCategory Transaction Event

class AddNewServiceCategoryLoadingState extends ServiceState {}

class AddNewServiceCategorySuccessState extends ServiceState {
  late final String successMessage;
  AddNewServiceCategorySuccessState({
    required this.successMessage,
  });
}

class AddNewServiceCategoryFailedState extends ServiceState {
  late final String failedMessage;
  AddNewServiceCategoryFailedState({
    required this.failedMessage,
  });
}

//! States for Service List Fetch Event

class ServiceListLoadingState extends ServiceState {}

class ServiceListLoadedState extends ServiceState {
  late final List<ServiceListResponseData>? successData;
  ServiceListLoadedState({
    this.successData,
  });
}

class ServiceListFailedState extends ServiceState {
  late final String failedMessage;
  ServiceListFailedState({required this.failedMessage});
}

//! States for Add New Service  Event

class AddNewServiceLoadingState extends ServiceState {}

class AddNewServiceSuccessState extends ServiceState {
  late final String successMessage;
  AddNewServiceSuccessState({
    required this.successMessage,
  });
}

class AddNewServiceFailedState extends ServiceState {
  late final String failedMessage;
  AddNewServiceFailedState({
    required this.failedMessage,
  });
}