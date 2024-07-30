// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dkapp/module/discount/model/discount_list_response_model.dart';
import 'package:dkapp/module/tax/model/tax_list_response_model.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dkapp/module/product/model/product_modifier_list_response_model.dart';

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

//! Product Events
class ProductListFetchEvent extends ProductEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  ProductListFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}

class AddProductEvent extends ProductEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String productName;
  late final List<ProductModifierListResponseData> productModifiersIds;
  late final List<DiscountListResponseData> productDiscountIds;
  late final List<TaxListResponseData> productTaxIds;
  late final String productDescription;
  late final List<String> productArray;
  late final List<XFile>? productImages;
  AddProductEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.productName,
    required this.productModifiersIds,
    required this.productDiscountIds,
    required this.productTaxIds,
    required this.productDescription,
    required this.productArray,
    this.productImages,
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

class ToggleModifierSelection extends ProductEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final ProductModifierListResponseData productModifier;
  final bool isSelected;
  final int index;

  ToggleModifierSelection(
      {required this.customerId,
      required this.userId,
      required this.businessId,
      required this.productModifier,
      required this.isSelected,
      required this.index});
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
