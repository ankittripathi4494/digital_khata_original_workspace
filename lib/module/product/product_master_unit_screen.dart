// ignore_for_file: must_be_immutable

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/product/model/product_master_unit_list_response_model.dart';
import 'package:dkapp/module/product/product_bloc/product_bloc.dart';
import 'package:dkapp/module/product/product_bloc/product_event.dart';
import 'package:dkapp/module/product/product_bloc/product_state.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductMasterUnitScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ProductMasterUnitScreen({super.key, required this.argus});

  @override
  State<ProductMasterUnitScreen> createState() =>
      _ProductMasterUnitScreenState();
}

class _ProductMasterUnitScreenState extends State<ProductMasterUnitScreen> {
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
          'Select Unit',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
        child: BlocBuilder<ProductBloc, ProductState>(
          bloc: ProductBloc()
            ..add(
              ProductMasterUnitListFetchEvent(),
            ),
          builder: (context, state) {
            if (state is ProductMasterUnitListLoadedState) {
              return ListView.builder(
                itemCount: state.successData!.length,
                itemBuilder: (context, index) {
                  ProductMasterUnitListResponseData productMasterUnitData =
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
                          horizontal: 20, vertical: 0),
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/product-master-precision-screen',
                            arguments: {
                              'customerData': (widget.argus['customerData']
                                  as SelectedCustomerResponseData),
                              'selectedBusiness':
                                  (widget.argus['selectedBusiness']
                                      as BusinessListResponseData),
                              "updatePlan": true,
                              'fromCustomerScreen': (widget.argus
                                      .containsKey('fromCustomerScreen'))
                                  ? true
                                  : false,
                              "selectUnit":productMasterUnitData
                            });
                      },
                      title: Text(
                        productMasterUnitData.title ?? '',
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
            if (state is ProductMasterUnitListLoadingState) {
              return Center(
                child: AnimatedImageLoader(),
              );
            }
            if (state is ProductMasterUnitListFailedState) {
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
                    "resources/images/empty-folder.png",
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
    );
  }
}
