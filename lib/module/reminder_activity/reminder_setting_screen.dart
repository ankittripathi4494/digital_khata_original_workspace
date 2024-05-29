// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:switcher_button/switcher_button.dart';

class ReminderSettingScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ReminderSettingScreen({super.key, required this.argus});

  @override
  State<ReminderSettingScreen> createState() => _ReminderSettingScreenState();
}

class _ReminderSettingScreenState extends State<ReminderSettingScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/business');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Reminder Setting',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.1,
                vertical: screenSize.height * 0.04),
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: const Center(
              child: Text(
                'Customize and decide yourself when you want to notify your customer on different actions',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
            ),
            padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.02,
                horizontal: screenSize.width * 0.03),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 203, 202, 202),
                      offset: Offset(0.0, 0.1),
                      blurRadius: 6.0)
                ],
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cash-in/Cash-out Reminder',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 31, 103), fontSize: 16),
                    ),
                    SwitcherButton(
                      size: screenSize.width * 0.1,
                      onColor: const Color.fromARGB(255, 31, 1, 102),
                      offColor: const Color.fromARGB(255, 203, 203, 203),
                      value: true,
                      onChange: (value) {
                        if (kDebugMode) {
                          print(value);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Business Reminder Setting Updated successfully",
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recurring TransactionReminder',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 31, 103), fontSize: 16),
                    ),
                    SwitcherButton(
                      size: screenSize.width * 0.1,
                      onColor: const Color.fromARGB(255, 31, 1, 102),
                      offColor: const Color.fromARGB(255, 203, 203, 203),
                      value: true,
                      onChange: (value) {
                        if (kDebugMode) {
                          print(value);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Business Reminder Setting Updated successfully",
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pre-due Reminder On No Due',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 31, 103), fontSize: 16),
                    ),
                    SwitcherButton(
                      size: screenSize.width * 0.1,
                      onColor: const Color.fromARGB(255, 31, 1, 102),
                      offColor: const Color.fromARGB(255, 203, 203, 203),
                      value: true,
                      onChange: (value) {
                        if (kDebugMode) {
                          print(value);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Business Reminder Setting Updated successfully",
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Overdue Reminder',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 31, 103), fontSize: 16),
                    ),
                    SwitcherButton(
                      size: screenSize.width * 0.1,
                      onColor: const Color.fromARGB(255, 31, 1, 102),
                      offColor: const Color.fromARGB(255, 203, 203, 203),
                      value: true,
                      onChange: (value) {
                        if (kDebugMode) {
                          print(value);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Business Reminder Setting Updated successfully",
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
