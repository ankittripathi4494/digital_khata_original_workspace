// ignore_for_file: public_member_api_docs, sort_constructors_first
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
