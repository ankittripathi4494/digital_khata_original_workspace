// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductEvent {}

//! Product Category Events
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

//! Product Unit Events

class ProductUnitListFetchEvent extends ProductEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  ProductUnitListFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}

class AddProductUnitEvent extends ProductEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String productUnitName;
  late final String productUnitPrecision;
  AddProductUnitEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.productUnitName,
    required this.productUnitPrecision,
  });
}

//! Product Master Unit Events
class ProductMasterUnitListFetchEvent extends ProductEvent {}

//! Product Modifiers Events

class ProductModifiersListFetchEvent extends ProductEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  ProductModifiersListFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}

class AddProductModifierEvent extends ProductEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String productModifierName;
  late final List<String> productModifierArray;
  AddProductModifierEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.productModifierName,
    required this.productModifierArray,
  });
}
