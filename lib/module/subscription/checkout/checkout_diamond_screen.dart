// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CheckoutDiamondScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  CheckoutDiamondScreen({super.key, required this.argus});

  @override
  State<CheckoutDiamondScreen> createState() => _CheckoutDiamondScreenState();
}

class _CheckoutDiamondScreenState extends State<CheckoutDiamondScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Checkout',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 203, 202, 202),
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                ),
                title: Text(
                  'Diamond',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                subtitle: Text('Diamond yearly subscription'),
                trailing: Column(
                  children: [
                    Text(
                      '\u{20B9}${6000}',
                      style: TextStyle(color: Colors.green, fontSize: 20.0),
                    ),
                    Text(
                      'per Year',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.06,
                  vertical: screenSize.height * 0.02),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 203, 202, 202),
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bill Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sub Total',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      Text(
                        '\u{20B9}${6000.0}',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Taxes & Charges(GST - 18.0%)',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      Text(
                        '\u{20B9}${1080.0}',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      )
                    ],
                  ),
                  const Text(
                    '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'To Pay',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '\u{20B9}${7080.0}',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.45,
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 31, 1, 102),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: const Text(
                    '1',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                title: const Text(
                  'Total Value',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                subtitle: const Text(
                  '\u{20B9} ${7080.0}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
                trailing: const Text(
                  'PAY NOW',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
