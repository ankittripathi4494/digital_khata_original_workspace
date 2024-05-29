// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentConfigurationScreen extends StatefulWidget {
    late Map<String, dynamic> argus;
  PaymentConfigurationScreen({super.key, required this.argus});

  @override
  State<PaymentConfigurationScreen> createState() =>
      _PaymentConfigurationScreenState();
}

class _PaymentConfigurationScreenState
    extends State<PaymentConfigurationScreen> {
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
            'Payment Providers',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
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
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.11),
              child: const Text(
                'Add various payments details like your UPI, Bank Accounts, IFSC code etc here.',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.large(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            backgroundColor: const Color.fromARGB(255, 31, 1, 102),
            onPressed: () {
              showModalBottomSheet<void>(
                backgroundColor: Colors.white,
                scrollControlDisabledMaxHeightRatio: 0.5,
                showDragHandle: true,
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenSize.width,
                        decoration: const BoxDecoration(),
                        child: const Center(
                          child: Text(
                            'Payment Providers',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context,
                              '/upi-payment');
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'UPI',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'NetBanking',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'RazorPay(account Connect)',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'RazorPay(Keys Connect)',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'Stripe',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'Paytm Merchant',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 50,
            )),
      ),
    );
  }
}
