// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SelectSmsTemplatesScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  SelectSmsTemplatesScreen({super.key, required this.argus});

  @override
  State<SelectSmsTemplatesScreen> createState() =>
      _SelectSmsTemplatesScreenState();
}

class _SelectSmsTemplatesScreenState extends State<SelectSmsTemplatesScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sms-remainder-settings');
            },
          ),
          title: const Text(
            'Select SMS Templates',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 203, 202, 202),
                    offset: Offset(0.0, 0.1),
                    blurRadius: 6.0)
              ]),
              child: const ListTile(
                leading: Icon(
                  Icons.language,
                  size: 28,
                  color: Color.fromARGB(255, 0, 31, 103),
                ),
                title: Text(
                  'Select Language',
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  'English',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 31, 103),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                trailing: Text(
                  'Change',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 31, 103),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.02,
                  horizontal: screenSize.width * 0.02),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 19, 140, 240),
                    Color.fromARGB(255, 243, 241, 241),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 203, 202, 202),
                        offset: Offset(0.0, 0.1),
                        blurRadius: 6.0)
                  ]),
              child: ListTile(
                  title: const Text(
                    'Dear #customer_name#,',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 54, 53, 53)),
                  ),
                  subtitle: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#business_name# requests you to pay the due amount of ',
                        style:
                            TextStyle(color: Color.fromARGB(255, 54, 53, 53)),
                      ),
                      Text(
                        '#Currency#.# current_balance#.Pleaase ignore if already paid.',
                        style:
                            TextStyle(color: Color.fromARGB(255, 54, 53, 53)),
                      ),
                      Text(
                        'Thank you.',
                        style:
                            TextStyle(color: Color.fromARGB(255, 54, 53, 53)),
                      ),
                      Text(
                        'Details #app_link#.',
                        style:
                            TextStyle(color: Color.fromARGB(255, 54, 53, 53)),
                      ),
                      Text(
                        'Sent using Meekhata',
                        style:
                            TextStyle(color: Color.fromARGB(255, 54, 53, 53)),
                      ),
                      Text(
                        '-Priyanka',
                        style:
                            TextStyle(color: Color.fromARGB(255, 54, 53, 53)),
                      ),
                    ],
                  ),
                  trailing: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size(screenSize.width * 0.002,
                            screenSize.height * 0.00001),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: const Color.fromARGB(255, 0, 31, 103)),
                    onPressed: () {},
                    child: const Text(
                      'Recommended',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  )),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01,
                        horizontal: screenSize.width * 0.02),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 203, 202, 202),
                              offset: Offset(0.0, 0.1),
                              blurRadius: 6.0)
                        ]),
                    child: const ListTile(
                      title: Text(
                        'Dear #customer_name#,',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 54, 53, 53)),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '#business_name# requests you to pay the due amount of ',
                            style: TextStyle(
                                color: Color.fromARGB(255, 54, 53, 53)),
                          ),
                          Text(
                            '#Currency#.# current_balance#.Pleaase ignore if already paid.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 54, 53, 53)),
                          ),
                          Text(
                            'Thank you.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 54, 53, 53)),
                          ),
                          Text(
                            'Details #app_link#.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 54, 53, 53)),
                          ),
                          Text(
                            'Sent using Meekhata',
                            style: TextStyle(
                                color: Color.fromARGB(255, 54, 53, 53)),
                          ),
                          Text(
                            '-Priyanka',
                            style: TextStyle(
                                color: Color.fromARGB(255, 54, 53, 53)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          height: screenSize.height * 0.15,
          width: screenSize.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.send_outlined,
                  color: Colors.red,
                ),
                label: const Text(
                  'Send test sms yourself',
                  style: TextStyle(color: Color.fromARGB(255, 0, 31, 103)),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    minimumSize:
                        Size(screenSize.width * 0.8, screenSize.height * 0.06),
                    backgroundColor: const Color.fromARGB(255, 0, 31, 103)),
                onPressed: () {},
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
