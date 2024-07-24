import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/product/model/product_unit_list_response_model.dart';
import 'package:dkapp/module/product/product_bloc/product_bloc.dart';
import 'package:dkapp/module/product/product_bloc/product_event.dart';
import 'package:dkapp/module/product/product_bloc/product_state.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductUnitScreen extends StatefulWidget {
  final Map<String, dynamic> argus;
  ProductUnitScreen({super.key, required this.argus});

  @override
  State<ProductUnitScreen> createState() => _ProductUnitScreenState();
}

class _ProductUnitScreenState extends State<ProductUnitScreen> {
  late SharedPreferencesHelper sph;
  ProductUnitListResponseData? selectedProductUnitListResponseDataMap;
  late ProductBloc productBloc;

  @override
  void initState() {
    super.initState();
    sph = SharedPreferencesHelper();
    fetchSelectedProductUnit();
    productBloc = ProductBloc()
      ..add(
        ProductUnitListFetchEvent(
          customerId:
              (widget.argus['customerData'] as SelectedCustomerResponseData)
                  .id!,
          userId: sph.getString("userid")!,
          businessId:
              (widget.argus['selectedBusiness'] as BusinessListResponseData)
                  .id!,
        ),
      );
  }

  void fetchSelectedProductUnit() {
    if (widget.argus.containsKey("unit")) {
      setState(() {
        selectedProductUnitListResponseDataMap =
            widget.argus["unit"] as ProductUnitListResponseData?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Unit List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 23,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
        child: BlocProvider(
          create: (_) => productBloc,
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductUnitListLoadingState) {
                return Center(child: AnimatedImageLoader());
              } else if (state is ProductUnitListLoadedState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.successData!.length,
                  itemBuilder: (context, index) {
                    final productUnitData = state.successData![index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.008,
                        horizontal: screenSize.width * 0.05,
                      ),
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
                      child: CustomRadioListTile(
                        productUnitData: productUnitData,
                        selectedProductUnitListResponseData:
                            selectedProductUnitListResponseDataMap,
                        onChanged: (value) {
                          setState(() {
                            selectedProductUnitListResponseDataMap = value;
                          });
                        },
                        onTap: () {
                          Navigator.pop(context, productUnitData);
                        },
                      ),
                    );
                  },
                );
              } else if (state is ProductUnitListFailedState) {
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
                          offset: Offset(0.0, 0.1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.03,
                      vertical: screenSize.height * 0.01,
                    ),
                    child: Image.asset(
                      "resources/images/empty-folder.png",
                      height: screenSize.height * 0.1,
                    ),
                  ),
                );
              } else {
                return Center(child: AnimatedImageLoader());
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        backgroundColor: const Color.fromARGB(255, 31, 1, 102),
        onPressed: () {
          Navigator.pushNamed(context, '/product-master-unit-list', arguments: {
            'customerData': widget.argus['customerData'],
            'selectedBusiness': widget.argus['selectedBusiness'],
            'updatePlan': true,
            'fromCustomerScreen':
                widget.argus.containsKey('fromCustomerScreen') ? true : false,
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  @override
  void dispose() {
    productBloc.close();
    super.dispose();
  }
}

class CustomRadioListTile extends StatelessWidget {
  final ProductUnitListResponseData productUnitData;
  final ProductUnitListResponseData? selectedProductUnitListResponseData;
  final ValueChanged<ProductUnitListResponseData?> onChanged;
  final Function()? onTap;

  const CustomRadioListTile(
      {super.key,
      required this.productUnitData,
      required this.selectedProductUnitListResponseData,
      required this.onChanged,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    if (productUnitData == selectedProductUnitListResponseData) {
      return RadioListTile<ProductUnitListResponseData>(
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        onChanged: onChanged,
        title: Text(
          productUnitData.unitName ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 31, 1, 102),
          ),
        ),
        value: productUnitData,
        groupValue: selectedProductUnitListResponseData,
      );
    } else {
      return ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        title: Text(
          productUnitData.unitName ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 31, 1, 102),
          ),
        ),
      );
    }
  }
}
