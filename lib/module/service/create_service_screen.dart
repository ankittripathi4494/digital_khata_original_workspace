// ignore_for_file: must_be_immutable

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/discount/model/discount_list_response_model.dart';
import 'package:dkapp/module/product/model/product_category_list_response_model.dart';
import 'package:dkapp/module/product/model/product_modifier_list_response_model.dart';
import 'package:dkapp/module/product/product_bloc/product_bloc.dart';
import 'package:dkapp/module/product/product_bloc/product_event.dart';
import 'package:dkapp/module/product/product_bloc/product_state.dart';
import 'package:dkapp/module/product/product_modifier_added_form.dart';
import 'package:dkapp/module/tax/model/tax_list_response_model.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateServiceScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  CreateServiceScreen({super.key, required this.argus});

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  List<String> text = ['Text', 'Dropdown'];
  bool? isChecked = true;
  String currenttext = '';
  ProductCategoryListResponseData? productCategoryListResponseData;

  late SharedPreferencesHelper sph;
  ProductModifierListResponseData? selectedProductModifierListResponseData;
  List<Map<String, dynamic>> varientOptionList = [];
  late ProductBloc productBloc;
  List<DiscountListResponseData> discountListResponseData = [];
  List<TaxListResponseData> taxListResponseData = [];
  String? selectedPriceType;
  final List<String> priceTypeList = ['Fixed', 'Variable'];
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productSkuController = TextEditingController();
  TextEditingController productStockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sph = SharedPreferencesHelper();

    productBloc = ProductBloc()
      ..add(
        ProductModifiersListFetchEvent(
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/emi');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Create Service',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.01,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
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
                    ),
                    InkWell(
                      onTap: () {},
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
                            horizontal: screenSize.width * 0.01,
                            vertical: screenSize.height * 0.01),
                        child: Image.asset(
                          "resources/images/add_image-removebg-preview.png",
                          height: screenSize.height * 0.1,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
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
                            horizontal: screenSize.width * 0.01,
                            vertical: screenSize.height * 0.01),
                        child: Image.asset(
                          "resources/images/add_image-removebg-preview.png",
                          height: screenSize.height * 0.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          // hintText: 'Enter Product Name',
                          // hintStyle: TextStyle(color: Colors.black),
                          label: Text('Enter Service Name'),
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide.none)),
                    ),
                    const Divider(),
                     ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/product-category',
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
                                  ? productCategoryListResponseData!
                                      .categoryName!
                                  : 'Select Catagory',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
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
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
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
                        width: screenSize.width * 0.19,
                        child: TextFormField(
                          controller: productPriceController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                              // hintText: 'Enter Product Name',
                              // hintStyle: TextStyle(color: Colors.black),
                              hintText: '\u20B9 0',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.03,
                    vertical: screenSize.height * 0.01),
                padding: EdgeInsets.symmetric(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Variations/ Options',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 1, 102),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                    const SizedBox(
                      height: 10.0,
                    ),
                    (varientOptionList.isNotEmpty)
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: varientOptionList.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> varientOption =
                                  varientOptionList[index];
                              return ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/new-option-service-screen',
                                      arguments: {
                                        'customerData': (widget
                                                .argus['customerData']
                                            as SelectedCustomerResponseData),
                                        'selectedBusiness':
                                            (widget.argus['selectedBusiness']
                                                as BusinessListResponseData),
                                        "updatePlan": true,
                                        'fromCustomerScreen': (widget.argus
                                                .containsKey(
                                                    'fromCustomerScreen'))
                                            ? true
                                            : false,
                                        "varientOption": varientOption
                                      }).then((c) {
                                    Map<String, dynamic> de =
                                        (c as Map<String, dynamic>);

                                    setState(() {
                                      varientOptionList.removeAt(
                                          varientOptionList.indexWhere((c) =>
                                              c['productName']
                                                  .toString()
                                                  .toLowerCase()
                                                  .trim() ==
                                              de['productName']
                                                  .toString()
                                                  .toLowerCase()
                                                  .trim()));
                                      varientOptionList.add(de);
                                    });

                                    LoggerUtil().verboseData(
                                        "Updated Data :- ${de.toString()}");
                                  });
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${varientOption['productName']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 31, 1, 102),
                                      ),
                                    ),
                                    Text(
                                      "\u{20B9} ${varientOption['productPrice']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 31, 1, 102),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Container(),
                    TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: Size(screenSize.width * 0.9,
                                screenSize.height * 0.06),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.grey))),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/new-option-service-screen',
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
                                    : false
                              }).then((c) {
                            Map<String, dynamic> de = {
                              "productName": "Regular",
                              "productPrice":
                                  (productPriceController.text.isEmpty)
                                      ? '0'
                                      : productPriceController.text,
                              "productCategory":
                                  productCategoryListResponseData,
                              "productPriceType": selectedPriceType
                            };
                            Map<String, dynamic> d3 =
                                (c as Map<String, dynamic>);

                            if (varientOptionList.isEmpty) {
                              setState(() {
                                varientOptionList.add(de);
                                varientOptionList.add(d3);
                              });
                            } else {
                              setState(() {
                                varientOptionList.add(d3);
                              });
                            }
                          });
                        },
                        child: const Text(
                          'New Option',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        )),
                    SizedBox(height: screenSize.height * 0.02),
                    const Text(
                      'You can add multiple variations of price based on the type of item.',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              // SizedBox(height: screenSize.height * 0.02),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.03,
                    vertical: screenSize.height * 0.01),
                padding: EdgeInsets.symmetric(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Modifiers',
                          style: TextStyle(
                              color: Color.fromARGB(255, 31, 1, 102),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    BlocProvider(
                      create: (_) => productBloc,
                      child: BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductModifiersListLoadingState) {
                            return Center(child: AnimatedImageLoader());
                          } else if (state is ProductModifiersListLoadedState) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.successData!.length,
                              itemBuilder: (context, index) {
                                ProductModifierListResponseData
                                    productModifierListResponseData =
                                    state.successData![index];
                                return InkWell(
                                  onTap: () {
                                    // Navigator.pushNamed(context, '/service-details', arguments: {
                                    //   "percent": 'true',
                                    //   "ruppees": '',
                                    //   "tax": '',
                                    // });
                                  },
                                  child: RadioListTile(
                                    toggleable: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 0),
                                    onChanged: (c) {
                                      setState(() {
                                        selectedProductModifierListResponseData =
                                            c;
                                      });
                                    },
                                    title: Text(
                                      "${productModifierListResponseData.title!} (${productModifierListResponseData.itemCount!})",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 31, 1, 102),
                                      ),
                                    ),
                                    value: productModifierListResponseData,
                                    groupValue:
                                        selectedProductModifierListResponseData,
                                  ),
                                );
                              },
                            );
                          } else if (state is ProductModifiersListFailedState) {
                            return Container();
                          } else {
                            return Center(child: AnimatedImageLoader());
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: Size(screenSize.width * 0.9,
                                screenSize.height * 0.06),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.grey))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (_) => productBloc,
                                  child: ModelSheetAddedForm(
                                    argus: widget.argus,
                                    context: context,
                                  ),
                                ),
                              ));
                        },
                        child: const Text(
                          'Add Modifier',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        )),
                    SizedBox(height: screenSize.height * 0.02),
                    const Text(
                      'You can add multiple modifiers for an item.',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              // SizedBox(height: screenSize.height * 0.02),

              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.03,
                    vertical: screenSize.height * 0.01),
                padding: EdgeInsets.symmetric(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (taxListResponseData.isNotEmpty)
                        ? Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tax',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: taxListResponseData.length,
                                itemBuilder: (context, index) {
                                  final taxData = taxListResponseData[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/tax',
                                          arguments: {
                                            'customerData': (widget
                                                    .argus['customerData']
                                                as SelectedCustomerResponseData),
                                            'selectedBusiness': (widget
                                                    .argus['selectedBusiness']
                                                as BusinessListResponseData),
                                            "updatePlan": true,
                                            'fromCustomerScreen': (widget.argus
                                                    .containsKey(
                                                        'fromCustomerScreen'))
                                                ? true
                                                : false,
                                            "taxData": taxData
                                          }).then((c) {
                                        TaxListResponseData ed =
                                            c as TaxListResponseData;
                                        bool valu = taxListResponseData.any(
                                            (cd) => ((cd.title == (ed).title) &&
                                                (cd.amount == (ed).amount) &&
                                                (cd.disType == (ed).disType)));
                                        if (valu == false) {
                                          setState(() {
                                            taxListResponseData.add(ed);
                                          });
                                        }
                                        if (valu == false) {
                                          setState(() {
                                            taxListResponseData = [];
                                            taxListResponseData.add(ed);
                                          });
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: screenSize.width * 0.03),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 203, 202, 202),
                                                blurRadius: 6.0,
                                                offset: Offset(0.0, 0.1))
                                          ],
                                          color: Colors.white),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.width * 0.02),
                                        child: ListTile(
                                          visualDensity: VisualDensity.compact,
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                taxData.title!,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                '${taxData.amount!} %',
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : Container(),
                    (discountListResponseData.isNotEmpty)
                        ? Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Discount',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: discountListResponseData.length,
                                itemBuilder: (context, index) {
                                  final discountData =
                                      discountListResponseData[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/discount',
                                          arguments: {
                                            'customerData': (widget
                                                    .argus['customerData']
                                                as SelectedCustomerResponseData),
                                            'selectedBusiness': (widget
                                                    .argus['selectedBusiness']
                                                as BusinessListResponseData),
                                            "updatePlan": true,
                                            'fromCustomerScreen': (widget.argus
                                                    .containsKey(
                                                        'fromCustomerScreen'))
                                                ? true
                                                : false,
                                            'discountData': discountData
                                          }).then((c) {
                                        DiscountListResponseData ed =
                                            c as DiscountListResponseData;
                                        bool valu = discountListResponseData
                                            .any((cd) => ((cd.title ==
                                                    (ed).title) &&
                                                (cd.amount == (ed).amount) &&
                                                (cd.disType == (ed).disType)));
                                        if (valu == false) {
                                          setState(() {
                                            discountListResponseData = [];
                                            discountListResponseData.add(ed);
                                          });
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: screenSize.width * 0.03),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 203, 202, 202),
                                                blurRadius: 6.0,
                                                offset: Offset(0.0, 0.1))
                                          ],
                                          color: Colors.white),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.width * 0.02),
                                        child: ListTile(
                                          visualDensity: VisualDensity.compact,
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  discountData.title!,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                (discountData.disType == 'A')
                                                    ? '\u{20B9} ${discountData.amount!}'
                                                    : '${discountData.amount!} %',
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: Size(screenSize.width * 0.9,
                                screenSize.height * 0.06),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.grey))),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.white,
                            scrollControlDisabledMaxHeightRatio: 0.25,
                            showDragHandle: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                width: screenSize.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        'Additional Amount',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.03,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, '/discount',
                                            arguments: {
                                              'customerData': (widget
                                                      .argus['customerData']
                                                  as SelectedCustomerResponseData),
                                              'selectedBusiness': (widget
                                                      .argus['selectedBusiness']
                                                  as BusinessListResponseData),
                                              "updatePlan": true,
                                              'fromCustomerScreen':
                                                  (widget.argus.containsKey(
                                                          'fromCustomerScreen'))
                                                      ? true
                                                      : false
                                            }).then((c) {
                                          DiscountListResponseData ed =
                                              c as DiscountListResponseData;
                                          bool valu = discountListResponseData
                                              .any((cd) => ((cd.title ==
                                                      (ed).title) &&
                                                  (cd.amount == (ed).amount) &&
                                                  (cd.disType ==
                                                      (ed).disType)));
                                          if (valu == false) {
                                            setState(() {
                                              discountListResponseData.add(ed);
                                            });
                                          }
                                        });
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Text(
                                          'Discount',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, '/tax',
                                            arguments: {
                                              'customerData': (widget
                                                      .argus['customerData']
                                                  as SelectedCustomerResponseData),
                                              'selectedBusiness': (widget
                                                      .argus['selectedBusiness']
                                                  as BusinessListResponseData),
                                              "updatePlan": true,
                                              'fromCustomerScreen':
                                                  (widget.argus.containsKey(
                                                          'fromCustomerScreen'))
                                                      ? true
                                                      : false
                                            }).then((c) {
                                          TaxListResponseData ed =
                                              c as TaxListResponseData;
                                          bool valu = taxListResponseData.any(
                                              (cd) => ((cd.title ==
                                                      (ed).title) &&
                                                  (cd.amount == (ed).amount) &&
                                                  (cd.disType ==
                                                      (ed).disType)));
                                          if (valu == false) {
                                            setState(() {
                                              taxListResponseData.add(ed);
                                            });
                                          }
                                        });
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Text(
                                          'Tax',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Add Discount or Tax',
                          style: TextStyle(
                              color: Color.fromARGB(255, 31, 1, 102),
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        )),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.03,
                    vertical: screenSize.height * 0.01),
                padding: EdgeInsets.symmetric(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      autofocus: false,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          // hintText: 'Enter Product Name',
                          // hintStyle: TextStyle(color: Colors.black),
                          label: Text('Enter description'),
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.zero,
                              borderSide: BorderSide.none)),
                    ),
                    // SizedBox(height: screenSize.height * 0.02),
                    const Divider(),
                    TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(
                              screenSize.width * 0.9, screenSize.height * 0.06),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0),
                          //     side: const BorderSide(color: Colors.grey))
                        ),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.white,
                            scrollControlDisabledMaxHeightRatio: 0.93,
                            showDragHandle: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                width: screenSize.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        'Add New Field',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.05,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.1,
                                          vertical: screenSize.height * 0.02),
                                      child: const Text(
                                        'Field Name',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.05),
                                      child: TextFormField(
                                        cursorColor: const Color.fromARGB(
                                            255, 31, 1, 102),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.width * 0.03,
                                              vertical:
                                                  screenSize.height * 0.01),
                                          fillColor: const Color.fromARGB(
                                              255, 220, 219, 219),
                                          filled: true,
                                          hintText: 'Loan Number',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey, fontSize: 18),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.1,
                                          vertical: screenSize.height * 0.02),
                                      child: const Text(
                                        'Field For',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.05),
                                      child: TextFormField(
                                        enabled: false,
                                        enableInteractiveSelection: false,
                                        cursorColor: const Color.fromARGB(
                                            255, 31, 1, 102),
                                        decoration: InputDecoration(
                                          suffixIcon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.grey,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.width * 0.03,
                                              vertical:
                                                  screenSize.height * 0.01),
                                          fillColor: const Color.fromARGB(
                                              255, 220, 219, 219),
                                          filled: true,
                                          hintText: 'Invoice',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey, fontSize: 18),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.1,
                                          vertical: screenSize.height * 0.02),
                                      child: const Text(
                                        'Field Type',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.05),
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            backgroundColor: Colors.white,
                                            scrollControlDisabledMaxHeightRatio:
                                                0.3,
                                            showDragHandle: true,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                width: screenSize.width,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Center(
                                                      child: Text(
                                                        'Field Type',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          screenSize.height *
                                                              0.03,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20.0,
                                                          vertical: 10.0),
                                                      child: Column(
                                                        children: text
                                                            .map((t) =>
                                                                CheckboxListTile(
                                                                  value:
                                                                      isChecked,
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      isChecked =
                                                                          value;
                                                                      if (value ==
                                                                          true) {
                                                                        currenttext =
                                                                            t;
                                                                      }
                                                                    });
                                                                  },
                                                                  title:
                                                                      Text(t),
                                                                ))
                                                            .toList(),
                                                        // const Text(
                                                        //   'Text',
                                                        //   style: TextStyle(
                                                        //       color: Colors
                                                        //           .black,
                                                        //       fontSize: 20),
                                                        // ),
                                                        // Checkbox(
                                                        //   checkColor:
                                                        //       Colors.green,
                                                        //   onChanged:
                                                        //       (bool? value) {
                                                        //     isChecked = value;
                                                        //     setState(() {
                                                        //       isChecked =
                                                        //           true;
                                                        //     });
                                                        //   },
                                                        //   value: isChecked,
                                                        // )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: TextFormField(
                                          enabled: false,
                                          enableInteractiveSelection: false,
                                          cursorColor: const Color.fromARGB(
                                              255, 31, 1, 102),
                                          decoration: InputDecoration(
                                            suffixIcon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        screenSize.width * 0.03,
                                                    vertical:
                                                        screenSize.height *
                                                            0.01),
                                            fillColor: const Color.fromARGB(
                                                255, 220, 219, 219),
                                            filled: true,
                                            hintText: 'Text',
                                            hintStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.1,
                                    ),
                                    Container(
                                        width: screenSize.width,
                                        height: screenSize.height * 0.06,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: screenSize.width * 0.05,
                                            vertical: screenSize.height * 0.03),
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                screenSize.height * 0.018),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 31, 1, 102),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 187, 186, 186),
                                              offset: Offset(0.0, 1.0),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'SAVE',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Add more field...',
                          style: TextStyle(
                              color: Color.fromARGB(255, 31, 1, 102),
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        )),
                    SizedBox(height: screenSize.height * 0.07),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: InkWell(
        onTap: () {
          if (productNameController.text.isNotEmpty) {
          } else {
            EssentialWidgetsCollection.showErrorSnackbar(context,
                description: "Please enter service name to save");
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
