// ignore_for_file: must_be_immutable

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  SubscriptionScreen({super.key, required this.argus});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
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
              )),
          title: const Text(
            'Subscriptions',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
        body: Container(
          color: Colors.grey[100],
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height / 1.3,
                width: screenSize.width,
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      ButtonsTabBar(
                        labelSpacing: 0.0,
                        height: screenSize.height * 0.06,
                        // buttonMargin: const EdgeInsets.symmetric(
                        //     horizontal: 10.0, vertical: 5.0),
                        radius: 0,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 10.0),
                        // Customize the appearance and behavior of the tab bar
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 31, 1, 102),
                          // borderRadius: BorderRadius.circular(30)
                        ),

                        // borderWidth: 2,
                        // borderColor: Colors.black,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedBackgroundColor: Colors.white,

                        unselectedLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        // Add your tabs here
                        tabs: const [
                          Tab(
                            text: 'Free',
                          ),
                          Tab(
                            text: 'Diamond',
                          ),
                          Tab(
                            text: 'Platinnum',
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            //tab 1: All
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 203, 202, 202),
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10.0)),

                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 30.0),
                              // width: 100,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.height * 0.015,
                                    vertical: screenSize.height * 0.01),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 8,
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.02,
                                        ),
                                        const Text(
                                          '10 Customer Accounts',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.006,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 8,
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.02,
                                        ),
                                        const Text(
                                          '1 User',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.006,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 8,
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.02,
                                        ),
                                        const Text(
                                          'Desktop Access',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.006,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 8,
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.02,
                                        ),
                                        const Text(
                                          'Invoices',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.006,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 8,
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.02,
                                        ),
                                        const Text(
                                          'Recurring Invoices',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.006,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 8,
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.02,
                                        ),
                                        const Text(
                                          'Finance/EMI Management',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //tab 2: Diamond
                            Container(
                              color: Colors.grey[100],
                              // height: 200,
                              // width: 100,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 30.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 31, 1, 102),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 203, 202, 202),
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Billed Yearly',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '\u{20B9}${8400}',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '\u{20B9}${6000}',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 31, 1, 102),
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 0.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 31, 1, 102),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 203, 202, 202),
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Billed Monthly',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '\u{20B9}${700}',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 31, 1, 102),
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 30.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 30.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 203, 202, 202),
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10.0)),

                                    // height: scr
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Unlimited Customer Accounts',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.002,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Rs 0.16p per SMS ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Rs.0.40p per WhatsApp Message',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              '5 Users',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Desktop Access',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(children: [
                                          const Icon(
                                            Icons.circle,
                                            size: 8,
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.02,
                                          ),
                                          const Text(
                                            'Invoices',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(children: [
                                          const Icon(
                                            Icons.circle,
                                            size: 8,
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.02,
                                          ),
                                          const Text(
                                            'Recurring Invoices',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Finance/EMI Management',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Rozorpay,PayTM online Gateway Integration',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                       Navigator.pushNamed(
                                          context,
                                          '/check-diamond');
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.28,
                                          vertical: screenSize.height * 0.012),
                                      child: const Text(
                                        '\u{20B9}${6000} Buy Now',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //tab 3: platinum
                            Container(
                              color: Colors.grey[100],
                              // height: 200,
                              // width: 100,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 30.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 31, 1, 102),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 203, 202, 202),
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Billed Yearly',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '\u{20B9}${2400}',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '\u{20B9}${1800}',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 31, 1, 102),
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 20.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 0.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 31, 1, 102),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 203, 202, 202),
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Billed Monthly',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '\u{20B9}${200}',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 31, 1, 102),
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 30.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 30.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 203, 202, 202),
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10.0)),

                                    // height: scr
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              '200 Customer Accounts',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.002,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Rs 0.16p per SMS ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Rs.0.40p per WhatsApp Message',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              '2 Users(Owner + 1 staff)',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Desktop Access',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(children: [
                                          const Icon(
                                            Icons.circle,
                                            size: 8,
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.02,
                                          ),
                                          const Text(
                                            'Invoices',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(children: [
                                          const Icon(
                                            Icons.circle,
                                            size: 8,
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.02,
                                          ),
                                          const Text(
                                            'Recurring Invoices',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Finance/EMI Management',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.006,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              size: 8,
                                            ),
                                            SizedBox(
                                              width: screenSize.width * 0.02,
                                            ),
                                            const Text(
                                              'Rozorpay,PayTM online Gateway Integration',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          '/check-platinum');
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.28,
                                          vertical: screenSize.height * 0.012),
                                      child: const Text(
                                        '\u{20B9}${1800} Buy Now',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
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
      ),
    );
  }
}
