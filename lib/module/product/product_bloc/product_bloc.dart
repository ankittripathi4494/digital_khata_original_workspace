import 'package:dkapp/module/product/model/add_new_product_category_response_model.dart';
import 'package:dkapp/module/product/model/add_new_product_modifier_response_model.dart';
import 'package:dkapp/module/product/model/product_category_list_response_model.dart';
import 'package:dkapp/module/product/model/product_list_response_model.dart';
import 'package:dkapp/module/product/model/product_master_unit_list_response_model.dart';
import 'package:dkapp/module/product/model/product_modifier_list_response_model.dart';
import 'package:dkapp/module/product/model/product_unit_list_response_model.dart';
import 'package:dkapp/module/product/product_bloc/product_event.dart';
import 'package:dkapp/module/product/product_bloc/product_state.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductCategoryListFetchEvent>((event, emit) async {
      emit(ProductCategoryListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        LoggerUtil().infoData(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getCategogyList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          ProductCategoryListResponseModel jsonResponse =
              ProductCategoryListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.data!.toString());
            }

            emit(ProductCategoryListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(ProductCategoryListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(ProductCategoryListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(ProductCategoryListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
    on<AddProductCategoryEvent>((event, emit) async {
      emit(AddNewProductCategoryLoadingState());
      var map = {};

      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        map['category_name'] = event.productCategoryName;
        LoggerUtil().infoData("Input Map :- $map");
        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createCategory),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          AddNewProductCategoryResponseModel jsonResponse =
              AddNewProductCategoryResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.response.toString());
            }

            emit(AddNewProductCategorySuccessState(
                successMessage: jsonResponse.message!));
          } else {
            emit(AddNewProductCategoryFailedState(
                failedMessage: jsonResponse.message!));
          }
        } else {
          emit(AddNewProductCategoryFailedState(
              failedMessage:
                  'Request failed with status: ${response.statusCode}.'));
        }
      } on PlatformException {
        emit(AddNewProductCategoryFailedState(
            failedMessage: 'Failed to get platform version.'));
      }
    });

    on<ProductListFetchEvent>((event, emit) async {
      emit(ProductListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        map['type'] = 'P';
        LoggerUtil().infoData(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getProductList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          ProductListResponseModel jsonResponse =
              ProductListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.data!.toString());
            }

            emit(ProductListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(ProductListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(ProductListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(ProductListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
    on<AddProductEvent>((event, emit) async {
      await addProduct(emit, event);
    });

    on<ProductUnitListFetchEvent>((event, emit) async {
      // emit(ProductUnitListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        LoggerUtil().infoData(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getUnitList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          ProductUnitListResponseModel jsonResponse =
              ProductUnitListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.data!.toString());
            }

            emit(ProductUnitListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(ProductUnitListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(ProductUnitListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(ProductUnitListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
    on<AddProductUnitEvent>((event, emit) async {
      emit(AddNewProductUnitLoadingState());
      var map = {};

      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        map['unit_name'] = event.productUnitName;
        map['unit_qty'] = event.productUnitPrecision;
        LoggerUtil().infoData("Input Map :- $map");
        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createUnit),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          AddNewProductCategoryResponseModel jsonResponse =
              AddNewProductCategoryResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.response.toString());
            }

            emit(AddNewProductUnitSuccessState(
                successMessage: jsonResponse.message!));
          } else {
            emit(AddNewProductUnitFailedState(
                failedMessage: jsonResponse.message!));
          }
        } else {
          emit(AddNewProductUnitFailedState(
              failedMessage:
                  'Request failed with status: ${response.statusCode}.'));
        }
      } on PlatformException {
        emit(AddNewProductUnitFailedState(
            failedMessage: 'Failed to get platform version.'));
      }
    });
    on<ProductMasterUnitListFetchEvent>((event, emit) async {
      emit(ProductMasterUnitListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';

        LoggerUtil().infoData(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getMasterUnitList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          ProductMasterUnitListResponseModel jsonResponse =
              ProductMasterUnitListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.data!.toString());
            }

            emit(ProductMasterUnitListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(ProductMasterUnitListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(ProductMasterUnitListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(ProductMasterUnitListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<ProductModifiersListFetchEvent>(_fetchModifierList);
    on<ToggleModifierSelection>(_onToggleSelection);
    on<AddProductModifierEvent>((event, emit) async {
      emit(AddProductModifierLoadingState());
      var map = {};

      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['branch_id'] = event.businessId;
        map['customer_id'] = event.customerId;
        map['title'] = event.productModifierName;
        map['modifierArray'] = event.productModifierArray.toString();

        LoggerUtil().infoData("Input Map :- $map");
        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createModifier),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          AddNewProductModifierResponseModel jsonResponse =
              AddNewProductModifierResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().debugData(jsonResponse.response);
            }

            emit(AddProductModifierSuccessState(
                successMessage: jsonResponse.message!));
          } else {
            emit(AddProductModifierFailedState(
                failedMessage: jsonResponse.message!));
          }
        } else {
          emit(AddProductModifierFailedState(
              failedMessage:
                  'Request failed with status: ${response.statusCode}.'));
        }
      } on PlatformException {
        emit(AddProductModifierFailedState(
            failedMessage: 'Failed to get platform version.'));
      }
    });
  }

  Future<void> addProduct(
      Emitter<ProductState> emit, AddProductEvent event) async {
    emit(AddNewProductLoadingState());
    try {
      var requestForImage = http.MultipartRequest(
          'POST', Uri.http(APIPathList.mainDomain, APIPathList.createProduct));
      requestForImage.fields['branch_id'] = event.businessId;
      requestForImage.fields['token'] = 'bnbuujn';
      requestForImage.fields['user_id'] = event.userId;
      requestForImage.fields['customer_id'] = event.customerId;
      requestForImage.fields['product_name'] = event.productName;
      requestForImage.fields['modifier_id'] =
          (event.productModifiersIds.isNotEmpty)
              ? event.productModifiersIds.map((c) => c.accountId).join(',')
              : '';
      requestForImage.fields['discount_id'] =
          (event.productDiscountIds.isNotEmpty)
              ? event.productDiscountIds.map((c) => c.id).join(',')
              : '';
      requestForImage.fields['tax_id'] = (event.productTaxIds.isNotEmpty)
          ? event.productTaxIds.map((c) => c.id).join(',')
          : '';
      requestForImage.fields['description'] = event.productDescription;
      requestForImage.fields['productArray'] = event.productArray.toString();
      requestForImage.fields['type'] = 'P';
      requestForImage.headers["HTTP_AUTHORIZATION"] =
          '${DateTime.now().millisecondsSinceEpoch}';

      if ((event.productImages != null)) {
        for (XFile element in event.productImages!) {
          var bytes = await element.readAsBytes();
          requestForImage.files.add(http.MultipartFile.fromBytes(
              "images", bytes,
              filename: element.name));
        }
      } else {
        requestForImage.files
            .add(http.MultipartFile.fromBytes("images", [], filename: ''));
      }
      requestForImage.fields
          .forEach((key, value) => LoggerUtil().infoData("$key and $value"));

      for (MultipartFile rx in requestForImage.files) {
        LoggerUtil().infoData(rx.filename);
      }

      var responsePlanImage = await requestForImage.send();
      if (responsePlanImage.statusCode == 200) {
        LoggerUtil().infoData("Image uplodade success with plan Creation");
        // await updateCashTransaction(event, emit);
        emit(AddNewProductSuccessState(
          successMessage: responsePlanImage.reasonPhrase!,
        ));
      } else {
        emit(AddNewProductFailedState(
            failedMessage:
                'Request failed with status: ${responsePlanImage.statusCode}.'));
      }
    } on PlatformException {
      emit(AddNewProductFailedState(
          failedMessage: 'Failed to get platform version.'));
    }
  }

  _fetchModifierList(
      ProductModifiersListFetchEvent event, Emitter<ProductState> emit) async {
    emit(ProductModifiersListLoadingState());

    var map = {};
    try {
      map['token'] = 'bnbuujn';
      map['user_id'] = event.userId;
      map['branch_id'] = event.businessId;
      map['customer_id'] = event.customerId;
      LoggerUtil().infoData(map);

      http.Response response = await http.post(
          Uri.http(APIPathList.mainDomain, APIPathList.getModifierList),
          body: map,
          headers: {
            "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
          });
      LoggerUtil().infoData("Response Data :- ${response.body}");
      if (response.statusCode == 200) {
        ProductModifierListResponseModel jsonResponse =
            ProductModifierListResponseModel.fromJson(
                convert.jsonDecode(response.body));

        if (jsonResponse.response != "failure") {
          if (kDebugMode) {
            LoggerUtil().debugData(
                (jsonResponse.data as List<ProductModifierListResponseData>)
                    .toString());
          }

          emit(ProductModifiersListLoadedState(
            successData: jsonResponse.data!,
          ));
        } else {
          emit(ProductModifiersListFailedState(
            failedMessage: jsonResponse.message!,
          ));
        }
      } else {
        emit(ProductModifiersListFailedState(
          failedMessage: 'Request failed with status: ${response.statusCode}.',
        ));
      }
    } on PlatformException {
      emit(ProductModifiersListFailedState(
        failedMessage: 'Failed to get platform version.',
      ));
    }
  }

  _onToggleSelection(
    ToggleModifierSelection event,
    Emitter<ProductState> emit,
  ) async {
    // emit(DiscountListLoadingState());
    final loadedState = state as ProductModifiersListLoadedState;
    final newModifiers =
        List<ProductModifierListResponseData>.from(loadedState.successData!);
    newModifiers[event.index].isSelected =
        !(newModifiers[event.index].isSelected ?? false);
    emit(ProductModifiersListLoadedState(successData: newModifiers));
  }
}
