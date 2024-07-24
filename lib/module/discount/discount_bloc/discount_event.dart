// ignore_for_file: public_member_api_docs, sort_constructors_first
class DiscountEvent {}

//! Product Unit Events

class DiscountListFetchEvent extends DiscountEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  DiscountListFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}

class AddDiscountEvent extends DiscountEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String discountTitle;
  late final String discountAmount;
  late final String discountType;
  AddDiscountEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.discountTitle,
    required this.discountAmount,
    required this.discountType,
  });
}
