// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class EnableNotificationScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  EnableNotificationScreen({super.key, required this.argus});

  @override
  State<EnableNotificationScreen> createState() =>
      _EnableNotificationScreenState();
}

class _EnableNotificationScreenState extends State<EnableNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                )),
            title: const Text(
              'Enable Notifications',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  "resources/images/notification-removebg-preview.png",
                  height: screenSize.height * 0.2,
                  width: screenSize.width * 0.4,
                )),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                  child: const Text(
                    'Your device might not allow Digital Khata App to send notification. Here is how you can enble it.',
                    style: TextStyle(
                        color: Color.fromARGB(255, 117, 116, 116),
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05,
                      vertical: screenSize.height * 0.015),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '1.',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        'Open Autostart Permission',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Security > Permission > Autostart',
                  style: TextStyle(
                      color: Color.fromARGB(255, 113, 112, 112), fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05,
                      vertical: screenSize.height * 0.04),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '2.',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        'Set Digital Khata (in the app list) to ON',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.3,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/accounts');
                  },
                  child: Container(
                    // margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.3),
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.02,
                        horizontal: screenSize.height * 0.1),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 31, 1, 102),
                    ),
                    child: const Text(
                      'OPEN AUTOSTART PERMISSION',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: const SizedBox.shrink()),
    );
  }
}
