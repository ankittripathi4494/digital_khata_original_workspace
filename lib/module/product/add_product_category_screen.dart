// ignore_for_file: must_be_immutable

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/product/product_bloc/product_bloc.dart';
import 'package:dkapp/module/product/product_bloc/product_event.dart';
import 'package:dkapp/module/product/product_bloc/product_state.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductCategoryScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  AddProductCategoryScreen({super.key, required this.argus});

  @override
  State<AddProductCategoryScreen> createState() =>
      _AddProductCategoryScreenState();
}

class _AddProductCategoryScreenState extends State<AddProductCategoryScreen> {
  SharedPreferencesHelper sph = SharedPreferencesHelper();

  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add Category',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is AddNewProductCategorySuccessState) {
                return EssentialWidgetsCollection.autoScheduleTask(
                  context,
                  taskWaitDuration: Durations.medium4,
                  task: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/product-category',
                        arguments: {
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
                    EssentialWidgetsCollection.showSuccessSnackbar(context,
                        description: "Category Added Successfully");
                  },
                );
              }
              if (state is AddNewProductCategoryFailedState) {
                return EssentialWidgetsCollection.autoScheduleTask(
                  context,
                  taskWaitDuration: Durations.medium4,
                  task: () {
                    Navigator.pop(context);
                    EssentialWidgetsCollection.showErrorSnackbar(context,
                        description: "Category creation failed");
                  },
                );
              }
              if (state is AddNewProductCategoryLoadingState) {
                return Center(
                  child: AnimatedImageLoader(),
                );
              }
              return Container();
            },
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: TextFormField(
              controller: categoryController,
              cursorColor: const Color.fromARGB(255, 31, 1, 102),
              decoration: InputDecoration(
                hintText: 'Enter Category ',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 31, 1, 102),
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<ProductBloc>(context).add(AddProductCategoryEvent(
                  customerId: (widget.argus['customerData']
                          as SelectedCustomerResponseData)
                      .id!,
                  userId: sph.getString("userid")!,
                  businessId: (widget.argus['selectedBusiness']
                          as BusinessListResponseData)
                      .id!,
                  productCategoryName: categoryController.text));
            },
            child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                height: 50,
                width: screenSize.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.zero,
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                child: const Center(
                  child: Text(
                    'SAVE',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
