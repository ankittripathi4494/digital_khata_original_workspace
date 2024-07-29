// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SelectCustomerScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  SelectCustomerScreen({super.key, required this.argus});

  @override
  State<SelectCustomerScreen> createState() => _SelectCustomerScreenState();
}

class _SelectCustomerScreenState extends State<SelectCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Select Customer',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {},
              icon: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/invoice');
                },
              )),
        ),
        body: Container(
           decoration: BoxDecoration(color: Colors.grey[100]),
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04,
                    vertical: screenSize.height * 0.01),
                elevation: 2.0,
                color: Colors.white,
                surfaceTintColor: Colors.white,
                child: TextFormField(
                  style: const TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                  ),
                  cursorColor: const Color.fromARGB(255, 31, 1, 102),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 69, 69, 69),
                        size: 30.0,
                      ),
                      hintText: 'Search Customer here',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 143, 141, 141),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 31, 1, 102),
                          ),
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.008,
                          horizontal: screenSize.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 203, 202, 202),
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const ProfileScreen()));
                        },
                        child: ListTile(
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
                                '\u{20B9} ${0}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'CREDIT',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 30, 29, 29),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0),
          ),
          onPressed: () {
            showModalBottomSheet<void>(
              backgroundColor: Colors.white,
              scrollControlDisabledMaxHeightRatio: 0.5,
              showDragHandle: true,
              context: context,
              builder: (BuildContext context) {
                return PopScope(
                  canPop: false,
                  child: SizedBox(
                    width: screenSize.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person_add,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.02,
                              ),
                              const Text(
                                'Add Customer',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.05),
                          child: const Divider(),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.03,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Customer Name',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.05),
                          child: TextFormField(
                            cursorColor: const Color.fromARGB(255, 31, 1, 102),
                            decoration: InputDecoration(
                              hintText: 'Customer Name ',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            'Mobile Numbeer',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.05),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            cursorColor: const Color.fromARGB(255, 31, 1, 102),
                            decoration: InputDecoration(
                              hintText: 'Mobile number',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero),
                                      minimumSize: Size(screenSize.width * 0.4,
                                          screenSize.height * 0.05)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('CANCEL')),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero),
                                      backgroundColor:
                                          const Color.fromARGB(255, 31, 1, 102),
                                      minimumSize: Size(screenSize.width * 0.4,
                                          screenSize.height * 0.05)),
                                  onPressed: () {},
                                  child: const Text(
                                    'SAVE',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          
          },
          child: const Icon(
            Icons.person_add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
