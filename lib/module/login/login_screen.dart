// ignore_for_file: must_be_immutable

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
    late Map<String, dynamic> argus;
  LoginScreen({super.key, required this.argus});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20.0)),
                  // margin:
                  //     EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
                  padding: const EdgeInsets.all(15.0),
                  child: const Icon(
                    Icons.note_alt_sharp,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                const Text(
                  'Welcome to Digital Khata',
                  style: TextStyle(
                      color: Color.fromARGB(255, 31, 1, 102),
                      fontSize: 28,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: screenSize.height / 2,
                  child: ContainedTabBarView(
                    tabBarProperties: TabBarProperties(
                        labelPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.01),
                        labelColor: const Color.fromARGB(255, 31, 1, 102),
                        indicatorColor: const Color.fromARGB(255, 31, 1, 102),
                        labelStyle: const TextStyle(fontSize: 18.0),
                        isScrollable: false,
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.02)),
                    tabs: const [
                      Text('Phone Number'),
                      Text('Email Address'),
                    ],
                    views: [
                      //tab 1: phone numbers
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            cursorColor: const Color.fromARGB(255, 31, 1, 102),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 31, 1, 102),
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "resources/images/flag-removebg-preview.png",
                                  height: screenSize.height * 0.008,
                                  width: screenSize.width * 0.008,
                                ),
                              ),
                              hintText: 'Phone Number',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context,
                                  '/mobile-otp');
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.03),
                              padding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.013),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 31, 1, 102),
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: screenSize.width,
                              child: const Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      //tab 2: email address
                      Column(
                        children: [
                          TextFormField(
                            cursorColor: const Color.fromARGB(255, 31, 1, 102),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 31, 1, 102),
                            ),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Email Address',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.03),
                            padding: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.013),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 31, 1, 102),
                                borderRadius: BorderRadius.circular(10.0)),
                            width: screenSize.width,
                            child: const Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                    // ignore: avoid_print
                    onChange: (index) => print(index),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.06,
              vertical: screenSize.height * 0.01),
          // width: screenSize.width,
          decoration: const BoxDecoration(color: Colors.blue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 46.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0.0)),
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.001,
                    vertical: screenSize.height * 0.001),
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.01,
                ),
                child: Image.asset(
                  "resources/images/google-removebg-preview.png",
                  height: screenSize.height * 0.1,
                  width: screenSize.width * 0.1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.2),
                child: const Text(
                  'Sign with Google',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
