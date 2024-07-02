// ignore_for_file: must_be_immutable, use_build_context_synchronously, avoid_print

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_bloc.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_event.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_state.dart';
import 'package:dkapp/module/customers/model/customer_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ProfileScreen({super.key, required this.argus});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  CustomerResponseData? selectedCustomerResponseData;
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  late TabController tabController;
  int tabIndex = 0;
  List<Map<String, dynamic>> movecertButtonList = [
    {"id": "1", "title": "Add to Contacts"},
    {"id": "2", "title": "Edit Customer"},
    {"id": "3", "title": "Enable DND"},
    {"id": "4", "title": "Delete Customer"},
    {"id": "5", "title": "Show Remainder"},
    {"id": "6", "title": "Reports"}
  ];
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
    fetchSelectedCustomerData();
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

  fetchSelectedCustomerData() {
    BlocProvider.of<CustomerBloc>(context).add(SelectedCustomerFetchEvent(
        userId: sph.getString("userid")!,
        customerId: (widget
                .argus['customerData'] is SelectedCustomerResponseData)
            ? ((widget.argus['customerData'] as SelectedCustomerResponseData)
                .id!)
            : (widget.argus['customerData'] as CustomerResponseData).id!,
        businessId:
            (widget.argus['selectedBusiness'] as BusinessListResponseData)
                .id!));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        if (state is SelectedCustomerDetailsLoadedState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              iconTheme: const IconThemeData(color: Colors.white),
              title: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/customer-screen-full-details',
                      arguments: {
                        'customerData': state.selectedCustomerDetailedData,
                        'selectedBusiness': (widget.argus['selectedBusiness']
                                      as BusinessListResponseData)
                      });
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
                title: Text(
                  state.selectedCustomerDetailedData.fullname!,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
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
                // IconButton(
                //     onPressed: () {

                //     },
                //     icon: const Icon(
                //       Icons.more_vert,
                //       color: Colors.white,
                //     )),
                PopupMenuButton<Map<String, dynamic>>(
                  elevation: 20,
                  color: Colors.black,
                  onSelected: (value) {
                    // Handle the selection
                    switch (value['id']) {
                      case '1':
                        _addtoContactForm(
                            context, state.selectedCustomerDetailedData);
                      case '2':
                        print('Edit Form');

                        Navigator.pushNamed(context, '/edit-customer-screen',
                            arguments: {
                              "customerData":
                                  state.selectedCustomerDetailedData,
                              "selectedBusiness":
                                  (widget.argus['selectedBusiness']
                                      as BusinessListResponseData)
                            });
                        break;
                      case '3':
                        print('Enable DND');
                        break;
                      case '4':
                        print('Delete Customer');
                        _deleteCustomer(
                            context, state.selectedCustomerDetailedData);
                        break;
                      case '5':
                        print('Show Remainders');
                        break;
                      case '6':
                        print('Reports');
                        break;
                    }
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  itemBuilder: (context) => movecertButtonList
                      .map<PopupMenuEntry<Map<String, dynamic>>>(
                          (c) => PopupMenuItem(
                              value: c,
                              child: Text(
                                c['title'],
                                style: const TextStyle(color: Colors.white),
                              )))
                      .toList(),
                )
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.height / 1.2,
                    width: screenSize.width,
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
                            controller: tabController,
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
                                      crossAxisSpacing:
                                          screenSize.width * 0.003,
                                      mainAxisSpacing:
                                          screenSize.height * 0.006,
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                  vertical:
                                                                      10.0),
                                                          child: Text(
                                                            'Settle',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical: 10.0),
                                                        child: Text(
                                                          'Write Off',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                                    BorderRadius.circular(
                                                        10.0)),
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
                                                    BorderRadius.circular(
                                                        10.0)),
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
                                                    BorderRadius.circular(
                                                        10.0)),
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
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons
                                                      .chat_bubble_fill,
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
                                            side:
                                                BorderSide(color: Colors.white),
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
                                              vertical:
                                                  screenSize.height * 0.1),
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
                                        context, '/upi-payment');
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
                                            context, '/upi-payment');
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Text(
                                          'Invoice',
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
                            backgroundColor:
                                const Color.fromARGB(255, 31, 1, 102),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                context, '/upi-payment');
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
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
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          child: Text(
                                            'EMI',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          child: Text(
                                            'EMI',
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
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 50,
                            ))
                        : (tabIndex == 4)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
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
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          minimumSize: Size(
                                              screenSize.width * 0.4,
                                              screenSize.height * 0.06),
                                          backgroundColor: const Color.fromARGB(
                                              255, 31, 1, 102),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          'Add Cash In',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          minimumSize: Size(
                                              screenSize.width * 0.4,
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
          );
        }
        return const Center(
          child: AnimatedImageLoader(),
        );
      },
    );
  }

  _addtoContactForm(
      BuildContext context, SelectedCustomerResponseData customerData) async {
    // Add the contact
    try {
      print("saving Conatct");
      PermissionStatus permission = await Permission.contacts.status;

      if (permission != PermissionStatus.granted) {
        await Permission.contacts.request();
        PermissionStatus permission = await Permission.contacts.status;

        if (permission == PermissionStatus.granted) {
          EssentialWidgetsCollection.showAlertDialog(
            context,
            title: TextButton(
                onPressed: () async {
                  Contact newContact = Contact();
                  newContact.givenName = customerData.fullname;
                  newContact.emails = [
                    Item(label: "email", value: customerData.email)
                  ];

                  newContact.phones = [
                    Item(label: "mobile", value: customerData.mobile)
                  ];
                  newContact.company = (widget.argus['selectedBusiness']
                          as BusinessListResponseData)
                      .bName!;
                  newContact.postalAddresses = [
                    PostalAddress(region: customerData.address)
                  ];

                  ContactsService.addContact(newContact).then((c) {
                    Navigator.pop(context);
                    EssentialWidgetsCollection.showSuccessSnackbar(
                        context, "Contact added successfully");
                  }).onError(
                    (error, stackTrace) {
                      Navigator.pop(context);
                      EssentialWidgetsCollection.showErrorSnackbar(
                          context, error.toString());
                    },
                  );
                },
                child: const Text("Create New Contact")),
            // content: TextButton(
            //     onPressed: () async {
            //      List<Contact> existedData = await ContactsService.getContactsForPhone(customerData.mobile);
            //     ContactsService.openExistingContact(existedData.first).then((c) {
            //       Navigator.pop(context);
            //       EssentialWidgetsCollection.showSuccessSnackbar(
            //           context, "Contact edited successfully");
            //     }).onError(
            //       (error, stackTrace) {
            //         Navigator.pop(context);
            //         EssentialWidgetsCollection.showErrorSnackbar(
            //             context, error.toString());
            //       },
            //     );
            //     },
            //     child: const Text("Open Existing Contact")),
          );
        }
      } else {
        EssentialWidgetsCollection.showAlertDialog(
          context,
          title: TextButton(
              onPressed: () async {
                Contact newContact = Contact();
                newContact.givenName = customerData.fullname;
                newContact.emails = [
                  Item(label: "email", value: customerData.email)
                ];

                newContact.phones = [
                  Item(label: "mobile", value: customerData.mobile)
                ];
                newContact.company = (widget.argus['selectedBusiness']
                        as BusinessListResponseData)
                    .bName!;
                newContact.postalAddresses = [
                  PostalAddress(region: customerData.address)
                ];
                ContactsService.addContact(newContact).then((c) {
                  Navigator.pop(context);
                  EssentialWidgetsCollection.showSuccessSnackbar(
                      context, "Contact added successfully");
                }).onError(
                  (error, stackTrace) {
                    Navigator.pop(context);
                    EssentialWidgetsCollection.showErrorSnackbar(
                        context, error.toString());
                  },
                );
              },
              child: const Text("Create New Contact")),
          // content: TextButton(
          //     onPressed: () async {
          //       List<Contact> existedData = await ContactsService.getContactsForPhone(customerData.mobile);
          //       ContactsService.openExistingContact(existedData.first).then((c) {
          //         Navigator.pop(context);
          //         EssentialWidgetsCollection.showSuccessSnackbar(
          //             context, "Contact edited successfully");
          //       }).onError(
          //         (error, stackTrace) {
          //           Navigator.pop(context);
          //           EssentialWidgetsCollection.showErrorSnackbar(
          //               context, error.toString());
          //         },
          //       );
          //     },
          //     child: const Text("Open Existing Contact")),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  _deleteCustomer(BuildContext context,
      SelectedCustomerResponseData selectedCustomerDetailedData) {
    BlocProvider.of<CustomerBloc>(context).add(CustomerDeleteEvent(
        customerId: selectedCustomerDetailedData.id!,
        userId: sph.getString("userid")!,
        businessId:
            (widget.argus['selectedBusiness'] as BusinessListResponseData)
                .id!));
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/dashboard',
        arguments: widget.argus);
  }
}
