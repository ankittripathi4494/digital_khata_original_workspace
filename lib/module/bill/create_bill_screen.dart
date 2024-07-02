// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CreateBillScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  CreateBillScreen({super.key, required this.argus});

  @override
  State<CreateBillScreen> createState() => _CreateBillScreenState();
}

class _CreateBillScreenState extends State<CreateBillScreen> {
  bool? isChecked = true;
  String currenttext = '';
  List<String> text = ['Text', 'Dropdown'];
  Future<bool> showDraftPopup(context) async {
    // exit from app
    return await showDialog(
        // barrierColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: const Text('Please select atleast one item to continue'),
          );
          // });
        });
  }

  @override
  void initState() {
    // Future.delayed(
    //     Duration(
    //       seconds: 1,
    //     ), () {
    //   return AlertDialog();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/invoice');
          },
        ),
        title: const Text(
          'Create Bill',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.009,
              ),
              margin: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.02,
              ),
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
              child: ListTile(
                title: const Text(
                  'Bill #',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                subtitle: const Text('23-05-2023'),
                trailing: TextButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        backgroundColor: Colors.white,
                        scrollControlDisabledMaxHeightRatio: 0.5,
                        showDragHandle: true,
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: screenSize.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: screenSize.height * 0.03,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Text(
                                    'Invoice Number',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.05),
                                  child: TextFormField(
                                    cursorColor:
                                        const Color.fromARGB(255, 31, 1, 102),
                                    decoration: InputDecoration(
                                      hintText: 'ex. 001 ',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
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
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.06,
                                      vertical: 10.0),
                                  child: const Text(
                                    'invoice/Bill will be auto generated, if no code provided ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 116, 115, 115),
                                        fontSize: 15),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Text(
                                    'Created date',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.05),
                                  child: TextFormField(
                                    cursorColor:
                                        const Color.fromARGB(255, 31, 1, 102),
                                    decoration: InputDecoration(
                                      hintText: '23-05-2024',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
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
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.03,
                                ),
                                Container(
                                    width: screenSize.width,
                                    height: screenSize.height * 0.06,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.05,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenSize.height * 0.018),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 31, 1, 102),
                                      borderRadius: BorderRadius.circular(8.0),
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
                                        'Save',
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
                      'Edit',
                      style: TextStyle(color: Colors.green, fontSize: 18.0),
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/select-customer');
              },
              child: Container(
                width: screenSize.width,
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.001,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.002,
                ),
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
                child: ListTile(
                  leading: const Icon(
                    Icons.add_circle_outline,
                    color: Color.fromARGB(255, 31, 1, 102),
                  ),
                  title: const Text(
                    'Select Customer',
                    style: TextStyle(
                        color: Color.fromARGB(255, 31, 1, 102), fontSize: 18),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_outlined,
                            size: 20, color: Color.fromARGB(255, 31, 1, 102))),
                  ),
                ),
              ),
            ),
            Container(
              width: screenSize.width,
              padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.01,
              ),
              margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.022),
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
                    child: const Text(
                      'Payment Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
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
                        Icons.add_circle_outline,
                        color: Color.fromARGB(255, 31, 1, 102),
                      ),
                      minLeadingWidth: 0.0,
                      title: Text(
                        'Add Total Amount',
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 1, 102),
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenSize.width,
              padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.009,
              ),
              // margin: EdgeInsets.symmetric(
              //   vertical: screenSize.height * 0.02,
              // ),
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
              child: const ListTile(
                leading: Icon(
                  Icons.alarm,
                  color: Colors.green,
                ),
                title: Text(
                  'Due Reminder',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Row(
                  children: [
                    Text('Due date is on '),
                    Text(
                      '23-05-2023',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                // trailing: TextButton(
                //     onPressed: () {},
                //     child: const Text(
                //       'Edit',
                //       style: TextStyle(color: Colors.green, fontSize: 18.0),
                //     )),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.024,
            ),
            Container(
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
                  const ListTile(
                    leading: Icon(
                      Icons.file_copy_outlined,
                      color: Color.fromARGB(255, 31, 1, 102),
                    ),
                    title: Text(
                      'Add Attachment',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.06),
                    child: const Divider(),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        backgroundColor: Colors.white,
                        scrollControlDisabledMaxHeightRatio: 0.53,
                        showDragHandle: true,
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: screenSize.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Text(
                                    'Enter Notes',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.05),
                                  child: TextFormField(
                                    cursorColor:
                                        const Color.fromARGB(255, 31, 1, 102),
                                    decoration: InputDecoration(
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
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                                Container(
                                    width: screenSize.width,
                                    height: screenSize.height * 0.06,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.05,
                                        vertical: screenSize.height * 0.03),
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenSize.height * 0.018),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 31, 1, 102),
                                      borderRadius: BorderRadius.circular(8.0),
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
                                        'Update',
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
                    child: const ListTile(
                      leading: Icon(
                        Icons.message,
                        color: Color.fromARGB(255, 31, 1, 102),
                      ),
                      title: Text(
                        'Notes / Remark',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.06),
                    child: const Divider(),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        backgroundColor: Colors.white,
                        scrollControlDisabledMaxHeightRatio: 0.44,
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
                                    'Notify Customer Via',
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
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'SMS',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.1,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'E-Mail',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.1,
                                      vertical: screenSize.height * 0.02),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Whatsapp',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    width: screenSize.width,
                                    height: screenSize.height * 0.06,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.05,
                                        vertical: screenSize.height * 0.03),
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenSize.height * 0.018),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 31, 1, 102),
                                      borderRadius: BorderRadius.circular(8.0),
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
                    child: const ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 31, 1, 102),
                      ),
                      title: Text(
                        'Notify Customer Via',
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text('Sms, Email, Whatsapp'),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color.fromARGB(255, 31, 1, 102),
                        size: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.06),
                    child: const Divider(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.03),
                    child: TextButton.icon(
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
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Color.fromARGB(255, 31, 1, 102),
                        ),
                        label: const Text(
                          'Add Custom Properties',
                          style: TextStyle(
                              color: Color.fromARGB(255, 31, 1, 102),
                              fontSize: 17),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Please select customer to continue",
                            style: TextStyle(),
                          )));
                      // showDraftPopup(context);
                      // Future.delayed(
                      //     const Duration(
                      //       seconds: 1,
                      //     ), () {
                      //   return showDraftPopup(context);
                      // });
                    },
                    child: Container(
                        width: screenSize.width,
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.1,
                            vertical: screenSize.height * 0.018),
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.018),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 187, 186, 186),
                              offset: Offset(0.0, 1.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Save as Draft',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.1,
                  )
                  // TextButton(
                  //     style: TextButton.styleFrom(
                  //       minimumSize: Size(
                  //           screenSize.width * 0.1, screenSize.height * 0.01),
                  //       backgroundColor: const Color.fromARGB(255, 31, 1, 102),
                  //     ),
                  //     onPressed: () {},
                  //     child: const Text(
                  //       'Save as Draft',
                  //       style: TextStyle(
                  //         color: Colors.blue,
                  //       ),
                  //     ))
                ],
              ),
            ),
          ],
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
            width: screenSize.width,
            height: screenSize.height * 0.06,
            margin: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.1,
            ),
            padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.018),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 31, 1, 102),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 187, 186, 186),
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            )),
      ),
    );
  }
}
