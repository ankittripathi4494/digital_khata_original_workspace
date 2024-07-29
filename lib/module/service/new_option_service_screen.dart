// ignore_for_file: must_be_immutable

import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/product/model/product_category_list_response_model.dart';
import 'package:dkapp/module/product/model/product_unit_list_response_model.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewOptionServiceScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  NewOptionServiceScreen({super.key, required this.argus});

  @override
  State<NewOptionServiceScreen> createState() => _NewOptionScreenState();
}

class _NewOptionScreenState extends State<NewOptionServiceScreen> {
  List<String> text = ['Text', 'Dropdown'];
  bool? isChecked = true;
  String currenttext = '';
  ProductCategoryListResponseData? productCategoryListResponseData;
  ProductUnitListResponseData? productUnitListResponseData;

  String? selectedPriceType;
  final List<String> priceTypeList = ['Fixed', 'Variable'];
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productSkuController = TextEditingController();
  TextEditingController productStockController = TextEditingController();
  Map<String, dynamic>? optionData;

  @override
  void initState() {
    fetchOptionDetails();
    super.initState();
  }

  fetchOptionDetails() {
    if (widget.argus.containsKey("varientOption")) {
      setState(() {
        productNameController.text = (widget.argus["varientOption"]
            as Map<String, dynamic>)['productName'];
        productPriceController.text = ((widget.argus["varientOption"]
                    as Map<String, dynamic>)['productPrice']
                .toString()
                .isEmpty)
            ? '0'
            : (widget.argus["varientOption"]
                as Map<String, dynamic>)['productPrice'];
        productSkuController.text = (widget.argus["varientOption"]
            as Map<String, dynamic>)['productSku'];
        productStockController.text = (widget.argus["varientOption"]
            as Map<String, dynamic>)['productStock'];
        productCategoryListResponseData = (((widget.argus["varientOption"]
                    as Map<String, dynamic>)['productCategory'] ==
                null)
            ? null
            : ((widget.argus["varientOption"]
                    as Map<String, dynamic>)['productCategory']
                as ProductCategoryListResponseData));

        selectedPriceType = ((widget.argus["varientOption"]
                    as Map<String, dynamic>)['productPriceType'] ==
                null)
            ? null
            : ((widget.argus["varientOption"]
                as Map<String, dynamic>)['productPriceType'] as String);
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
          'New Option',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.01,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.03,
              vertical: screenSize.height * 0.01),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 203, 202, 202),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 0.1))
              ],
              borderRadius: BorderRadius.circular(5.0)),
          child: Column(
            children: [
              TextFormField(
                controller: productNameController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    // hintText: 'Enter Product Name',
                    // hintStyle: TextStyle(color: Colors.black),
                    label: Text('Enter Option Name'),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide.none)),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/product-category', arguments: {
                    'customerData': (widget.argus['customerData']
                        as SelectedCustomerResponseData),
                    'selectedBusiness': (widget.argus['selectedBusiness']
                        as BusinessListResponseData),
                    "updatePlan": true,
                    'fromCustomerScreen':
                        (widget.argus.containsKey('fromCustomerScreen'))
                            ? true
                            : false
                  }).then((c) {
                    setState(() {
                      productCategoryListResponseData =
                          (c as ProductCategoryListResponseData);
                    });
                  });
                },
                leading: const Text(
                  'Catagory',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                trailing: SizedBox(
                  width: screenSize.width * 0.32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        (productCategoryListResponseData != null)
                            ? productCategoryListResponseData!.categoryName!
                            : 'Select Catagory',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                leading: const Text(
                  'Price Type',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                trailing: SizedBox(
                  width: screenSize.width * 0.20,
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.white,
                          underline: Container(),
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          isExpanded: true,
                          value: selectedPriceType,
                          hint: const Text(
                            'Price Type',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          items: priceTypeList
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPriceType = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                leading: const Text(
                  'Price',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                trailing: SizedBox(
                  width: screenSize.width * 0.32,
                  child: TextFormField(
                    controller: productPriceController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    decoration: const InputDecoration(
                        // hintText: 'Enter Product Name',
                        // hintStyle: TextStyle(color: Colors.black),
                        hintText: '\u20B9 0',
                        hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none)),
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                leading: const Text(
                  'SKU',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                trailing: SizedBox(
                  width: screenSize.width * 0.32,
                  child: TextFormField(
                    controller: productSkuController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    ],
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                        hintText: 'Text',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none)),
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                leading: const Text(
                  'Stock',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                trailing: (productStockController.text.isEmpty)
                    ? InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.white,
                            scrollControlDisabledMaxHeightRatio: 0.5,
                            showDragHandle: true,
                            context: context,
                            builder: (BuildContext context) {
                              return PopScope(
                                canPop: false,
                                child: SizedBox(
                                  width: screenSize.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.person_add,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Add Customer',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.width * 0.05),
                                        child: const Divider(),
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.03,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Text(
                                          'Add Stock',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.width * 0.05),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          controller: productStockController,
                                          cursorColor: const Color.fromARGB(
                                              255, 31, 1, 102),
                                          decoration: InputDecoration(
                                            hintText: 'Add Stock ',
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 31, 1, 102),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.03,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.width * 0.03),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero),
                                                    minimumSize: Size(
                                                        screenSize.width * 0.4,
                                                        screenSize.height *
                                                            0.05)),
                                                onPressed: () {
                                                  productStockController
                                                      .clear();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('CANCEL')),
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 31, 1, 102),
                                                    minimumSize: Size(
                                                        screenSize.width * 0.4,
                                                        screenSize.height *
                                                            0.05)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'SAVE',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Received Stock',
                          style: TextStyle(
                              color: Color.fromARGB(255, 33, 79, 243),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          var temp = productStockController.text;
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.white,
                            scrollControlDisabledMaxHeightRatio: 0.5,
                            showDragHandle: true,
                            context: context,
                            builder: (BuildContext context) {
                              return PopScope(
                                canPop: false,
                                child: SizedBox(
                                  width: screenSize.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.person_add,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Add Customer',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.width * 0.05),
                                        child: const Divider(),
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.03,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Text(
                                          'Add Stock',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.width * 0.05),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          controller: productStockController,
                                          cursorColor: const Color.fromARGB(
                                              255, 31, 1, 102),
                                          decoration: InputDecoration(
                                            hintText: 'Add Stock ',
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 31, 1, 102),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.03,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.width * 0.03),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero),
                                                    minimumSize: Size(
                                                        screenSize.width * 0.4,
                                                        screenSize.height *
                                                            0.05)),
                                                onPressed: () {
                                                  productStockController.text =
                                                      temp;
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('CANCEL')),
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 31, 1, 102),
                                                    minimumSize: Size(
                                                        screenSize.width * 0.4,
                                                        screenSize.height *
                                                            0.05)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'SAVE',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          '${int.parse(productStockController.text)} in Stock',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 33, 79, 243),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: InkWell(
        onTap: () {
          if (widget.argus.containsKey("varientOption")) {
            if (productNameController.text.isNotEmpty) {
              setState(() {
                optionData = {
                  "productName": productNameController.text,
                  "productPrice": (productPriceController.text.isEmpty)
                      ? '0'
                      : productPriceController.text,
                  "productSku": productSkuController.text,
                  "productStock": productStockController.text,
                  "productCategory": productCategoryListResponseData,
                  "productPriceType": selectedPriceType
                };
              });
              LoggerUtil().warningData("Warding :- ${optionData.toString()}");
              Navigator.pop(context, optionData);
            } else {
              EssentialWidgetsCollection.showErrorSnackbar(context,
                  description: "Please enter service name to save");
            }
          } else {
            if (productNameController.text.isNotEmpty) {
              setState(() {
                optionData = {
                  "productName": productNameController.text,
                  "productPrice": (productPriceController.text.isEmpty)
                      ? '0'
                      : productPriceController.text,
                  "productSku": productSkuController.text,
                  "productStock": productStockController.text,
                  "productCategory": productCategoryListResponseData,
                  "productPriceType": selectedPriceType
                };
              });

              Navigator.pop(context, optionData);
            } else {
              EssentialWidgetsCollection.showErrorSnackbar(context,
                  description: "Please enter service name to save");
            }
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 31, 1, 102),
          ),
          padding: EdgeInsets.symmetric(
              vertical: screenSize.height * 0.015,
              horizontal: screenSize.width * 0.4),
          child: const Text(
            'SAVE',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
