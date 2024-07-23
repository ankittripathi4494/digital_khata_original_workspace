// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductEvent {}

class ProductCategoryListFetchEvent extends ProductEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  ProductCategoryListFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}

class AddProductCategoryEvent extends ProductEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String productCategoryName;
  AddProductCategoryEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.productCategoryName,
  });
}
