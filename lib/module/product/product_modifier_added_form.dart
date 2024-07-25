// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:convert';

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/product/product_bloc/product_bloc.dart';
import 'package:dkapp/module/product/product_bloc/product_event.dart';
import 'package:dkapp/module/product/product_bloc/product_state.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModelSheetAddedForm extends StatefulWidget {
  late Map<String, dynamic> argus;
  late BuildContext context;
  ModelSheetAddedForm({super.key, required this.argus, required this.context});

  @override
  _ModelSheetAddedFormState createState() => _ModelSheetAddedFormState();
}

class _ModelSheetAddedFormState extends State<ModelSheetAddedForm> {
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  bool? isPercent;
  int initIndex = 1;
  TextEditingController productModifierTitleController =
      TextEditingController();
  TextEditingController taxAmountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<TextEditingController> formFieldControllers1 = [];
  List<TextEditingController> formFieldControllers2 = [];
  List<Widget> formFields = [];
  List<String> resultData = [];

  @override
  void initState() {
    super.initState();
    _addNewField();
  }

  _addNewField() {
    final controller1 = TextEditingController();
    final controller2 = TextEditingController();
    formFieldControllers1.add(controller1);
    formFieldControllers2.add(controller2);
    setState(() {
      formFields.add(Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              formPart(controller1, controller2),
              IconButton(
                  onPressed: () {
                    _removeFields(controller1, controller2);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.xmark,
                    color: Colors.red,
                  ))
            ],
          ),
          const SizedBox(height: 20),
        ],
      ));
    });
  }

  formPart(
      TextEditingController controller1, TextEditingController controller2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SizedBox(
            width: 200,
            child: TextFormField(
              controller: controller1,
              style: const TextStyle(
                color: Color.fromARGB(255, 31, 1, 102),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Type';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Modifier Type',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 31, 1, 102),
                    )),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: controller2,
            style: const TextStyle(
              color: Color.fromARGB(255, 31, 1, 102),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some amount';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Amount',
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 31, 1, 102),
                  )),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey)),
            ),
          ),
        ),
      ],
    );
  }

  void _removeFields(
      TextEditingController controller1, TextEditingController controller2) {
    setState(() {
      int index1 = formFieldControllers1.indexOf(controller1);
      int index2 = formFieldControllers2.indexOf(controller2);
      formFieldControllers1.removeAt(index1);
      formFieldControllers2.removeAt(index2);
      formFields.removeAt(index1);
    });
  }

  @override
  void dispose() {
    for (var controller in formFieldControllers1) {
      controller.dispose();
    }
    for (var controller in formFieldControllers2) {
      controller.dispose();
    }
    super.dispose();
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
          'Create Product Modifier',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
        ),
      ),
      body: SizedBox(
        width: screenSize.width,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is AddProductModifierSuccessState) {
                        return EssentialWidgetsCollection.autoScheduleTask(
                          context,
                          taskWaitDuration: Durations.medium4,
                          task: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, '/create-product',
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
                                });
                            EssentialWidgetsCollection.showSuccessSnackbar(
                                context,
                                description:
                                    "Product Modifier created Successfully");
                          },
                        );
                      }
                      if (state is AddProductModifierFailedState) {
                        return EssentialWidgetsCollection.autoScheduleTask(
                          context,
                          taskWaitDuration: Durations.medium4,
                          task: () {
                            Navigator.pop(context);
                            EssentialWidgetsCollection.showErrorSnackbar(
                                context,
                                description:
                                    "Product Modifier creation failed");
                          },
                        );
                      }
                      if (state is AddProductModifierLoadingState) {
                        return Center(
                          child: AnimatedImageLoader(),
                        );
                      }
                      return Container();
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  const Center(
                    child: Text(
                      'Add New Product Modifier',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.03),
                    child: const Text(
                      'Title',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: screenSize.height * 0.03,
                  // ),
                  TextFormField(
                    controller: productModifierTitleController,
                    // autofocus: true,
                    enabled: true,
                    enableInteractiveSelection: true,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 31, 1, 102),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Product Modifier Title',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 31, 1, 102),
                          )),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.03),
                    child: const Text(
                      'Modifiers',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ...formFields,
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white),
                      onPressed: _addNewField,
                      icon: const Icon(FontAwesomeIcons.circlePlus),
                      label: const Text('Add'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        for (int i = 0; i < formFieldControllers1.length; i++) {
                          print(
                              "Field ${i + 1}a: ${formFieldControllers1[i].text}");
                          print(
                              "Field ${i + 1}b: ${formFieldControllers2[i].text}");
                          resultData.add(jsonEncode({
                            "modifier_name": formFieldControllers1[i].text,
                            "amount": formFieldControllers2[i].text
                          }));
                        }
                        LoggerUtil().debugData(resultData.toString());
                      }
                      BlocProvider.of<ProductBloc>(context)
                          .add(AddProductModifierEvent(
                        customerId: (widget.argus['customerData']
                                as SelectedCustomerResponseData)
                            .id!,
                        userId: sph.getString("userid")!,
                        businessId: (widget.argus['selectedBusiness']
                                as BusinessListResponseData)
                            .id!,
                        productModifierName: productModifierTitleController.text,
                        productModifierArray: resultData,
                      ));
                    },
                    child: Container(
                      width: screenSize.width,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 31, 1, 102),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Center(
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
