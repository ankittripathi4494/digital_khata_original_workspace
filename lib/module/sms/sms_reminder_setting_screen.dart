// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:talker/talker.dart';

class SmsReminderSettingscreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  SmsReminderSettingscreen({super.key, required this.argus});

  @override
  State<SmsReminderSettingscreen> createState() =>
      _SmsReminderSettingscreenState();
}

class _SmsReminderSettingscreenState extends State<SmsReminderSettingscreen> {
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
              color: Colors.white,
            ),
          ),
          title: const Text(
            'SMS Settings',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10.0)),
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/subscription');
                  },
                  title: const Text(
                    'You want to send automatic whatsapp message?',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  subtitle: const Text(
                    'See your prime plans for details',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 203, 202, 202),
                          offset: Offset(0.0, 0.1),
                          blurRadius: 6.0)
                    ]),
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/select-sms-template');
                      },
                      title: const Text(
                        'Choose SMS Template',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.03),
                      child: const Divider(),
                    ),
                    const ListTile(
                      title: Text(
                        'Customize SMS Message',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.03),
                      child: const Divider(),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.note_alt,
                        size: 28,
                        color: Color.fromARGB(255, 0, 31, 103),
                      ),
                      title: const Text(
                        'Send Transaction Notes in SMS',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        'Notes added against transactions will be send in sms. CLick here for more info',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      trailing: SwitcherButton(
                        size: screenSize.width * 0.09,
                        onColor: const Color.fromARGB(255, 31, 1, 102),
                        offColor: const Color.fromARGB(255, 203, 203, 203),
                        value: true,
                        onChange: (value) {
                          if (kDebugMode) {
                            Talker().info(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 203, 202, 202),
                          offset: Offset(0.0, 0.1),
                          blurRadius: 6.0)
                    ]),
                child: const ListTile(
                  // leading: const Icon(
                  //   Icons.note_alt,
                  //   size: 28,
                  //   color: Color.fromARGB(255, 0, 31, 103),
                  // ),
                  title: Text(
                    'On Due Reminder(Automatic/Manual)',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 31, 103),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Priyanka requests you to pay the due ampunt of Rs.500.\nPlease ignore it if already paid. Thank you',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 203, 202, 202),
                          offset: Offset(0.0, 0.1),
                          blurRadius: 6.0)
                    ]),
                child: const ListTile(
                  // leading: const Icon(
                  //   Icons.note_alt,
                  //   size: 28,
                  //   color: Color.fromARGB(255, 0, 31, 103),
                  // ),
                  title: Text(
                    'On Due Paid',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 31, 103),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Dear Customer, you have paid Rs.500 to Priyanka. Due balance remaining from you is Rs.0. Thank you',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 203, 202, 202),
                          offset: Offset(0.0, 0.1),
                          blurRadius: 6.0)
                    ]),
                child: const ListTile(
                  // leading: const Icon(
                  //   Icons.note_alt,
                  //   size: 28,
                  //   color: Color.fromARGB(255, 0, 31, 103),
                  // ),
                  title: Text(
                    'On Due Added',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 31, 103),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Dear Customer, your due balance is Rs.500 to Priyanka. Please ignore this message, if you have already paid.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
