import 'package:dkapp/module/discount/model/discount_list_response_model.dart';

class DiscountState {}

final class DiscountInitial extends DiscountState {}


//! States for Product Unit List Fetch Event

class DiscountListLoadingState extends DiscountState {}

class DiscountListLoadedState extends DiscountState {
  late final List<DiscountListResponseData>? successData;
  DiscountListLoadedState({
    this.successData,
  });
}

class DiscountListFailedState extends DiscountState {
  late final String failedMessage;
  DiscountListFailedState({
    required this.failedMessage,
  });
}

//! States for Add New Product Unit Transaction Event

class AddNewDiscountLoadingState extends DiscountState {}

class AddNewDiscountSuccessState extends DiscountState {
  late final String successMessage;
  AddNewDiscountSuccessState({
    required this.successMessage,
  });
}

class AddNewDiscountFailedState extends DiscountState {
  late final String failedMessage;
  AddNewDiscountFailedState({
    required this.failedMessage,
  });
}