// ignore_for_file: must_be_immutable

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:dkapp/global_widget/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_chips_input/select_chips_input.dart';

import '../dashboard/screens/dashboard_screen.dart';

class InVoiceScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  InVoiceScreen({super.key, required this.argus});

  @override
  State<InVoiceScreen> createState() => _InVoiceScreenState();
}

class _InVoiceScreenState extends State<InVoiceScreen>
    with TickerProviderStateMixin {
  String outputSelectChipsInput = '';
  bool isData = true;
  late TabController tabController;
  int tabIndex = 0;
    late int currentPageIndexValue = 1;
// Option 2
  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // int currentIndex = 0;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Container(),
          leadingWidth: 0.0,
          title: const Text(
            'Collections',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    query: '',
                    delegate: SearchBarDelegate(),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                )),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height / 1.2,
                  width: screenSize.width,
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        ButtonsTabBar(
                          controller: tabController,
                          height: 60.0,
                          radius: 10,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 75, vertical: 10.0),
                          // Customize the appearance and behavior of the tab bar
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 31, 1, 102),
                              borderRadius: BorderRadius.circular(10)),
                          labelStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          unselectedLabelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          // Add your tabs here
                          tabs: const [
                            Tab(
                              text: 'Invoice',
                            ),
                            Tab(
                              text: 'Recurring',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              //tab 1: Invoice
                              (tabIndex == 0)
                                  ? Container(
                                      height: screenSize.height,
                                      color: Colors.grey[100],
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      screenSize.width * 0.35),
                                              child: const Text(
                                                'Sort & Filter',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            title: IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet<void>(
                                                    backgroundColor:
                                                        Colors.white,
                                                    scrollControlDisabledMaxHeightRatio:
                                                        0.3,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ListTile(
                                                            leading: const Icon(
                                                              Icons.sort,
                                                              size: 30,
                                                              weight: 50,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      50,
                                                                      49,
                                                                      49),
                                                            ),
                                                            title: const Text(
                                                              'Sort By',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          49,
                                                                          49),
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            trailing:
                                                                TextButton.icon(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon: const Icon(
                                                                Icons.close,
                                                                size: 30,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              label: const Text(
                                                                'clear',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ),
                                                          Divider(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          SelectChipsInput(
                                                            marginBetweenChips:
                                                                EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        screenSize.width *
                                                                            0.09,
                                                                    vertical: screenSize
                                                                            .height *
                                                                        0.001),
                                                            paddingInsideChipContainer:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        12.0,
                                                                    horizontal:
                                                                        16.0),
                                                            chipsText: const [
                                                              'AMOUNT',
                                                              'NAME'
                                                            ],
                                                            separatorCharacter:
                                                                ";",
                                                            selectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                            unselectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                            ),
                                                            onTap: (p0, p1) {
                                                              setState(() {
                                                                outputSelectChipsInput =
                                                                    p0;
                                                              });
                                                            },
                                                            prefixIcons: const [
                                                              Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                size: 25.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                size: 25.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ],
                                                            selectedPrefixIcon:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          5.0),
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_drop_up_outlined,
                                                                size: 25.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            widgetContainerDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  249,
                                                                  248,
                                                                  248),
                                                            ),
                                                            unselectedChipDecoration:
                                                                BoxDecoration(
                                                              // color: Colors.green,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 1.8),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                            selectedChipDecoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                          ),
                                                          SelectChipsInput(
                                                            marginBetweenChips:
                                                                EdgeInsets
                                                                    .symmetric(
                                                              horizontal:
                                                                  screenSize
                                                                          .width *
                                                                      0.1,
                                                            ),
                                                            paddingInsideChipContainer:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        12.0,
                                                                    horizontal:
                                                                        12.0),
                                                            chipsText: const [
                                                              'RECENT',
                                                              'DUE DATE'
                                                            ],
                                                            separatorCharacter:
                                                                ";",
                                                            selectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                            unselectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                            ),
                                                            onTap: (p0, p1) {
                                                              setState(() {
                                                                outputSelectChipsInput =
                                                                    p0;
                                                              });
                                                            },
                                                            prefixIcons: const [
                                                              Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                size: 25.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                size: 25.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ],
                                                            selectedPrefixIcon:
                                                                const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          5.0),
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_drop_up_outlined,
                                                                size: 25.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            widgetContainerDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  249,
                                                                  248,
                                                                  248),
                                                            ),
                                                            unselectedChipDecoration:
                                                                BoxDecoration(
                                                              // color: Colors.green,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 1.8),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                            selectedChipDecoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.sort,
                                                  color: Color.fromARGB(
                                                      255, 50, 49, 49),
                                                )),
                                            trailing: IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet<void>(
                                                    backgroundColor:
                                                        Colors.white,
                                                    scrollControlDisabledMaxHeightRatio:
                                                        0.2,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const ListTile(
                                                            leading: Icon(
                                                              Icons.sort,
                                                              size: 30,
                                                              weight: 50,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      50,
                                                                      49,
                                                                      49),
                                                            ),
                                                            title: Text(
                                                              'Filter',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          49,
                                                                          49),
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            // trailing: TextButton.icon(
                                                            //   onPressed: () {
                                                            //     Navigator.pop(context);
                                                            //   },
                                                            //   icon: const Icon(
                                                            //     Icons.close,
                                                            //     size: 30,
                                                            //     color: Colors.black,
                                                            //   ),
                                                            //   label: const Text(
                                                            //     'clear',
                                                            //     style: TextStyle(
                                                            //         color: Colors.black,
                                                            //         fontSize: 15),
                                                            //   ),
                                                            // ),
                                                          ),
                                                          Divider(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          SelectChipsInput(
                                                            marginBetweenChips:
                                                                EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        screenSize.width *
                                                                            0.05,
                                                                    vertical:
                                                                        screenSize.height *
                                                                            0.01),
                                                            paddingInsideChipContainer:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        12.0,
                                                                    horizontal:
                                                                        40.0),
                                                            chipsText: const [
                                                              'Invoice',
                                                              'Bill'
                                                            ],
                                                            separatorCharacter:
                                                                ";",
                                                            selectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                            unselectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                            ),
                                                            onTap: (p0, p1) {
                                                              setState(() {
                                                                outputSelectChipsInput =
                                                                    p0;
                                                              });
                                                            },
                                                            widgetContainerDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  249,
                                                                  248,
                                                                  248),
                                                            ),
                                                            unselectedChipDecoration:
                                                                BoxDecoration(
                                                              // color: Colors.green,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 1.8),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                            selectedChipDecoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  CupertinoIcons
                                                      .text_alignright,
                                                  color: Color.fromARGB(
                                                      255, 50, 49, 49),
                                                )),
                                          ),
                                          Expanded(
                                            child: DefaultTabController(
                                              length: 3,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                Colors.white),
                                                    child: ButtonsTabBar(
                                                      height: 60.0,
                                                      // labelSpacing: 0.0,
                                                      // buttonMargin: const EdgeInsets.symmetric(vertical: 1.0),
                                                      radius: 0,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 40,
                                                              vertical: 8.0),
                                                      // Customize the appearance and behavior of the tab bar
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              227, 224, 234),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),

                                                      // borderWidth: 2,
                                                      // borderColor: Colors.black,
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),

                                                      unselectedLabelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                      unselectedBackgroundColor:
                                                          Colors.white,
                                                      // Add your tabs here
                                                      tabs: const [
                                                        Tab(
                                                          text:
                                                              '\u20B9 ${123890}\n Overdue',
                                                        ),
                                                        Tab(
                                                          text:
                                                              '\u20B9 ${123890}\n  Today',
                                                        ),
                                                        Tab(
                                                          text:
                                                              '   \u20B9 ${123890}\nUpcoming',
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TabBarView(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      children: [
                                                        //tab 1: container 1
                                                        isData == true
                                                            ? Container(
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .white),
                                                                // margin: EdgeInsets
                                                                //     .symmetric(
                                                                //         horizontal:
                                                                //             screenSize
                                                                //                     .width *
                                                                //                 0.04),
                                                                child:
                                                                    Container(
                                                                        decoration: const BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Color.fromARGB(255, 203, 202, 202),
                                                                                offset: Offset(0.0, 1.0),
                                                                                blurRadius: 6.0,
                                                                              ),
                                                                            ],
                                                                            color: Colors
                                                                                .white),
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: screenSize.width *
                                                                                0.05),
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal: screenSize.width *
                                                                                0.02,
                                                                            vertical: screenSize.height *
                                                                                0.02),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                              decoration: const BoxDecoration(boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Color.fromARGB(255, 203, 202, 202),
                                                                                  offset: Offset(0.0, 1.0),
                                                                                  blurRadius: 6.0,
                                                                                ),
                                                                              ], color: Colors.white),
                                                                              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01, horizontal: screenSize.width * 0.05),
                                                                              margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02, vertical: screenSize.height * 0.02),
                                                                              child: Column(
                                                                                children: [
                                                                                  const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        'Invoice #00001',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                      Text(
                                                                                        '\u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
                                                                                        '09-05-2024 Overdue by 13 days',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Unpaid',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
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
                                                                                        '- Ankit Singh',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Outst \u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  const Divider(),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.blue[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
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
                                                                                                      SizedBox(
                                                                                                        height: screenSize.height * 0.03,
                                                                                                      ),
                                                                                                      InkWell(
                                                                                                        onTap: () {
                                                                                                          // Navigator.push(
                                                                                                          //     context,
                                                                                                          //     MaterialPageRoute(
                                                                                                          //         builder: (context) =>
                                                                                                          //             const UpiPaymentScreen()));
                                                                                                        },
                                                                                                        child: const Padding(
                                                                                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                          child: Text(
                                                                                                            'Add Transaction',
                                                                                                            style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Write Off',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Link transaction',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          icon: const Icon(
                                                                                            Icons.check_circle,
                                                                                            color: Colors.blue,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Record Payment',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.green[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                                                                                          onPressed: () {},
                                                                                          icon: const Icon(
                                                                                            Icons.alarm,
                                                                                            color: Colors.green,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Send Reminder',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              decoration: const BoxDecoration(boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Color.fromARGB(255, 203, 202, 202),
                                                                                  offset: Offset(0.0, 1.0),
                                                                                  blurRadius: 6.0,
                                                                                ),
                                                                              ], color: Colors.white),
                                                                              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01, horizontal: screenSize.width * 0.05),
                                                                              margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02, vertical: screenSize.height * 0.02),
                                                                              child: Column(
                                                                                children: [
                                                                                  const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        'Bill #00001',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                      Text(
                                                                                        '\u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
                                                                                        '09-05-2024 Overdue by 13 days',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Unpaid',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
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
                                                                                        '- Ankit Singh',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Outst \u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  const Divider(),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.blue[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
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
                                                                                                      SizedBox(
                                                                                                        height: screenSize.height * 0.03,
                                                                                                      ),
                                                                                                      InkWell(
                                                                                                        onTap: () {
                                                                                                          // Navigator.push(
                                                                                                          //     context,
                                                                                                          //     MaterialPageRoute(
                                                                                                          //         builder: (context) =>
                                                                                                          //             const UpiPaymentScreen()));
                                                                                                        },
                                                                                                        child: const Padding(
                                                                                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                          child: Text(
                                                                                                            'Add Transaction',
                                                                                                            style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Write Off',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Link transaction',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          icon: const Icon(
                                                                                            Icons.check_circle,
                                                                                            color: Colors.blue,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Record Payment',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.green[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                                                                                          onPressed: () {},
                                                                                          icon: const Icon(
                                                                                            Icons.alarm,
                                                                                            color: Colors.green,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Send Reminder',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )),
                                                              )
                                                            : Container(
                                                                color: Colors
                                                                    .grey[100],
                                                                height:
                                                                    screenSize
                                                                        .height,
                                                                // width: 100,
                                                                child:
                                                                    const Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      // color: Colors.grey,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .receipt_long_sharp,
                                                                        size:
                                                                            100,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Center(
                                                                        // color: Colors.grey,
                                                                        child:
                                                                            Text(
                                                                      'No Data',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ))
                                                                  ],
                                                                ),
                                                              ),
                                                        //tab 2: Today
                                                        isData == true
                                                            ? Container(
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .white),
                                                                // margin: EdgeInsets
                                                                //     .symmetric(
                                                                //         horizontal:
                                                                //             screenSize
                                                                //                     .width *
                                                                //                 0.04),
                                                                child:
                                                                    Container(
                                                                        decoration: const BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Color.fromARGB(255, 203, 202, 202),
                                                                                offset: Offset(0.0, 1.0),
                                                                                blurRadius: 6.0,
                                                                              ),
                                                                            ],
                                                                            color: Colors
                                                                                .white),
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: screenSize.width *
                                                                                0.05),
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal: screenSize.width *
                                                                                0.02,
                                                                            vertical: screenSize.height *
                                                                                0.02),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                              decoration: const BoxDecoration(boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Color.fromARGB(255, 203, 202, 202),
                                                                                  offset: Offset(0.0, 1.0),
                                                                                  blurRadius: 6.0,
                                                                                ),
                                                                              ], color: Colors.white),
                                                                              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01, horizontal: screenSize.width * 0.05),
                                                                              margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02, vertical: screenSize.height * 0.02),
                                                                              child: Column(
                                                                                children: [
                                                                                  const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        'Invoice #00001',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                      Text(
                                                                                        '\u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
                                                                                        '09-05-2024 Overdue by 13 days',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Unpaid',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
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
                                                                                        '- Ankit Singh',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Outst \u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  const Divider(),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.blue[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
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
                                                                                                      SizedBox(
                                                                                                        height: screenSize.height * 0.03,
                                                                                                      ),
                                                                                                      InkWell(
                                                                                                        onTap: () {
                                                                                                          // Navigator.push(
                                                                                                          //     context,
                                                                                                          //     MaterialPageRoute(
                                                                                                          //         builder: (context) =>
                                                                                                          //             const UpiPaymentScreen()));
                                                                                                        },
                                                                                                        child: const Padding(
                                                                                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                          child: Text(
                                                                                                            'Add Transaction',
                                                                                                            style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Write Off',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Link transaction',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          icon: const Icon(
                                                                                            Icons.check_circle,
                                                                                            color: Colors.blue,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Record Payment',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.green[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                                                                                          onPressed: () {},
                                                                                          icon: const Icon(
                                                                                            Icons.alarm,
                                                                                            color: Colors.green,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Send Reminder',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              decoration: const BoxDecoration(boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Color.fromARGB(255, 203, 202, 202),
                                                                                  offset: Offset(0.0, 1.0),
                                                                                  blurRadius: 6.0,
                                                                                ),
                                                                              ], color: Colors.white),
                                                                              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01, horizontal: screenSize.width * 0.05),
                                                                              margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02, vertical: screenSize.height * 0.02),
                                                                              child: Column(
                                                                                children: [
                                                                                  const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        'Bill #00001',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                      Text(
                                                                                        '\u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
                                                                                        '09-05-2024 Overdue by 13 days',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Unpaid',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
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
                                                                                        '- Ankit Singh',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Outst \u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  const Divider(),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.blue[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
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
                                                                                                      SizedBox(
                                                                                                        height: screenSize.height * 0.03,
                                                                                                      ),
                                                                                                      InkWell(
                                                                                                        onTap: () {
                                                                                                          // Navigator.push(
                                                                                                          //     context,
                                                                                                          //     MaterialPageRoute(
                                                                                                          //         builder: (context) =>
                                                                                                          //             const UpiPaymentScreen()));
                                                                                                        },
                                                                                                        child: const Padding(
                                                                                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                          child: Text(
                                                                                                            'Add Transaction',
                                                                                                            style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Write Off',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Link transaction',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          icon: const Icon(
                                                                                            Icons.check_circle,
                                                                                            color: Colors.blue,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Record Payment',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.green[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                                                                                          onPressed: () {},
                                                                                          icon: const Icon(
                                                                                            Icons.alarm,
                                                                                            color: Colors.green,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Send Reminder',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )),
                                                              )
                                                            : Container(
                                                                color: Colors
                                                                    .grey[100],
                                                                height:
                                                                    screenSize
                                                                        .height,
                                                                // width: 100,
                                                                child:
                                                                    const Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      // color: Colors.grey,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .receipt_long_sharp,
                                                                        size:
                                                                            100,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Center(
                                                                        // color: Colors.grey,
                                                                        child:
                                                                            Text(
                                                                      'No Data',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ))
                                                                  ],
                                                                ),
                                                              ),
                                                        //tab 3: upcoming
                                                        isData == true
                                                            ? Container(
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .white),
                                                                // margin: EdgeInsets
                                                                //     .symmetric(
                                                                //         horizontal:
                                                                //             screenSize
                                                                //                     .width *
                                                                //                 0.04),
                                                                child:
                                                                    Container(
                                                                        decoration: const BoxDecoration(
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Color.fromARGB(255, 203, 202, 202),
                                                                                offset: Offset(0.0, 1.0),
                                                                                blurRadius: 6.0,
                                                                              ),
                                                                            ],
                                                                            color: Colors
                                                                                .white),
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: screenSize.width *
                                                                                0.05),
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal: screenSize.width *
                                                                                0.02,
                                                                            vertical: screenSize.height *
                                                                                0.02),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                              decoration: const BoxDecoration(boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Color.fromARGB(255, 203, 202, 202),
                                                                                  offset: Offset(0.0, 1.0),
                                                                                  blurRadius: 6.0,
                                                                                ),
                                                                              ], color: Colors.white),
                                                                              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01, horizontal: screenSize.width * 0.05),
                                                                              margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02, vertical: screenSize.height * 0.02),
                                                                              child: Column(
                                                                                children: [
                                                                                  const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        'Invoice #00001',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                      Text(
                                                                                        '\u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
                                                                                        '09-05-2024 Overdue by 13 days',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Unpaid',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
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
                                                                                        '- Ankit Singh',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Outst \u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  const Divider(),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.blue[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
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
                                                                                                      SizedBox(
                                                                                                        height: screenSize.height * 0.03,
                                                                                                      ),
                                                                                                      InkWell(
                                                                                                        onTap: () {
                                                                                                          // Navigator.push(
                                                                                                          //     context,
                                                                                                          //     MaterialPageRoute(
                                                                                                          //         builder: (context) =>
                                                                                                          //             const UpiPaymentScreen()));
                                                                                                        },
                                                                                                        child: const Padding(
                                                                                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                          child: Text(
                                                                                                            'Add Transaction',
                                                                                                            style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Write Off',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Link transaction',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          icon: const Icon(
                                                                                            Icons.check_circle,
                                                                                            color: Colors.blue,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Record Payment',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.green[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                                                                                          onPressed: () {},
                                                                                          icon: const Icon(
                                                                                            Icons.alarm,
                                                                                            color: Colors.green,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Send Reminder',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              decoration: const BoxDecoration(boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Color.fromARGB(255, 203, 202, 202),
                                                                                  offset: Offset(0.0, 1.0),
                                                                                  blurRadius: 6.0,
                                                                                ),
                                                                              ], color: Colors.white),
                                                                              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01, horizontal: screenSize.width * 0.05),
                                                                              margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02, vertical: screenSize.height * 0.02),
                                                                              child: Column(
                                                                                children: [
                                                                                  const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        'Bill #00001',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                      Text(
                                                                                        '\u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
                                                                                        '09-05-2024 Overdue by 13 days',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Unpaid',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
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
                                                                                        '- Ankit Singh',
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Outst \u{20B9} ${100890}',
                                                                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  const Divider(),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.blue[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
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
                                                                                                      SizedBox(
                                                                                                        height: screenSize.height * 0.03,
                                                                                                      ),
                                                                                                      InkWell(
                                                                                                        onTap: () {
                                                                                                          // Navigator.push(
                                                                                                          //     context,
                                                                                                          //     MaterialPageRoute(
                                                                                                          //         builder: (context) =>
                                                                                                          //             const UpiPaymentScreen()));
                                                                                                        },
                                                                                                        child: const Padding(
                                                                                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                          child: Text(
                                                                                                            'Add Transaction',
                                                                                                            style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Write Off',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                                                        child: Text(
                                                                                                          'Link transaction',
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          icon: const Icon(
                                                                                            Icons.check_circle,
                                                                                            color: Colors.blue,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Record Payment',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                      TextButton.icon(
                                                                                          style: TextButton.styleFrom(backgroundColor: Colors.green[50], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                                                                                          onPressed: () {},
                                                                                          icon: const Icon(
                                                                                            Icons.alarm,
                                                                                            color: Colors.green,
                                                                                          ),
                                                                                          label: const Text(
                                                                                            'Send Reminder',
                                                                                            style: TextStyle(fontSize: 12),
                                                                                          )),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )),
                                                              )
                                                            : Container(
                                                                color: Colors
                                                                    .grey[100],
                                                                height:
                                                                    screenSize
                                                                        .height,
                                                                // width: 100,
                                                                child:
                                                                    const Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Center(
                                                                      // color: Colors.grey,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .receipt_long_sharp,
                                                                        size:
                                                                            100,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Center(
                                                                        // color: Colors.grey,
                                                                        child:
                                                                            Text(
                                                                      'No Data',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ))
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
                                        ],
                                      ),
                                    )
                                  :
                                  //tab 2: Recurring
                                  Container(
                                      height: screenSize.height,
                                      color: Colors.grey[100],
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      screenSize.width * 0.35),
                                              child: const Text(
                                                'Sort & Filter',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            title: IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet<void>(
                                                    backgroundColor:
                                                        Colors.white,
                                                    scrollControlDisabledMaxHeightRatio:
                                                        0.2,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const ListTile(
                                                            leading: Icon(
                                                              Icons.sort,
                                                              size: 30,
                                                              weight: 50,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      50,
                                                                      49,
                                                                      49),
                                                            ),
                                                            title: Text(
                                                              'Sort By',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          49,
                                                                          49),
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            // trailing: TextButton.icon(
                                                            //   onPressed: () {
                                                            //     Navigator.pop(
                                                            //         context);
                                                            //   },
                                                            //   icon: const Icon(
                                                            //     Icons.close,
                                                            //     size: 30,
                                                            //     color: Colors.black,
                                                            //   ),
                                                            //   label: const Text(
                                                            //     'clear',
                                                            //     style: TextStyle(
                                                            //         color:
                                                            //             Colors.black,
                                                            //         fontSize: 15),
                                                            //   ),
                                                            // ),
                                                          ),
                                                          Divider(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          SelectChipsInput(
                                                            marginBetweenChips:
                                                                EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        screenSize.width *
                                                                            0.09,
                                                                    vertical: screenSize
                                                                            .height *
                                                                        0.001),
                                                            paddingInsideChipContainer:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        12.0,
                                                                    horizontal:
                                                                        16.0),
                                                            chipsText: const [
                                                              'AMOUNT',
                                                              'NAME'
                                                            ],
                                                            separatorCharacter:
                                                                ";",
                                                            selectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                            unselectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                            ),
                                                            onTap: (p0, p1) {
                                                              setState(() {
                                                                outputSelectChipsInput =
                                                                    p0;
                                                              });
                                                            },
                                                            // prefixIcons: const [
                                                            //   Icon(
                                                            //     Icons.arrow_drop_down,
                                                            //     size: 25.0,
                                                            //     color: Colors.black,
                                                            //   ),
                                                            //   Icon(
                                                            //     Icons.arrow_drop_down,
                                                            //     size: 25.0,
                                                            //     color: Colors.black,
                                                            //   ),
                                                            // ],
                                                            // selectedPrefixIcon:
                                                            //     const Padding(
                                                            //   padding: EdgeInsets.only(
                                                            //       right: 5.0),
                                                            //   child: Icon(
                                                            //     Icons
                                                            //         .arrow_drop_up_outlined,
                                                            //     size: 25.0,
                                                            //     color: Colors.white,
                                                            //   ),
                                                            // ),
                                                            widgetContainerDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  249,
                                                                  248,
                                                                  248),
                                                            ),
                                                            unselectedChipDecoration:
                                                                BoxDecoration(
                                                              // color: Colors.green,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 1.8),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                            selectedChipDecoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                          ),
                                                          // SelectChipsInput(
                                                          //   marginBetweenChips:
                                                          //       EdgeInsets.symmetric(
                                                          //     horizontal:
                                                          //         screenSize.width *
                                                          //             0.1,
                                                          //   ),
                                                          //   paddingInsideChipContainer:
                                                          //       const EdgeInsets
                                                          //           .symmetric(
                                                          //           vertical: 12.0,
                                                          //           horizontal: 12.0),
                                                          //   chipsText: const [
                                                          //     'RECENT',
                                                          //     'DUE DATE'
                                                          //   ],
                                                          //   separatorCharacter: ";",
                                                          //   selectedChipTextStyle:
                                                          //       const TextStyle(
                                                          //     color: Colors.white,
                                                          //     fontSize: 16,
                                                          //   ),
                                                          //   unselectedChipTextStyle:
                                                          //       const TextStyle(
                                                          //     color: Colors.black,
                                                          //     fontSize: 16,
                                                          //   ),
                                                          //   onTap: (p0, p1) {
                                                          //     setState(() {
                                                          //       outputSelectChipsInput =
                                                          //           p0;
                                                          //     });
                                                          //   },
                                                          //   prefixIcons: const [
                                                          //     Icon(
                                                          //       Icons.arrow_drop_down,
                                                          //       size: 25.0,
                                                          //       color: Colors.black,
                                                          //     ),
                                                          //     Icon(
                                                          //       Icons.arrow_drop_down,
                                                          //       size: 25.0,
                                                          //       color: Colors.black,
                                                          //     ),
                                                          //   ],
                                                          //   selectedPrefixIcon:
                                                          //       const Padding(
                                                          //     padding: EdgeInsets.only(
                                                          //         right: 5.0),
                                                          //     child: Icon(
                                                          //       Icons
                                                          //           .arrow_drop_up_outlined,
                                                          //       size: 25.0,
                                                          //       color: Colors.white,
                                                          //     ),
                                                          //   ),
                                                          //   widgetContainerDecoration:
                                                          //       BoxDecoration(
                                                          //     borderRadius:
                                                          //         BorderRadius.circular(
                                                          //             30.0),
                                                          //     color:
                                                          //         const Color.fromARGB(
                                                          //             255,
                                                          //             249,
                                                          //             248,
                                                          //             248),
                                                          //   ),
                                                          //   unselectedChipDecoration:
                                                          //       BoxDecoration(
                                                          //     // color: Colors.green,
                                                          //     border: Border.all(
                                                          //         color: Colors.green,
                                                          //         width: 1.8),
                                                          //     borderRadius:
                                                          //         BorderRadius.circular(
                                                          //             30.0),
                                                          //   ),
                                                          //   selectedChipDecoration:
                                                          //       BoxDecoration(
                                                          //     color: Colors.green,
                                                          //     borderRadius:
                                                          //         BorderRadius.circular(
                                                          //             30.0),
                                                          //   ),
                                                          // ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.sort,
                                                  color: Color.fromARGB(
                                                      255, 50, 49, 49),
                                                )),
                                            trailing: IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet<void>(
                                                    backgroundColor:
                                                        Colors.white,
                                                    scrollControlDisabledMaxHeightRatio:
                                                        0.3,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const ListTile(
                                                            leading: Icon(
                                                              Icons.sort,
                                                              size: 30,
                                                              weight: 50,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      50,
                                                                      49,
                                                                      49),
                                                            ),
                                                            title: Text(
                                                              'Filter',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          50,
                                                                          49,
                                                                          49),
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            // trailing: TextButton.icon(
                                                            //   onPressed: () {
                                                            //     Navigator.pop(context);
                                                            //   },
                                                            //   icon: const Icon(
                                                            //     Icons.close,
                                                            //     size: 30,
                                                            //     color: Colors.black,
                                                            //   ),
                                                            //   label: const Text(
                                                            //     'clear',
                                                            //     style: TextStyle(
                                                            //         color: Colors.black,
                                                            //         fontSize: 15),
                                                            //   ),
                                                            // ),
                                                          ),
                                                          Divider(
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          SelectChipsInput(
                                                            marginBetweenChips:
                                                                EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        screenSize.width *
                                                                            0.05,
                                                                    vertical:
                                                                        screenSize.height *
                                                                            0.01),
                                                            paddingInsideChipContainer:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        12.0,
                                                                    horizontal:
                                                                        40.0),
                                                            chipsText: const [
                                                              'Invoice',
                                                              'Bill'
                                                            ],
                                                            separatorCharacter:
                                                                ";",
                                                            selectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                            unselectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                            ),
                                                            onTap: (p0, p1) {
                                                              setState(() {
                                                                outputSelectChipsInput =
                                                                    p0;
                                                              });
                                                            },
                                                            widgetContainerDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  249,
                                                                  248,
                                                                  248),
                                                            ),
                                                            unselectedChipDecoration:
                                                                BoxDecoration(
                                                              // color: Colors.green,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 1.8),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                            selectedChipDecoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                          ),
                                                          SelectChipsInput(
                                                            marginBetweenChips:
                                                                EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        screenSize.width *
                                                                            0.05,
                                                                    vertical: screenSize
                                                                            .height *
                                                                        0.001),
                                                            paddingInsideChipContainer:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        12.0,
                                                                    horizontal:
                                                                        40.0),
                                                            chipsText: const [
                                                              'Transaction',
                                                              'EMI'
                                                            ],
                                                            separatorCharacter:
                                                                ";",
                                                            selectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                            unselectedChipTextStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                            ),
                                                            onTap: (p0, p1) {
                                                              setState(() {
                                                                outputSelectChipsInput =
                                                                    p0;
                                                              });
                                                            },
                                                            widgetContainerDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  249,
                                                                  248,
                                                                  248),
                                                            ),
                                                            unselectedChipDecoration:
                                                                BoxDecoration(
                                                              // color: Colors.green,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 1.8),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                            selectedChipDecoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  CupertinoIcons
                                                      .text_alignright,
                                                  color: Color.fromARGB(
                                                      255, 50, 49, 49),
                                                )),
                                          ),
                                          Expanded(
                                            child: DefaultTabController(
                                              length: 2,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                Colors.white),
                                                    child: ButtonsTabBar(
                                                      height: 60.0,
                                                      radius: 0,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 80,
                                                              vertical: 8.0),
                                                      // Customize the appearance and behavior of the tab bar
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              227, 224, 234),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),

                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),

                                                      unselectedLabelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                      unselectedBackgroundColor:
                                                          Colors.white,
                                                      // Add your tabs here
                                                      tabs: const [
                                                        Tab(
                                                          text:
                                                              '\u20B9${123890}\nToday',
                                                        ),
                                                        Tab(
                                                          text:
                                                              '   \u20B9${0}\nUpcoming',
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TabBarView(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      children: [
                                                        //tab 1: container 1
                                                        Container(
                                                          color:
                                                              Colors.grey[100],
                                                          height:
                                                              screenSize.height,
                                                          // width: 100,
                                                          child: const Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Center(
                                                                // color: Colors.grey,
                                                                child: Icon(
                                                                  Icons
                                                                      .receipt_long_sharp,
                                                                  size: 100,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Center(
                                                                  // color: Colors.grey,
                                                                  child: Text(
                                                                'No Data',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ))
                                                            ],
                                                          ),
                                                        ),
                                                        //tab 2: Today
                                                        Container(
                                                          color:
                                                              Colors.grey[100],
                                                          height:
                                                              screenSize.height,
                                                          // width: 100,
                                                          child: const Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Center(
                                                                // color: Colors.grey,
                                                                child: Icon(
                                                                  Icons
                                                                      .receipt_long_sharp,
                                                                  size: 100,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Center(
                                                                  // color: Colors.grey,
                                                                  child: Text(
                                                                'No Data',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ))
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
        floatingActionButton: (tabIndex == 0)
            ? FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 31, 1, 102),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
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
                                   '/create-invoice');
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
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context,
                                    '/create-bill');
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  'Bill',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
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
                  size: 40,
                ),
              )
            : FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 31, 1, 102),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
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
                            SizedBox(
                              height: screenSize.height * 0.03,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context,
                                    '/recurring-transaction');
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context,
                                      '/recurring-invoice');
                                },
                                child: const Text(
                                  'Recurring Invoice',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context,
                                    '/recurring-bill');
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  'Recurring Bill',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context,
                                    '/emi');
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  'EMI',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
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
                  size: 40,
                ),
              ),
      bottomNavigationBar: BottomNavBarWidget.bottomNavBar(
            screenSize, context, currentPageIndexValue, (index) {
         setState(() {
           currentPageIndexValue = index;
         });
          if (currentPageIndexValue == 0) {
            Navigator.pushNamed(context, '/dashboard');
          } else if (currentPageIndexValue == 1) {
            Navigator.pushNamed(context, '/invoice');
          } else if (currentPageIndexValue == 2) {
            Navigator.pushNamed(context, '/business');
          } else if (currentPageIndexValue == 3) {
            Navigator.pushNamed(context, '/accounts');
          }
        }),
      ),
    );
  }
}
