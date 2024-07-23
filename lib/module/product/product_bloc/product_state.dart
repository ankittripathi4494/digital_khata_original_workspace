import 'package:dkapp/module/product/model/product_category_list_response_model.dart';

class ProductState {}

final class ProductInitial extends ProductState {}

//! States for ProductCategory List Fetch Event

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

//! States for Add New ProductCategory Transaction Event

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
