// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SmsCreditScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  SmsCreditScreen({super.key, required this.argus});

  @override
  State<SmsCreditScreen> createState() => _SmsCreditScreenState();
}

class _SmsCreditScreenState extends State<SmsCreditScreen> {
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
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
                    const ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 30,
                      ),
                      title: Text(
                        'SMS',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      subtitle: Text('1000 SMS'),
                      trailing: Text(
                        '\u{20B9}${200.00}',
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromARGB(255, 219, 218, 218),
                          child: Text(
                            '-',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '1',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromARGB(255, 219, 218, 218),
                          child: Text(
                            '+',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    )
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
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
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: Container(),
                      ),
                      // Icon(
                      //   Icons.check_circle,
                      //   color: Colors.green,
                      //   size: 30,
                      // ),
                      title: const Text(
                        'WHATSAPP',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                      subtitle: const Text('1000 WhatsApp'),
                      trailing: const Text(
                        '\u{20B9}${400.00}',
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromARGB(255, 219, 218, 218),
                          child: Text(
                            '-',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '1',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromARGB(255, 219, 218, 218),
                          child: Text(
                            '+',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    )
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
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
                          '\u{20B9}${200.0}',
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
                          '\u{20B9}${36.0}',
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
                          '\u{20B9}${236.0}',
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
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context,
                      '/subscription');
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.02,
                      vertical: screenSize.height * 0.01),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Text(
                    'Get SMS at 20% discount. Tap for details',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.17,
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
                    '\u{20B9} ${236.0}',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
