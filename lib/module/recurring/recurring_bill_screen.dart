// ignore_for_file: must_be_immutable, unused_field, unused_local_variable

import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class RecurringBillScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  RecurringBillScreen({super.key, required this.argus});

  @override
  State<RecurringBillScreen> createState() => _RecurringBillScreenState();
}

class _RecurringBillScreenState extends State<RecurringBillScreen> {
  bool? isCheckbox = false;
  final List<String> _locations = ['Select'];
  String? _selectedLocation;
  int count = 1;
  late File _image;
  final ImagePicker _picker = ImagePicker();
  XFile? attachImage;
  String? attachImageFile;

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
            'Recurring Bill',
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
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/select-customer');
                  },
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
                        color: Colors.black,
                      ),
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
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/bill-plan');
                  },
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
                TextFormField(
                  enabled: true,
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                          vertical: screenSize.height * 0.01),
                      child: const Text(
                        '\u{20B9} ${0}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800),
                      ),
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
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     const Text(
                    //       'Repeate Every',
                    //       style: TextStyle(color: Colors.black),
                    //     ),
                    //     SizedBox(
                    //       height: screenSize.height * 0.01,
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: screenSize.width * 0.08),
                    //       decoration: BoxDecoration(
                    //           border: Border.all(color: Colors.grey),
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(8.0)),
                    //       child: DropdownButtonHideUnderline(
                    //         child: DropdownButton(
                    //           // padding: EdgeInsets.symmetric(horizontal: 10.0),
                    //           icon: const Icon(
                    //             Icons.arrow_drop_down,
                    //             color: Colors.black,
                    //           ), //
                    //           dropdownColor: Colors.black,

                    //           hint: const Text(
                    //             'Monthly',
                    //             style: TextStyle(color: Colors.black),
                    //           ), //necessary for Option 1
                    //           value: _selectedLocation,
                    //           onChanged: (newValue) {
                    //             // showShareScreenPopup(context);
                    //             setState(() {
                    //               isCheckbox = true;
                    //               LoggerUtil().infoData(isCheckbox);
                    //             });
                    //             // isCheckbox = false;
                    //           },
                    //           // onTap: () {
                    //           // setState(() {
                    //           //   isCheckbox = true;
                    //           //   LoggerUtil().infoData(isCheckbox);
                    //           // });
                    //           // },
                    //           items: _locations.map((location) {
                    //             return DropdownMenuItem(
                    //               onTap: () {
                    //                 setState(() {
                    //                   isCheckbox = true;
                    //                   LoggerUtil().infoData(isCheckbox);
                    //                 });
                    //               },
                    //               value: location,
                    //               child: Text(
                    //                 location,
                    //                 style: const TextStyle(color: Colors.white),
                    //               ),
                    //             );
                    //           }).toList(),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Repeat Every',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Repeat For',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        Container(
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
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.65),
                  child: const Text(
                    'Start From',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedStartDate = await showDatePicker(
                      context: context,

                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      // firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            primarySwatch: Colors.grey,
                            splashColor: Colors.black,
                            colorScheme: const ColorScheme.light(
                              primary: Colors.white,
                              onSecondary: Colors.black,
                              onPrimary: Colors.black,
                              surface: Color.fromARGB(255, 31, 1, 102),
                              surfaceContainerHighest: Colors.grey,
                              onSurface: Colors.white,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: child!,
                        );
                      },
                      // currentDate: DateTime(DateTime.january),
                    );
                  },
                  child: TextFormField(
                    enabled: false,
                    enableInteractiveSelection: false,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 31, 1, 102),
                    ),
                    decoration: InputDecoration(
                      hintText: '24-05-2024 10:30 AM',
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: screenSize.width * 0.1),
                            child: const Text(
                              'End On',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.01),
                            child: InkWell(
                              onTap: () async {
                                DateTime? pickedStartDate =
                                    await showDatePicker(
                                  context: context,

                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  // firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.grey,
                                        splashColor: Colors.black,
                                        colorScheme: const ColorScheme.light(
                                          primary: Colors.white,
                                          onSecondary: Colors.black,
                                          onPrimary: Colors.black,
                                          surface:
                                              Color.fromARGB(255, 31, 1, 102),
                                          surfaceContainerHighest: Colors.grey,
                                          onSurface: Colors.white,
                                        ),
                                        dialogBackgroundColor: Colors.white,
                                      ),
                                      child: child!,
                                    );
                                  },
                                  // currentDate: DateTime(DateTime.january),
                                );
                              },
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: screenSize.width * 0.15),
                            child: const Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.02),
                            child: TextFormField(
                              cursorColor:
                                  const Color.fromARGB(255, 31, 1, 102),
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
                  height: screenSize.height * 0.02,
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
                SizedBox(
                  height: screenSize.height * 0.02,
                ),

                Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.69),
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
                        attachImage = await _picker.pickImage(
                            maxHeight: 480,
                            maxWidth: 640,
                            source: ImageSource.gallery);
                        LoggerUtil().infoData(
                            "Captured Image From Gallery :- ${attachImage!.path}");
                        setState(() {
                          attachImageFile = attachImage!.path;
                        });
                        Navigator.pop(context);
                      },
                      cameraFunc: () async {
                        attachImage = await _picker.pickImage(
                            maxHeight: 480,
                            maxWidth: 640,
                            source: ImageSource.camera);
                        LoggerUtil().infoData(
                            "Captured Image From Camera :- ${attachImage!.path}");
                        setState(() {
                          attachImageFile = attachImage!.path;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: screenSize.width * 0.69),
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
                TextFormField(
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
                horizontal: screenSize.width * 0.27),
            child: const Text(
              'Preview and SAVE',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
