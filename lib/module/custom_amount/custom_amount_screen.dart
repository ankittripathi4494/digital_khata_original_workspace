// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomAmountScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  CustomAmountScreen({super.key, required this.argus});

  @override
  State<CustomAmountScreen> createState() => _CustomAmountScreenState();
}

class _CustomAmountScreenState extends State<CustomAmountScreen> {
  int count = 0;
  late String? customAmount;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/emi', arguments: {
                "addContent": '',
                "customAmount": '',
              });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Custom Amount',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.01,
                // horizontal: screenSize.width * 0.03
              ),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 203, 202, 202),
                    offset: Offset(0.0, 0.1),
                    blurRadius: 6.0)
              ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: screenSize.width * 0.029),
                  //   child: Text(
                  //     'Name',
                  //     style: TextStyle(color: Colors.black, fontSize: 15,),
                  //   ),
                  // ),
                  TextFormField(
                    cursorColor: const Color.fromARGB(255, 31, 2, 103),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 31, 2, 103),
                    ),
                    decoration: const InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none)),
                  ),
                  const Divider(),
                  // Text('Amount'),
                  TextFormField(
                    cursorColor: const Color.fromARGB(255, 31, 2, 103),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 31, 2, 103),
                    ),
                    decoration: const InputDecoration(
                        hintText: 'Amount',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none)),
                  ),
                  // Divider(),
                  Container(
                    width: screenSize.width,
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01),
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.02,
                        horizontal: screenSize.width * 0.03),
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 203, 202, 202),
                          blurRadius: 6.0,
                          offset: Offset(0.0, 0.1))
                    ]),
                    child: const Text(
                      'QUANTITY',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                  // SizedBox(
                  //   height: screenSize.height * 0.01,
                  // ),
                  // Divider(),
                  SizedBox(
                    height: screenSize.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              count--;
                            });
                          },
                          icon: const Icon(
                            Icons.minimize,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: VerticalDivider(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '$count',
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 30),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: VerticalDivider(
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              count++;
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: screenSize.width,
              margin: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.01,
                // horizontal: screenSize.width * 0.01
              ),
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.01,
                  horizontal: screenSize.width * 0.03),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 203, 202, 202),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 0.1))
              ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Divider(),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  const Text(
                    'NOTES',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  const Divider(),
                  // SizedBox(
                  //   height: screenSize.height * 0.01,
                  // ),
                  TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 2,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: 'Add a note',
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          // fontSize: 18,
                          // fontWeight: FontWeight.w600
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.01),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                  // const Text(
                  //   'Add a note',
                  // style: TextStyle(
                  //   color: Colors.black,
                  //   // fontSize: 18,
                  //   // fontWeight: FontWeight.w600
                  // ),
                  // ),
                  // SizedBox(
                  //   height: screenSize.height * 0.01,
                  // ),
                ],
              ),
            ),
            Container(
              width: screenSize.width,
              margin: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.01,
                // horizontal: screenSize.width * 0.01
              ),
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.01,
                  horizontal: screenSize.width * 0.03),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 203, 202, 202),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 0.1))
              ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Divider(),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  const Text(
                    'TAXES',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  const Divider(),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/tax', arguments: {
                        "tax": '',
                      });
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select',
                          style: TextStyle(
                            color: Colors.black,
                            // fontSize: 18,
                            // fontWeight: FontWeight.w600
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  const Divider(),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  const Text(
                    'DISCOUNT',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  const Divider(),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/discount');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select',
                          style: TextStyle(
                            color: Colors.black,
                            // fontSize: 18,
                            // fontWeight: FontWeight.w600
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.1,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: screenSize.height * 0.07,
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(255, 31, 1, 102),
        ),
        child: Row(
          children: [
            const Expanded(
              // width: screenSize.width * 0.1,
              child: ListTile(
                title: Text(
                  'Total Value',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                subtitle: Text(
                  '0.00',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const VerticalDivider(),
            Expanded(
              // width: screenSize.width * 0.1,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        "Enter name to save the custom amount",
                        style: TextStyle(),
                      )));
                 
                              Navigator.pushNamed(context, '/emi', arguments: { "addContent": '',
                                "customAmount": 'true',});
                },
                child: const ListTile(
                    title: Text(
                      'Select',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    minLeadingWidth: 0.0,
                    trailing: Icon(
                      Icons.arrow_circle_right,
                      color: Colors.white,
                      size: 27,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
