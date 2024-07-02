// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ServiceDetailScreen({super.key, required this.argus});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  List<Map<String, dynamic>> options = [
    {'text': '\u{20B9} ${2580}', 'isChecked': false},
    {'text': '\u{20B9} ${2580}', 'isChecked': false},
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
              Navigator.pushReplacementNamed(context, '/emi', arguments: {
                "customAmount": '',
                "addContent": '',
              });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Service Name',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 23),
            ),
            Text(
              'Ddfg',
              style: TextStyle(color: Colors.grey[400], fontSize: 15),
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
                    'Service Name',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
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
                      fontSize: 18),
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
                            color: Color.fromARGB(255, 31, 1, 102),
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
                          hintText: 'Add a note',
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
                        Navigator.pushNamed(context, '/tax', arguments: {
                          "tax": '',
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (widget.argus["tax"] == 'true')
                              ? const Text(
                                  'fhk',
                                  style: TextStyle(
                                    color: Colors.black,
                                    // fontSize: 18,
                                    // fontWeight: FontWeight.w600
                                  ),
                                )
                              : const Text(
                                  'Select',
                                  style: TextStyle(
                                    color: Colors.black,
                                    // fontSize: 18,
                                    // fontWeight: FontWeight.w600
                                  ),
                                ),
                          Row(
                            children: [
                              (widget.argus["tax"] == 'true')
                                  ? const Text(
                                      '\u{20B9} ${75.60}%',
                                      style: TextStyle(
                                        color: Colors.black,
                                        // fontSize: 18,
                                        // fontWeight: FontWeight.w600
                                      ),
                                    )
                                  : const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                    ),
                            ],
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (widget.argus["percent"] == 'true')
                              ? const Text(
                                  'Cshik',
                                  style: TextStyle(
                                    color: Colors.black,
                                    // fontSize: 18,
                                    // fontWeight: FontWeight.w600
                                  ),
                                )
                              : (widget.argus["ruppees"] == 'true')
                                  ? const Text(
                                      'Vsvsvv',
                                      style: TextStyle(
                                        color: Colors.black,
                                        // fontSize: 18,
                                        // fontWeight: FontWeight.w600
                                      ),
                                    )
                                  : const Text(
                                      'Select',
                                      style: TextStyle(
                                        color: Colors.black,
                                        // fontSize: 18,
                                        // fontWeight: FontWeight.w600
                                      ),
                                    ),
                          (widget.argus["percent"] == 'true')
                              ? (const Text(
                                  '\u{20B9} ${75.6}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    // fontSize: 18,
                                    // fontWeight: FontWeight.w600
                                  ),
                                ))
                              : (widget.argus["ruppees"] == 'true')
                                  ? const Text(
                                      '\u{20B9} ${75}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        // fontSize: 18,
                                        // fontWeight: FontWeight.w600
                                      ),
                                    )
                                  : const Icon(
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
                  '229.00',
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
                  Navigator.pushNamed(context, '/emi', arguments: {
                    "customAmount": '',
                    "addContent": 'true',
                  });
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
