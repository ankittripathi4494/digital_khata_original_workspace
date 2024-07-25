import 'package:dkapp/module/product/model/add_new_product_category_response_model.dart';
import 'package:dkapp/module/product/model/add_new_product_modifier_response_model.dart';
import 'package:dkapp/module/product/model/product_category_list_response_model.dart';
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
    on<ProductModifiersListFetchEvent>((event, emit) async {
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
              LoggerUtil().debugData((jsonResponse.data as ProductModifierListResponseData).toJson());
            }

            emit(ProductModifiersListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(ProductModifiersListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(ProductModifiersListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(ProductModifiersListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
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
}
