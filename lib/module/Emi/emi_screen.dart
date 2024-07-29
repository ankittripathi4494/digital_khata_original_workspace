// ignore_for_file: unused_field, unused_local_variable, unnecessary_to_list_in_spreads, must_be_immutable

import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class EmiScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  EmiScreen({super.key, required this.argus});

  @override
  State<EmiScreen> createState() => _EmiScreenState();
}

class _EmiScreenState extends State<EmiScreen> {
  bool? isCheckbox = false;
  int count = 1;
  final ImagePicker _picker = ImagePicker();
  XFile? retailerImage;
  String? retailerImageFile;


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'EMI',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  backgroundColor: Colors.white,
                  scrollControlDisabledMaxHeightRatio: 0.4,
                  showDragHandle: true,
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: screenSize.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.04,
                            ),
                            const Text(
                              'EMI Entry',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            const Text(
                              'Future Emi\'s Will Not Be Generated',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.04,
                            ),
                            const Text(
                              'EMI Entry + Generated Cash-out entries',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            const Text(
                              'Future Emi\'s Will Not Be Generated',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'Linked Cash In Transcations To This EMI Will Be Unlinked',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'Generated Cash Out Entry For This EMI Will Be Removed',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
          child: Column(
            children: [
              ListTile(
                  title: const Text(
                    'EMI Code',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text(
                    'EMI Number will auto generated if no code provided',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  trailing: TextButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          backgroundColor: Colors.white,
                          scrollControlDisabledMaxHeightRatio: 0.55,
                          showDragHandle: true,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: screenSize.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.05),
                                    child: const Text(
                                      'Enter EMI Code',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.03,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.05,
                                    ),
                                    child: TextFormField(
                                      autofocus: true,
                                      enabled: true,
                                      enableInteractiveSelection: true,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: '0',
                                        hintStyle: const TextStyle(
                                            color: Colors.black),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                color: Colors.grey)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 31, 1, 102),
                                            )),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                color: Colors.grey)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.05,
                                  ),
                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.35,
                                          vertical: screenSize.height * 0.016),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 31, 1, 102),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: const Text(
                                        'Update',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
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
                        'EDIT',
                        style: TextStyle(color: Colors.green),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04,
                    vertical: screenSize.width * 0.01),
                child: const Divider(),
              ),

              (!widget.argus.containsKey('fromCustomerScreen'))
                  ? Column(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/select-customer');
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.015),
                            child: TextFormField(
                              enabled: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Select Customer',
                                hintStyle: const TextStyle(color: Colors.black),
                                prefixIcon: const Icon(
                                  Icons.person_2_outlined,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                suffixIcon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                    )),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),

              SizedBox(
                height: screenSize.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/emi-plan', arguments: {
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.015),
                  child: TextFormField(
                    enabled: false,
                    enableInteractiveSelection: false,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 31, 1, 102),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Plan',
                      hintStyle: const TextStyle(color: Colors.black),
                      suffixIcon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,
                        size: 18,
                      ),
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
                height: screenSize.height * 0.02,
              ),
              const ListTile(
                title: Text(
                  'Items',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '[ Optional,select products or services if you like to provide EMI on items.]',
                  style: TextStyle(
                    color: Colors.black,
                    // fontSize: 17,
                  ),
                ),
              ),
              (widget.argus["addContent"] == true)
                  ? ListTile(
                      minLeadingWidth: screenSize.width * 0.01,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.01),
                      leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(10.0)),
                        child: const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text(
                            '\u{20B9}',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      title: const Text(
                        'VsvsVv',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: const Text(
                        'Regular',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      trailing: const Column(
                        children: [
                          Text(
                            ' \u{20B9}${254}',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 1, 102),
                                fontSize: 18),
                          ),
                          Text(
                            ' \u{20B9}${254}*1',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : (widget.argus["customAmount"] == true)
                      ? ListTile(
                          minLeadingWidth: screenSize.width * 0.01,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.01),
                          leading: Container(
                            decoration: BoxDecoration(
                                color: Colors.red[100],
                                borderRadius: BorderRadius.circular(10.0)),
                            child: const Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Text(
                                'N',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                          ),
                          title: const Text(
                            'CustomName',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          subtitle: const Text(
                            'Custom Amount',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          trailing: const Column(
                            children: [
                              Text(
                                ' \u{20B9}${254}',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                    fontSize: 18),
                              ),
                              Text(
                                ' \u{20B9}${254}*1',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
              const Divider(),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    backgroundColor: Colors.white,
                    scrollControlDisabledMaxHeightRatio: 0.3,
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
                                'Add',
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
                                Navigator
                                    .pushNamed(context, '/product', arguments: {
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
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  'Product',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator
                                    .pushNamed(context, '/service', arguments: {
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
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  'Service',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/custom-amount',
                                    arguments: {
                                      'customerData':
                                          (widget.argus['customerData']
                                              as SelectedCustomerResponseData),
                                      'selectedBusiness':
                                          (widget.argus['selectedBusiness']
                                              as BusinessListResponseData),
                                      "updatePlan": true,
                                      'fromCustomerScreen': (widget.argus
                                              .containsKey(
                                                  'fromCustomerScreen'))
                                          ? true
                                          : false
                                    });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  'Custom Amount',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.add_circle,
                    color: Color.fromARGB(255, 31, 1, 102),
                  ),
                  minLeadingWidth: 0.0,
                  title: Text(
                    'Add new product or service',
                    style: TextStyle(
                        color: Color.fromARGB(255, 31, 1, 102), fontSize: 16),
                  ),
                ),
              ),
              (widget.argus['addContent'] == true)
                  ? Container(
                      width: screenSize.width,
                      padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01,
                      ),

                      // margin: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 203, 202, 202),
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.04,
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment Details',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Text(
                                  '(For 1 invoice)',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.045,
                                vertical: screenSize.height * 0.01),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Sub Total',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 32, 32, 32),
                                      fontSize: 16),
                                ),
                                Text(
                                  '\u{20B9} ${254}',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 32, 32, 32),
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.045,
                                vertical: screenSize.height * 0.01),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Svvs',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 32, 32, 32),
                                      fontSize: 16),
                                ),
                                Text(
                                  '- \u{20B9} ${25}',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 32, 32, 32),
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.06),
                            child: const Divider(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.045,
                                vertical: screenSize.height * 0.01),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'To Pay',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '\u{20B9} ${229}',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 32, 32, 32),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.06),
                            child: const Divider(),
                          ),
                          Center(
                            child: TextButton.icon(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Center(
                                              child: Text(
                                                'Additional Amount',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenSize.height * 0.03,
                                            ),
                                            const InkWell(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.0,
                                                    vertical: 10.0),
                                                child: Text(
                                                  'Discount',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                  vertical: 10.0),
                                              child: Text(
                                                'Tax',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                  size: 30,
                                ),
                                label: const Text(
                                  'Add Discount or tax',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                )),
                          )
                        ],
                      ),
                    )
                  : (widget.argus['customAmount'] == true)
                      ? Container(
                          width: screenSize.width,
                          padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.01,
                          ),

                          // margin: EdgeInsets.symmetric(vertical: 10.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 203, 202, 202),
                                offset: Offset(0.0, 1.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.04,
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Payment Details',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      '(For 1 invoice)',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.01,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.045,
                                    vertical: screenSize.height * 0.01),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sub Total',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 32, 32, 32),
                                          fontSize: 16),
                                    ),
                                    Text(
                                      '\u{20B9} ${252}',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 32, 32, 32),
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.06),
                                child: const Divider(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.045,
                                    vertical: screenSize.height * 0.01),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'To Pay',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '\u{20B9} ${252}',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 32, 32, 32),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.06),
                                child: const Divider(),
                              ),
                              Center(
                                child: TextButton.icon(
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        backgroundColor: Colors.white,
                                        scrollControlDisabledMaxHeightRatio:
                                            0.25,
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
                                                    'Additional Amount',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.03,
                                                ),
                                                const InkWell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.0,
                                                            vertical: 10.0),
                                                    child: Text(
                                                      'Discount',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10.0),
                                                  child: Text(
                                                    'Tax',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Color.fromARGB(255, 31, 1, 102),
                                      size: 30,
                                    ),
                                    label: const Text(
                                      'Add Discount or tax',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 31, 1, 102),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        )
                      : Container(),

              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.65),
                child: const Text(
                  'Amount',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.015),
                child: TextFormField(
                  enabled: true,
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                  ),
                  decoration: InputDecoration(
                    hintText: (widget.argus['addContent'] == 'tue')
                        ? '\u{20B9} ${229}'
                        : (widget.argus['customAmount'] == 'tue')
                            ? '\u{20B9} ${252}'
                            : '\u{20B9} ${0}',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.03,
                        vertical: screenSize.height * 0.015),
                    hintStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800),
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
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.55),
                child: const Text(
                  'Down Payment',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.015),
                child: TextFormField(
                  enabled: true,
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                  ),
                  decoration: InputDecoration(
                    hintText: '\u{20B9} ${0}',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.03,
                        vertical: screenSize.height * 0.015),
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800),
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
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.5),
                child: const Text(
                  'Principle Amount',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.015),
                child: TextFormField(
                  enabled: true,
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                  ),
                  decoration: InputDecoration(
                    hintText: (widget.argus['addContent'] == true)
                        ? '\u{20B9} ${229}'
                        : (widget.argus['customAmount'] == true)
                            ? '\u{20B9} ${252}'
                            : '\u{20B9} ${0}',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.03,
                        vertical: screenSize.height * 0.015),
                    hintStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800),
                    fillColor: Colors.grey[200],
                    filled: true,
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
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: screenSize.width * 0.1),
                        child: const Text(
                          'Repeat Every',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            showDragHandle: true,
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              List<Map<String, dynamic>> options = [
                                {'text': 'Daily', 'isChecked': false},
                                {'text': 'Weekly', 'isChecked': false},
                                {'text': 'Monthly', 'isChecked': false},
                                {'text': 'Quarterly', 'isChecked': false},
                                {'text': 'HalfYearly', 'isChecked': false},
                                {'text': 'Yearly', 'isChecked': false},
                              ];

                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  Size screenSize = MediaQuery.of(context).size;
                                  return SizedBox(
                                    width: screenSize.width,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.05),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Center(
                                            child: Text(
                                              'Repeat Every',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: screenSize.height * 0.04),
                                          ...options.map((option) {
                                            return CheckboxListTile(
                                              selectedTileColor: Colors.green,
                                              title: Text(
                                                option['text'],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      option['isChecked']
                                                          ? FontWeight.w600
                                                          : FontWeight.normal,
                                                  fontSize: option['isChecked']
                                                      ? 17
                                                      : 15,
                                                ),
                                              ),
                                              value: option['isChecked'],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  option['isChecked'] = value!;
                                                });
                                              },
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              activeColor: Colors.green,
                                              checkColor: Colors.white,
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.06,
                                vertical: screenSize.height * 0.014),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Monthly',
                                  style: TextStyle(
                                      // fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.05,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                  size: 20,
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(right: screenSize.width * 0.16),
                        child: const Text(
                          'Repeat For',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.01,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: screenSize.width * 0.008),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.01,
                                vertical: screenSize.height * 0.0005),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      count++;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.05,
                                ),
                                Text(
                                  count.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.05,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      count--;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(right: screenSize.width * 0.15),
                          child: const Text(
                            'Rate of interest',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.01),
                          child: TextFormField(
                            enabled: true,
                            enableInteractiveSelection: true,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 31, 1, 102),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.017,
                                  horizontal: screenSize.width * 0.03),
                              hintText: '0.0',
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 114, 113, 113),
                                fontSize: 15.0,
                              ),
                              suffixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.05,
                                      vertical: screenSize.height * 0.01),
                                  child: const Icon(
                                    Icons.percent,
                                    color: Color.fromARGB(255, 96, 96, 96),
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(right: screenSize.width * 0.2),
                          child: const Text(
                            'Start From',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.02),
                          child: InkWell(
                            onTap: () async {},
                            child: TextFormField(
                              cursorColor:
                                  const Color.fromARGB(255, 31, 1, 102),
                              showCursor: true,
                              canRequestFocus: true,
                              enabled: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                              decoration: InputDecoration(
                                hintText: '24-05-2024 06:00',
                                suffixIcon: const Icon(Icons.calendar_month),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.016,
                                    horizontal: screenSize.width * 0.02),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                    )),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                      ],
                      //   ),
                      // ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(right: screenSize.width * 0.28),
                          child: const Text(
                            'End On',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.01),
                          child: InkWell(
                            onTap: () async {},
                            child: TextFormField(
                              enabled: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.017,
                                    horizontal: screenSize.width * 0.03),
                                hintText: '24-05-2024',
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 114, 113, 113),
                                  fontSize: 15.0,
                                ),
                                suffixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.05,
                                        vertical: screenSize.height * 0.01),
                                    child: const Icon(
                                      Icons.calendar_month_rounded,
                                      color: Color.fromARGB(255, 96, 96, 96),
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                    )),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(right: screenSize.width * 0.28),
                          child: const Text(
                            'Name',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.02),
                          child: TextFormField(
                            cursorColor: const Color.fromARGB(255, 31, 1, 102),
                            showCursor: true,
                            canRequestFocus: true,
                            enabled: true,
                            enableInteractiveSelection: true,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 31, 1, 102),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.017,
                                  horizontal: screenSize.width * 0.03),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ],
                      //   ),
                      // ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.45),
                child: const Text(
                  'Notify Customer Via',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    showDragHandle: true,
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (BuildContext context) {
                      List<Map<String, dynamic>> options = [
                        {'text': 'SMS', 'isChecked': false},
                        {'text': 'E-Mail', 'isChecked': false},
                        {'text': 'Whatsapp', 'isChecked': false},
                      ];

                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          Size screenSize = MediaQuery.of(context).size;
                          return SizedBox(
                            width: screenSize.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.05),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Notify Customer Via',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.04),
                                  ...options.map((option) {
                                    return CheckboxListTile(
                                      selectedTileColor: Colors.green,
                                      title: Text(
                                        option['text'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: option['isChecked']
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                          fontSize:
                                              option['isChecked'] ? 17 : 15,
                                        ),
                                      ),
                                      value: option['isChecked'],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          option['isChecked'] = value!;
                                        });
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                  child: TextFormField(
                    enabled: false,
                    enableInteractiveSelection: false,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 31, 1, 102),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Sms, Email',
                      hintStyle: const TextStyle(color: Colors.black),
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 18,
                      ),
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
                height: screenSize.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.6),
                child: const Text(
                  'Billing Cycle',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    showDragHandle: true,
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (BuildContext context) {
                      List<Map<String, dynamic>> options = [
                        {'text': 'None', 'isChecked': false},
                        {'text': 'Pre-billing cycle', 'isChecked': false},
                        {'text': 'Post-billing cycle', 'isChecked': false},
                      ];

                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          Size screenSize = MediaQuery.of(context).size;
                          return SizedBox(
                            width: screenSize.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.05),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Notify Customer Via',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.04),
                                  ...options.map((option) {
                                    return CheckboxListTile(
                                      selectedTileColor: Colors.green,
                                      title: Text(
                                        option['text'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: option['isChecked']
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                          fontSize:
                                              option['isChecked'] ? 17 : 15,
                                        ),
                                      ),
                                      value: option['isChecked'],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          option['isChecked'] = value!;
                                        });
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                  child: TextFormField(
                    enabled: false,
                    enableInteractiveSelection: false,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 31, 1, 102),
                    ),
                    decoration: InputDecoration(
                      hintText: 'None',
                      hintStyle: const TextStyle(color: Colors.black),
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 18,
                      ),
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
                height: screenSize.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.4),
                child: const Text(
                  'Predue Reminders On',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    showDragHandle: true,
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (BuildContext context) {
                      List<Map<String, dynamic>> options = [
                        {'text': '1 day', 'isChecked': false},
                        {'text': '2 days', 'isChecked': false},
                        {'text': '3 days', 'isChecked': false},
                        {'text': '5 day', 'isChecked': false},
                        {'text': '7 days', 'isChecked': false},
                        {'text': '10 days', 'isChecked': false},
                        {'text': '15 days', 'isChecked': false},
                      ];

                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          Size screenSize = MediaQuery.of(context).size;
                          return SizedBox(
                            width: screenSize.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.05),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Notify Customer Via',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.04),
                                  ...options.map((option) {
                                    return CheckboxListTile(
                                      selectedTileColor: Colors.green,
                                      title: Text(
                                        option['text'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: option['isChecked']
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                          fontSize:
                                              option['isChecked'] ? 17 : 15,
                                        ),
                                      ),
                                      value: option['isChecked'],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          option['isChecked'] = value!;
                                        });
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                  child: TextFormField(
                    enabled: false,
                    enableInteractiveSelection: false,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 31, 1, 102),
                    ),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                        size: 18,
                      ),
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
                height: screenSize.height * 0.02,
              ),

              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.66),
                child: const Text(
                  'Remarks',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                onTap: () {
                  EssentialWidgetsCollection.imagePicker(
                    context,
                    galleryFunc: () async {
                      retailerImage = await _picker.pickImage(
                          maxHeight: 480,
                          maxWidth: 640,
                          source: ImageSource.gallery);
                      LoggerUtil().infoData(
                          "Captured Image From Gallery :- ${retailerImage!.path}");
                      setState(() {
                        retailerImageFile = retailerImage!.path;
                      });
                      Navigator.pop(context);
                    },
                    cameraFunc: () async {
                      retailerImage = await _picker.pickImage(
                          maxHeight: 480,
                          maxWidth: 640,
                          source: ImageSource.camera);
                      LoggerUtil().infoData(
                          "Captured Image From Camera :- ${retailerImage!.path}");
                      setState(() {
                        retailerImageFile = retailerImage!.path;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.66),
                  child: Card(
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01),
                    color: Colors.grey[100],
                    surfaceTintColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    shadowColor: const Color.fromARGB(255, 203, 202, 202),
                    elevation: 2.0,
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.grey,
                            size: 18,
                          ),
                          Text(
                            'Add New',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                child: TextFormField(
                  enabled: true,
                  scrollPadding:
                      EdgeInsets.symmetric(vertical: screenSize.height * 0.1),
                  enableInteractiveSelection: true,
                  // maxLength: 100,
                  minLines: 5,
                  maxLines: 10,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1000),
                  ],
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Add a note',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 114, 113, 113),
                      fontSize: 15.0,
                    ),
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

              SizedBox(
                height: screenSize.height * 0.11,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              behavior: SnackBarBehavior.floating,
              content: Text(
                "Please select customer to continue",
                style: TextStyle(),
              )));
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 31, 1, 102),
          ),
          padding: EdgeInsets.symmetric(
              vertical: screenSize.height * 0.015,
              horizontal: screenSize.width * 0.27),
          child: const Text(
            'Preview and SAVE',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
