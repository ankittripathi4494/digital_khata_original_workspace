// ignore_for_file: must_be_immutable, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewEmiPlanScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  NewEmiPlanScreen({super.key, required this.argus});

  @override
  State<NewEmiPlanScreen> createState() => _NewEmiPlanScreenState();
}

class _NewEmiPlanScreenState extends State<NewEmiPlanScreen> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/invoice');
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            'New EMI Plan',
            style: TextStyle(color: Colors.white, fontSize: 25),
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
                                'Recurring Entry',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.01,
                              ),
                              const Text(
                                'Future Invoices Will Not Be Generated',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.04,
                              ),
                              const Text(
                                'Recurring Entry + Generated Invoices',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.01,
                              ),
                              const Text(
                                'Future Invoices Will Not Be Generated',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                'Generated Invoices Will Be Cancelled',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                'Linked Transactions To This Invoice Will Be Unlinked',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                'Generated Cash Out Entry For This Invoice Will Be Removed',
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
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.05,
                vertical: screenSize.height * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.8),
                  child: const Text(
                    'Title',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextFormField(
                  cursorColor: const Color.fromARGB(255, 31, 1, 102),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                  ),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Example: Mobile EMI ',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          // Color.fromARGB(255, 31, 1, 102),
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 31, 1, 102),
                          ),
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
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
                              const InkWell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Text(
                                    'Product',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  'Service',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  'Custom Amount',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
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
                          padding:
                              EdgeInsets.only(right: screenSize.width * 0.1),
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
                                    Size screenSize =
                                        MediaQuery.of(context).size;
                                    return SizedBox(
                                      width: screenSize.width,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                screenSize.width * 0.05),
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
                                                height:
                                                    screenSize.height * 0.04),
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
                                                    fontSize:
                                                        option['isChecked']
                                                            ? 17
                                                            : 15,
                                                  ),
                                                ),
                                                value: option['isChecked'],
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    option['isChecked'] =
                                                        value!;
                                                  });
                                                },
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                activeColor: Colors.green,
                                                checkColor: Colors.white,
                                              );
                                            }).toList(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: screenSize.width * 0.6),
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
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.5),
                  child: const Text(
                    'Notify Customer Via',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
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
                          builder:
                              (BuildContext context, StateSetter setState) {
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
                                    }).toList(),
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
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.02),
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
                  padding: EdgeInsets.only(right: screenSize.width * 0.65),
                  child: const Text(
                    'Billing Cycle',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
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
                          {'text': 'None', 'isChecked': false},
                          {'text': 'Pre-billing cycle', 'isChecked': false},
                          {'text': 'Post-billing cycle', 'isChecked': false},
                        ];

                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
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
                                    }).toList(),
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
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.02),
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
                  padding: EdgeInsets.only(right: screenSize.width * 0.49),
                  child: const Text(
                    'Predue Reminders On',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
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
                          builder:
                              (BuildContext context, StateSetter setState) {
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
                                    }).toList(),
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
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.02),
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
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // showOptions();
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
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
                // Padding(
                //   padding: EdgeInsets.only(right: screenSize.width * 0.69),
                //   child: const Text(
                //     'Remarks',
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 18,
                //         fontWeight: FontWeight.w500),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(right: screenSize.width * 0.69),
                //   child: Card(
                //     margin:
                //         EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                //     color: Colors.grey[100],
                //     surfaceTintColor: Colors.grey[100],
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.0)),
                //     shadowColor: const Color.fromARGB(255, 203, 202, 202),
                //     elevation: 2.0,
                //     child: const Padding(
                //       padding: EdgeInsets.all(15.0),
                //       child: Column(
                //         children: [
                //           Icon(
                //             Icons.download_for_offline_rounded,
                //             color: Colors.grey,
                //             size: 18,
                //           ),
                //           Text(
                //             'Add New',
                //             style: TextStyle(color: Colors.grey, fontSize: 10),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: screenSize.height * 0.03,
                // ),
                // TextFormField(
                //   enabled: true,
                //   scrollPadding:
                //       EdgeInsets.symmetric(vertical: screenSize.height * 0.1),
                //   enableInteractiveSelection: true,
                //   maxLength: 100,
                //   minLines: 5,
                //   maxLines: 10,
                //   inputFormatters: [
                //     LengthLimitingTextInputFormatter(1000),
                //   ],
                //   keyboardType: TextInputType.multiline,
                //   textInputAction: TextInputAction.newline,
                //   style: const TextStyle(
                //     color: Color.fromARGB(255, 31, 1, 102),
                //   ),
                //   decoration: InputDecoration(
                //     hintText: 'Add a note',
                //     hintStyle: const TextStyle(
                //       color: Color.fromARGB(255, 114, 113, 113),
                //       fontSize: 15.0,
                //     ),
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: const BorderSide(color: Colors.grey)),
                //     enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: const BorderSide(color: Colors.grey)),
                //     focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: const BorderSide(
                //           color: Color.fromARGB(255, 31, 1, 102),
                //         )),
                //     disabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: const BorderSide(color: Colors.grey)),
                //   ),
                // ),
                // SizedBox(
                //   height: screenSize.height * 0.1,
                // )
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
                horizontal: screenSize.width * 0.4),
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
