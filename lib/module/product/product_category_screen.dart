// ignore_for_file: must_be_immutable

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/product/model/product_category_list_response_model.dart';
import 'package:dkapp/module/product/product_bloc/product_bloc.dart';
import 'package:dkapp/module/product/product_bloc/product_event.dart';
import 'package:dkapp/module/product/product_bloc/product_state.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCategoryScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ProductCategoryScreen({super.key, required this.argus});

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Categories',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
        child: BlocBuilder<ProductBloc, ProductState>(
          bloc: ProductBloc()
            ..add(
              ProductCategoryListFetchEvent(
                  customerId: (widget.argus['customerData']
                          as SelectedCustomerResponseData)
                      .id!,
                  userId: sph.getString("userid")!,
                  businessId: (widget.argus['selectedBusiness']
                          as BusinessListResponseData)
                      .id!),
            ),
          builder: (context, state) {
            if (state is ProductCategoryListLoadedState) {
              return ListView.builder(
                itemCount: state.successData!.length,
                itemBuilder: (context, index) {
                  ProductCategoryListResponseData productCategoryData =
                      state.successData![index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.008,
                        horizontal: screenSize.width * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 203, 202, 202),
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      onTap: () {
                        Navigator.pop(context, productCategoryData);
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: const Icon(
                          Icons.person_2_sharp,
                          color: Colors.grey,
                        ),
                      ),
                      title: Text(
                        productCategoryData.categoryName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 31, 1, 102),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (state is ProductCategoryListLoadingState) {
              return Center(
                child: AnimatedImageLoader(),
              );
            }
            if (state is ProductCategoryListFailedState) {
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(255, 210, 208, 208),
                          width: 1.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 203, 202, 202),
                            blurRadius: 1.0,
                            offset: Offset(0.0, 0.1))
                      ],
                      borderRadius: BorderRadius.circular(10.0)),
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.03,
                      vertical: screenSize.height * 0.01),
                  child: Image.asset(
                    "resources/images/add_image-removebg-preview.png",
                    height: screenSize.height * 0.1,
                  ),
                ),
              );
            }
            return Center(
              child: AnimatedImageLoader(),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          backgroundColor: const Color.fromARGB(255, 31, 1, 102),
          onPressed: () {
            Navigator.pushNamed(context, '/add-product-category', arguments: {
              'customerData': (widget.argus['customerData']
                  as SelectedCustomerResponseData),
              'selectedBusiness': (widget.argus['selectedBusiness']
                  as BusinessListResponseData),
              "updatePlan": true,
              'fromCustomerScreen':
                  (widget.argus.containsKey('fromCustomerScreen'))
                      ? true
                      : false
            });
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          )),
    );
  }
}
