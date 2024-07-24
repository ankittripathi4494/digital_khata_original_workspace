
import 'package:dkapp/module/tax/model/tax_list_response_model.dart';

class TaxState {}

final class TaxInitial extends TaxState {}


//! States for Product Unit List Fetch Event

class TaxListLoadingState extends TaxState {}

class TaxListLoadedState extends TaxState {
  late final List<TaxListResponseData>? successData;
  TaxListLoadedState({
    this.successData,
  });
}

class TaxListFailedState extends TaxState {
  late final String failedMessage;
  TaxListFailedState({
    required this.failedMessage,
  });
}

//! States for Add New Product Unit Transaction Event

class AddNewTaxLoadingState extends TaxState {}

class AddNewTaxSuccessState extends TaxState {
  late final String successMessage;
  AddNewTaxSuccessState({
    required this.successMessage,
  });
}

class AddNewTaxFailedState extends TaxState {
  late final String failedMessage;
  AddNewTaxFailedState({
    required this.failedMessage,
  });
}