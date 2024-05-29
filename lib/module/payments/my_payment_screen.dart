// ignore_for_file: must_be_immutable

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPaymentScreen extends StatefulWidget {
    late Map<String, dynamic> argus;
  MyPaymentScreen({super.key, required this.argus});

  @override
  State<MyPaymentScreen> createState() => _MyPaymentScreenState();
}

class _MyPaymentScreenState extends State<MyPaymentScreen> {
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
                size: 28,
              )),
          title: const Text(
            'My Payments',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
         body: Column(
          children: [
            SizedBox(
              height: screenSize.height / 1.2,
              width: screenSize.width,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    ButtonsTabBar(
                      height: 60.0,
                      radius: 0,

                      contentPadding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.07, vertical: 10.0),
                      // Customize the appearance and behavior of the tab bar
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 31, 1, 102),
                          borderRadius: BorderRadius.circular(0)),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),

                      unselectedLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      // Add your tabs here
                      tabs: const [
                        Tab(
                          text: 'Approved Payment',
                        ),
                        Tab(
                          text: 'Pending Requests',
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          //tab 1: Approved payments
                          SizedBox(
                            height: screenSize.height,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenSize.height * 0.2,
                                ),
                                const Center(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        Color.fromARGB(255, 230, 223, 246),
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
                          //tab 2: Pending Request
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: const Icon(
                                Icons.person_2_sharp,
                                color: Colors.grey,
                              ),
                            ),
                            title: const Text(
                              'John',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                            ),
                            subtitle: const Text('8767657645'),
                            trailing: const Column(
                              children: [
                                Text(
                                  '\u{20B9} ${300}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Pending',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
