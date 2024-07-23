import 'package:dkapp/module/product/model/add_new_product_category_response_model.dart';
import 'package:dkapp/module/product/model/product_category_list_response_model.dart';
import 'package:dkapp/module/product/product_bloc/product_event.dart';
import 'package:dkapp/module/product/product_bloc/product_state.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';
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
        Talker().debug(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getCategogyList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        Talker().debug("Response Data :- ${response.body}");
        if (response.statusCode == 200) {
          ProductCategoryListResponseModel jsonResponse =
              ProductCategoryListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              Talker().info(jsonResponse.data!.toString());
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
        Talker().info("Input Map :- $map");
        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createCategory),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        Talker().info(response.body);
        if (response.statusCode == 200) {
          AddNewProductCategoryResponseModel jsonResponse =
              AddNewProductCategoryResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              Talker().info(jsonResponse.response.toString());
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
  }
}
