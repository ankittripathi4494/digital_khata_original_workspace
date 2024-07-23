

import 'package:dkapp/module/service/model/service_category_list_response_model.dart';

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
