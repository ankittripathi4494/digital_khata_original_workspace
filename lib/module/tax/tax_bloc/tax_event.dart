// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dkapp/module/tax/model/tax_list_response_model.dart';

class TaxEvent {}

//! Product Unit Events

class TaxListFetchEvent extends TaxEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  TaxListFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}

class ToggleTaxSelection extends TaxEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final TaxListResponseData tax;
  ToggleTaxSelection({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.tax,
  });

}


class AddTaxEvent extends TaxEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String taxTitle;
  late final String taxAmount;
  AddTaxEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.taxTitle,
    required this.taxAmount,
  });
}
