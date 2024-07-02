// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderActivity extends StatefulWidget {
  late Map<String, dynamic> argus;
  ReminderActivity({super.key, required this.argus});

  @override
  State<ReminderActivity> createState() => _ReminderActivityState();
}

class _ReminderActivityState extends State<ReminderActivity> {
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
                Navigator.pushReplacementNamed(context, '/business');
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
                color: Colors.white,
              )),
          title: const Text(
            'Reminder Activity',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    backgroundColor: Colors.white,
                    scrollControlDisabledMaxHeightRatio: 0.6,
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
                                'Download Reminder Log',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.06,
                              ),
                              child: const Text(
                                'From Date',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.05,
                                  vertical: screenSize.height * 0.01),
                              child: InkWell(
                                onTap: () async {
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
                                              primary: Colors.blue,
                                              onSecondary: Colors.black,
                                              onPrimary: Colors.white,
                                              surface: Color.fromARGB(
                                                  255, 0, 31, 103),
                                              surfaceContainerHighest:
                                                  Colors.grey,
                                              onSurface: Colors.white,
                                              secondary: Colors.red),
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
                                  cursorColor:
                                      const Color.fromARGB(255, 31, 1, 102),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.calendar_month,
                                      color: Color.fromARGB(255, 122, 122, 122),
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    fillColor: const Color.fromARGB(
                                        255, 192, 191, 191),
                                    filled: true,
                                    hintText: '28-05-2024',
                                    hintStyle:
                                        const TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: screenSize.height * 0.01,
                                        horizontal: screenSize.width * 0.03),
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
                              height: screenSize.height * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.06,
                              ),
                              child: const Text(
                                'To Date',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.05,
                                  vertical: screenSize.height * 0.01),
                              child: InkWell(
                                onTap: () async {
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
                                          splashColor: Colors.white,
                                          colorScheme: const ColorScheme.light(
                                              primary: Colors.blue,
                                              onSecondary: Colors.black,
                                              onPrimary: Colors.white,
                                              surface: Color.fromARGB(
                                                  255, 0, 31, 103),
                                              surfaceContainerHighest:
                                                  Colors.grey,
                                              onSurface: Colors.white,
                                              secondary: Colors.red),
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
                                  cursorColor:
                                      const Color.fromARGB(255, 31, 1, 102),
                                  decoration: InputDecoration(
                                    fillColor: const Color.fromARGB(
                                        255, 192, 191, 191),
                                    filled: true,
                                    hintText: '28-05-2024',
                                    hintStyle:
                                        const TextStyle(color: Colors.black),
                                    prefixIcon: const Icon(
                                      Icons.calendar_month,
                                      color: Color.fromARGB(255, 122, 122, 122),
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: screenSize.height * 0.01,
                                        horizontal: screenSize.width * 0.03),
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
                              height: screenSize.height * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.06,
                              ),
                              child: const Text(
                                'Select Customer',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.05,
                                  vertical: screenSize.height * 0.01),
                              child: InkWell(
                                onTap: () async {
                                  Navigator.pushNamed(
                                      context, '/select-customer');
                                },
                                child: TextFormField(
                                  enabled: false,
                                  enableInteractiveSelection: false,
                                  cursorColor:
                                      const Color.fromARGB(255, 31, 1, 102),
                                  decoration: InputDecoration(
                                    fillColor: const Color.fromARGB(
                                        255, 192, 191, 191),
                                    filled: true,
                                    hintText: 'All Customers',
                                    hintStyle:
                                        const TextStyle(color: Colors.black),
                                    prefixIcon: const Icon(
                                      Icons.person_2_outlined,
                                      color: Color.fromARGB(255, 122, 122, 122),
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: screenSize.height * 0.01,
                                        horizontal: screenSize.width * 0.03),
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
                              height: screenSize.height * 0.03,
                            ),
                            Center(
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    minimumSize: Size(screenSize.width * 0.9,
                                        screenSize.height * 0.07),
                                    backgroundColor:
                                        const Color.fromARGB(255, 0, 31, 103)),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Download',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.download,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter_alt,
                  color: Colors.white,
                ))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.2,
            ),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 230, 223, 246),
                child: Icon(
                  CupertinoIcons.search_circle_fill,
                  size: 60,
                  color: Colors.brown,
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.06,
            ),
            const Text(
              'No Data',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: screenSize.height * 0.06,
            ),
          ],
        ),
      ),
    );
  }
}
