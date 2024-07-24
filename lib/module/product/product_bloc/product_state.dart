// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dkapp/module/product/model/product_category_list_response_model.dart';
import 'package:dkapp/module/product/model/product_master_unit_list_response_model.dart';
import 'package:dkapp/module/product/model/product_unit_list_response_model.dart';

class ProductState {}

final class ProductInitial extends ProductState {}

//! States for Product Category List Fetch Event

class ProductCategoryListLoadingState extends ProductState {}

class ProductCategoryListLoadedState extends ProductState {
  late final List<ProductCategoryListResponseData>? successData;
  ProductCategoryListLoadedState({
    this.successData,
  });
}

class ProductCategoryListFailedState extends ProductState {
  late final String failedMessage;
  ProductCategoryListFailedState({required this.failedMessage});
}

//! States for Add New Product Category Transaction Event

class AddNewProductCategoryLoadingState extends ProductState {}

class AddNewProductCategorySuccessState extends ProductState {
  late final String successMessage;
  AddNewProductCategorySuccessState({
    required this.successMessage,
  });
}

class AddNewProductCategoryFailedState extends ProductState {
  late final String failedMessage;
  AddNewProductCategoryFailedState({
    required this.failedMessage,
  });
}

//! States for Product Unit List Fetch Event

class ProductUnitListLoadingState extends ProductState {}

class ProductUnitListLoadedState extends ProductState {
  late final List<ProductUnitListResponseData>? successData;
  ProductUnitListLoadedState({
    this.successData,
  });
}

class ProductUnitListFailedState extends ProductState {
  late final String failedMessage;
  ProductUnitListFailedState({
    required this.failedMessage,
  });
}

//! States for Add New Product Unit Transaction Event

class AddNewProductUnitLoadingState extends ProductState {}

class AddNewProductUnitSuccessState extends ProductState {
  late final String successMessage;
  AddNewProductUnitSuccessState({
    required this.successMessage,
  });
}

class AddNewProductUnitFailedState extends ProductState {
  late final String failedMessage;
  AddNewProductUnitFailedState({
    required this.failedMessage,
  });
}

//! States for Product Master Unit List Fetch Event

class ProductMasterUnitListLoadingState extends ProductState {}

class ProductMasterUnitListLoadedState extends ProductState {
  late final List<ProductMasterUnitListResponseData>? successData;
  ProductMasterUnitListLoadedState({
    this.successData,
  });
}

class ProductMasterUnitListFailedState extends ProductState {
  late final String failedMessage;
  ProductMasterUnitListFailedState({
    required this.failedMessage,
  });
}
