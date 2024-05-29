// ignore_for_file: must_be_immutable

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ProfileScreen({super.key, required this.argus});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 0;
// Option 2
  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
    changeName(tabController.index);
    tabController.addListener(() {
      changeName(tabController.index);
    });
    tabController.addListener(() {
      if (kDebugMode) {
        print('my index is${tabController.index}');
      }
    });
    super.initState();
  }

  void changeName(int index) {
    if (index == 0) {
      setState(() {
        tabIndex = index;
      });
    } else if (index == 1) {
      setState(() {
        tabIndex = index;
      });
    } else if (index == 2) {
      setState(() {
        tabIndex = index;
      });
    } else if (index == 3) {
      setState(() {
        tabIndex = index;
      });
    } else if (index == 4) {
      setState(() {
        tabIndex = index;
      });
    }
  }

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
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          leadingWidth: 20.0,
          title: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
            title: const Text(
              'john',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            subtitle: const Text(
              '\u{20B9} ${0}',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call_rounded,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height / 1.2,
                width: screenSize.width,
                child: DefaultTabController(
                  length: 6,
                  child: Column(
                    children: <Widget>[
                      ButtonsTabBar(
                        // onTap: (index) {
                        //   print(tabController.index);
                        //   print(index);
                        //   if (tabController.index == index) {
                        //     print('Same Tab Clicked');
                        //   }
                        // },
                        controller: tabController,

                        labelSpacing: 0.0,
                        height: screenSize.height * 0.08,
                        buttonMargin: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        radius: 0,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10.0),
                        // Customize the appearance and behavior of the tab bar
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 31, 1, 102),
                            borderRadius: BorderRadius.circular(0)),

                        // borderWidth: 2,
                        // borderColor: Colors.black,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        // Add your tabs here
                        tabs: const [
                          Tab(
                            text: 'Transactions',
                          ),
                          Tab(
                            text: 'Recuring/EMI',
                          ),
                          Tab(
                            text: 'Invoices',
                          ),
                          Tab(
                            text: 'Files',
                          ),
                          Tab(
                            text: 'Notes',
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            //tab 1: Transcations
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  GridView.count(
                                    shrinkWrap: true,
                                    childAspectRatio: (1 / .7),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 4, // Changed from 2 to 1
                                    crossAxisSpacing: screenSize.width * 0.003,
                                    mainAxisSpacing: screenSize.height * 0.006,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            backgroundColor: Colors.white,
                                            scrollControlDisabledMaxHeightRatio:
                                                0.2,
                                            showDragHandle: true,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                width: screenSize.width,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          screenSize.height *
                                                              0.03,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/upi-payment');
                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical: 10.0),
                                                        child: Text(
                                                          'Settle',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20.0,
                                                              vertical: 10.0),
                                                      child: Text(
                                                        'Write Off',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 203, 202, 202),
                                                  offset: Offset(0.0, 1.0),
                                                  blurRadius: 6.0,
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.green,
                                                size: 35,
                                              ),
                                              Text(
                                                'Settle',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 203, 202, 202),
                                                  offset: Offset(0.0, 1.0),
                                                  blurRadius: 6.0,
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.remember_me,
                                                color: Colors.brown,
                                                size: 30,
                                              ),
                                              Text(
                                                'Remind',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 203, 202, 202),
                                                  offset: Offset(0.0, 1.0),
                                                  blurRadius: 6.0,
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CupertinoIcons
                                                    .phone_circle_fill,
                                                color: Colors.green,
                                                size: 30,
                                              ),
                                              Text(
                                                'Remind',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 203, 202, 202),
                                                  offset: Offset(0.0, 1.0),
                                                  blurRadius: 6.0,
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CupertinoIcons.chat_bubble_fill,
                                                color: Colors.blue,
                                                size: 30,
                                              ),
                                              Text(
                                                'Automatic',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Add more containers here if needed
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.05,
                                        vertical: screenSize.height * 0.03),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 203, 202, 202),
                                          offset: Offset(0.0, 1.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: const ExpansionTile(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      title: Text(
                                        'Set Payment Reminder',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      children: [
                                        ListTile(
                                          title: Text(
                                            'Payment of Due Cycle',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          subtitle: Text(
                                            'Set a due date for this account',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 92, 92, 92),
                                                fontSize: 12),
                                          ),
                                          trailing: Text(
                                            'SET',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 15),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'Overdue Remider Cycle',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          subtitle: Text(
                                            'How to frequently you want to remind the customer ',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 92, 92, 92),
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.1,
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
                                    height: screenSize.height * 0.25,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceAround,
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.center,
                                  //   children: [
                                  //     TextButton(
                                  //         style: TextButton.styleFrom(
                                  //           minimumSize: Size(
                                  //               screenSize.width * 0.45,
                                  //               screenSize.height * 0.06),
                                  //           backgroundColor:
                                  //               const Color.fromARGB(
                                  //                   255, 31, 1, 102),
                                  //         ),
                                  //         onPressed: () {},
                                  //         child: const Text(
                                  //           'Add Cash In',
                                  //           style:
                                  //               TextStyle(color: Colors.white),
                                  //         )),
                                  //     TextButton(
                                  //         style: TextButton.styleFrom(
                                  //           minimumSize: Size(
                                  //               screenSize.width * 0.45,
                                  //               screenSize.height * 0.06),
                                  //           backgroundColor: Colors.red,
                                  //         ),
                                  //         onPressed: () {},
                                  //         child: const Text(
                                  //           'Add Cash Out',
                                  //           style:
                                  //               TextStyle(color: Colors.white),
                                  //         ))
                                  //   ],
                                  // ),
                                ],
                              ),
                            )
                            //tab 2: recurring/emi
                            ,
                            Container(
                              color: Colors.white,
                              height: screenSize.height,
                              // width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Center(
                                    // color: Colors.grey,
                                    child: Icon(
                                      Icons.receipt_long_sharp,
                                      size: 100,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                      // color: Colors.grey,
                                      child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.1),
                                    child: const Text(
                                      'You can now automatically enter monthly        or weekly repeating transactions',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            //  tab 3: Invoices

                            Container(
                              color: Colors.white,
                              height: screenSize.height,
                              // width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Center(
                                    // color: Colors.grey,
                                    child: Icon(
                                      Icons.receipt_long_sharp,
                                      size: 100,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                      // color: Colors.grey,
                                      child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.1),
                                    child: const Text(
                                      'No Data',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            // tab 4: Files

                            Container(
                              color: Colors.white,
                              height: screenSize.height,
                              // width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Center(
                                    // color: Colors.grey,
                                    child: Icon(
                                      Icons.receipt_long_sharp,
                                      size: 100,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                      // color: Colors.grey,
                                      child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.1),
                                    child: const Text(
                                      'Upload important documents related to this account here and easily find them at one place',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            // tab 5: Notes

                            Container(
                              color: const Color.fromARGB(255, 211, 231, 248),
                              // height: screenSize.height / 1.5,
                              // width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Center(
                                    // color: Colors.grey,
                                    child: Icon(
                                      Icons.receipt_long_sharp,
                                      size: 100,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: screenSize.height * 0.2,
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: screenSize.height * 0.1),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            hintText: 'Type a private note',
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                          ),
                                        ),
                                      )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(null))
                                    ],
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
              ),
              //   Container(
              //     margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              //     decoration: const BoxDecoration(
              //       color: Colors.white,
              //       boxShadow: [
              //         BoxShadow(
              //           color: Color.fromARGB(255, 203, 202, 202),
              //           offset: Offset(0.0, 1.0),
              //           blurRadius: 6.0,
              //         ),
              //       ],
              //     ),
              //     child: const ExpansionTile(
              //       backgroundColor: Colors.white,
              //       shape: RoundedRectangleBorder(
              //           side: BorderSide(color: Colors.white),
              //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //       title: Text(
              //         'Set Payment Reminder',
              //         style: TextStyle(color: Colors.green),
              //       ),
              //       children: [
              //         ListTile(
              //           title: Text(
              //             'Payment of Due Cycle',
              //             style: TextStyle(color: Colors.black, fontSize: 15),
              //           ),
              //           subtitle: Text(
              //             'Set a due date for this account',
              //             style: TextStyle(
              //                 color: Color.fromARGB(255, 92, 92, 92), fontSize: 12),
              //           ),
              //           trailing: Text(
              //             'SET',
              //             style: TextStyle(color: Colors.green, fontSize: 15),
              //           ),
              //         ),
              //         ListTile(
              //           title: Text(
              //             'Overdue Remider Cycle',
              //             style: TextStyle(color: Colors.black, fontSize: 15),
              //           ),
              //           subtitle: Text(
              //             'How to frequently you want to remind the customer ',
              //             style: TextStyle(
              //                 color: Color.fromARGB(255, 92, 92, 92), fontSize: 12),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              //   SizedBox(
              //     height: screenSize.height * 0.1,
              //   ),
              //   const Center(
              //     child: CircleAvatar(
              //       radius: 50,
              //       backgroundColor: Color.fromARGB(255, 230, 223, 246),
              //       child: Icon(
              //         CupertinoIcons.search_circle_fill,
              //         size: 60,
              //         color: Colors.brown,
              //       ),
              //     ),
              //   ),
              //   SizedBox(
              //     height: screenSize.height * 0.2,
              //   ),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       TextButton(
              //           style: TextButton.styleFrom(
              //             minimumSize: Size(
              //                 screenSize.width * 0.45, screenSize.height * 0.06),
              //             backgroundColor: const Color.fromARGB(255, 31, 1, 102),
              //           ),
              //           onPressed: () {},
              //           child: const Text(
              //             'Add Cash In',
              //             style: TextStyle(color: Colors.white),
              //           )),
              //       TextButton(
              //           style: TextButton.styleFrom(
              //             minimumSize: Size(
              //                 screenSize.width * 0.45, screenSize.height * 0.06),
              //             backgroundColor: Colors.red,
              //           ),
              //           onPressed: () {},
              //           child: const Text(
              //             'Add Cash Out',
              //             style: TextStyle(color: Colors.white),
              //           ))
              //     ],
              //   )
            ],
          ),
        ),
        floatingActionButton: (tabIndex == 1)
            ? FloatingActionButton.large(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                backgroundColor: const Color.fromARGB(255, 31, 1, 102),
                onPressed: () {
                  showModalBottomSheet<void>(
                    backgroundColor: Colors.white,
                    scrollControlDisabledMaxHeightRatio: 0.3,
                    showDragHandle: true,
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        width: screenSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   width: screenSize.width,
                            //   decoration: const BoxDecoration(),
                            //   child: const Center(
                            //     child: Text(
                            //       'Payment Providers',
                            //       style: TextStyle(
                            //           color: Colors.black,
                            //           fontSize: 23,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: screenSize.height * 0.03,
                            ),
                            InkWell(
                              onTap: () {
                                 Navigator.pushNamed(
                                                            context,
                                                            '/upi-payment');
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  'Recurring Transaction',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Text(
                                'Recurring Invoice',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Text(
                                'Recurring Bill',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Text(
                                'EMI',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 50,
                ))
            : (tabIndex == 2)
                ? FloatingActionButton.large(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    backgroundColor: const Color.fromARGB(255, 31, 1, 102),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        backgroundColor: Colors.white,
                        scrollControlDisabledMaxHeightRatio: 0.2,
                        showDragHandle: true,
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: screenSize.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: screenSize.height * 0.03,
                                ),
                                InkWell(
                                  onTap: () {
                                     Navigator.pushNamed(
                                                            context,
                                                            '/upi-payment');
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    child: Text(
                                      'Invoice',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Text(
                                    'Bill',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 50,
                    ))
                : (tabIndex == 3)
                    ? FloatingActionButton.large(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        backgroundColor: const Color.fromARGB(255, 31, 1, 102),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.white,
                            scrollControlDisabledMaxHeightRatio: 0.3,
                            showDragHandle: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                width: screenSize.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   width: screenSize.width,
                                    //   decoration: const BoxDecoration(),
                                    //   child: const Center(
                                    //     child: Text(
                                    //       'Payment Providers',
                                    //       style: TextStyle(
                                    //           color: Colors.black,
                                    //           fontSize: 23,
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: screenSize.height * 0.03,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                                            context,
                                                            '/upi-payment');
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Text(
                                          'Recurring Transaction',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),

                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      child: Text(
                                        'EMI',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      child: Text(
                                        'EMI',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      child: Text(
                                        'EMI',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 50,
                        ))
                    : (tabIndex == 4)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.04,
                                ),
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.04,
                                  ),
                                  elevation: 10.0,
                                  color: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  shadowColor: Colors.white,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      fillColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      filled: true,
                                      hintText: 'Type a private note',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                  ),
                                ),
                              )),
                              // SizedBox(
                              //   width: screenSize.width * 0.04,
                              // ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: IconButton(
                                    style: IconButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size(screenSize.width * 0.4,
                                          screenSize.height * 0.06),
                                      backgroundColor:
                                          const Color.fromARGB(255, 31, 1, 102),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Add Cash In',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size(screenSize.width * 0.4,
                                          screenSize.height * 0.06),
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Add Cash Out',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                          ),
      ),
    );
  }
}
