// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
      late Map<String, dynamic> argus;
  ProductDetailScreen({super.key, required this.argus});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<Map<String, dynamic>> options = [
    {'text': '\u{20B9} ${259}', 'isChecked': false},
    {'text': '\u{20B9} ${0}', 'isChecked': false},
  ];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
             Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/emi');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vsvsvsv',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 23),
            ),
            Text(
              'Ddfg',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Color.fromARGB(255, 203, 202, 202),
                  //       blurRadius: 6.0,
                  //       offset: Offset(0.0, 0.1))
                  // ]
                ),
                child: const ListTile(
                  title: Text(
                    'vvsvsvs',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    'CHOOSE ONE',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
              ),

              ...options.map((option) {
                return Container(
                  margin:
                      EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 203, 202, 202),
                        blurRadius: 6.0,
                        offset: Offset(0.0, 0.1))
                  ]),
                  child: CheckboxListTile(
                    selectedTileColor: Colors.green,
                    secondary: const Text(
                      'Regular',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    title: Text(
                      option['text'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: option['isChecked']
                            ? FontWeight.w600
                            : FontWeight.normal,
                        fontSize: option['isChecked'] ? 17 : 15,
                      ),
                    ),
                    value: option['isChecked'],
                    onChanged: (bool? value) {
                      setState(() {
                        option['isChecked'] = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                  ),
                );
              }),
              // const Divider(),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Container(
                width: screenSize.width,
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
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
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              // const Divider(),
              Container(
                width: screenSize.width,
                margin: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.01,
                  // horizontal: screenSize.width * 0.05
                ),
                padding: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.01,
                    horizontal: screenSize.width * 0.05),
                // height: screenSize.height * 0.05,
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 203, 202, 202),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 0.1))
                ]),
                child: SizedBox(
                  height: screenSize.height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            count--;
                          });
                        },
                        child: const Icon(
                          Icons.minimize,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.grey,
                      ),
                      Text(
                        '$count',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 30),
                      ),
                      const VerticalDivider(
                        color: Colors.grey,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            count++;
                          });
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: screenSize.width,
                margin: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.01,
                    horizontal: screenSize.width * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.01,
                    horizontal: screenSize.width * 0.03),
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
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
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     // fontSize: 18,
                    //     // fontWeight: FontWeight.w600
                    //   ),
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
                    horizontal: screenSize.width * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.01,
                    horizontal: screenSize.width * 0.03),
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
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
                        Navigator.pushNamed(
                            context,
                            '/tax');
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Svvs',
                          style: TextStyle(
                            color: Colors.black,
                            // fontSize: 18,
                            // fontWeight: FontWeight.w600
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\u{20B9} ${25}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
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
      ),
      floatingActionButton: Container(
        height: screenSize.height * 0.07,
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(255, 31, 1, 102),
        ),
        child: const Row(
          children: [
            Expanded(
              // width: screenSize.width * 0.1,
              child: ListTile(
                title: Text(
                  'Total Value',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                subtitle: Text(
                  '229.00',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            VerticalDivider(),
            Expanded(
              // width: screenSize.width * 0.1,
              child: ListTile(
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
          ],
        ),
      ),
    );
  }
}
