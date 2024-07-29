// ignore_for_file: must_be_immutable

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/product/model/product_master_unit_list_response_model.dart';
import 'package:dkapp/module/product/product_bloc/product_bloc.dart';
import 'package:dkapp/module/product/product_bloc/product_event.dart';
import 'package:dkapp/module/product/product_bloc/product_state.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductMasterUnitPrecisionScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ProductMasterUnitPrecisionScreen({super.key, required this.argus});

  @override
  State<ProductMasterUnitPrecisionScreen> createState() =>
      _ProductMasterUnitPrecisionScreenState();
}

class _ProductMasterUnitPrecisionScreenState
    extends State<ProductMasterUnitPrecisionScreen> {
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  List<Map<String, dynamic>> precisionList = [
    {"value": "1", "precision": 0},
    {"value": ".0", "precision": 1},
    {"value": ".00", "precision": 2},
    {"value": ".000", "precision": 3},
    {"value": ".0000", "precision": 4},
    {"value": ".00000", "precision": 5},
  ];
  Map<String, dynamic>? selectedPrecision;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Precision',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 14, letterSpacing: 1.2)),
              onPressed: () {
                BlocProvider.of<ProductBloc>(context).add(AddProductUnitEvent(
                    customerId: (widget.argus['customerData']
                            as SelectedCustomerResponseData)
                        .id!,
                    userId: sph.getString("userid")!,
                    businessId: (widget.argus['selectedBusiness']
                            as BusinessListResponseData)
                        .id!,
                    productUnitName: (widget.argus["selectUnit"]
                            as ProductMasterUnitListResponseData)
                        .title!,
                    productUnitPrecision:
                        selectedPrecision!["precision"].toString()));
              },
              child: Text("Save".toUpperCase()))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
        child: Column(
          children: [
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is AddNewProductUnitSuccessState) {
                  return EssentialWidgetsCollection.autoScheduleTask(
                    context,
                    taskWaitDuration: Durations.medium4,
                    task: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, '/product-unit-list',
                          arguments: {
                            'customerData': (widget.argus['customerData']
                                as SelectedCustomerResponseData),
                            'selectedBusiness':
                                (widget.argus['selectedBusiness']
                                    as BusinessListResponseData),
                            "updatePlan": true,
                            'fromCustomerScreen':
                                (widget.argus.containsKey('fromCustomerScreen'))
                                    ? true
                                    : false
                          });
                      EssentialWidgetsCollection.showSuccessSnackbar(context,
                          description: "Unit Added Successfully");
                    },
                  );
                }
                if (state is AddNewProductUnitFailedState) {
                  return EssentialWidgetsCollection.autoScheduleTask(
                    context,
                    taskWaitDuration: Durations.medium4,
                    task: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      EssentialWidgetsCollection.showErrorSnackbar(context,
                          description: "Unit creation failed");
                    },
                  );
                }
                if (state is AddNewProductUnitLoadingState) {
                  return Center(
                    child: AnimatedImageLoader(),
                  );
                }
                return Container();
              },
            ),
            Flexible(
              child: ListView.builder(
                itemCount: precisionList.length,
                itemBuilder: (context, index) {
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
                    child: RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      onChanged: (c) {
                        setState(() {
                          selectedPrecision = c;
                        });
                      },
                      title: Text(
                        precisionList[index]["value"],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 31, 1, 102),
                        ),
                      ),
                      value: precisionList[index],
                      groupValue: selectedPrecision,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
