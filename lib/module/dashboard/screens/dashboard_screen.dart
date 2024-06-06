// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:io';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:dkapp/global_widget/bottom_nav_bar.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:duration_button/duration_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chips_input/select_chips_input.dart';

import '../../../global_blocs/internet/internet_cubit.dart';
import '../../../global_blocs/internet/internet_state.dart';

class DashboardScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  DashboardScreen({super.key, required this.argus});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> _locations = ['Select'];

  Future<bool> showGroupsPopup(context) async {
    // exit from app
    return await showDialog(
        // barrierColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.only(
                right: 150.0, left: 40.0, top: 10.0), // Adjust width here
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            title: const Text('Select Business'),
            content: ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              minLeadingWidth: 0.0,
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: const Color.fromARGB(255, 246, 242, 201),
                child: Image.asset(
                  'resources/images/house-icon-removebg-preview.png',
                  height: 30,
                  width: 30,
                ),
                // Icon(
                //   Icons.home,
                //   color: Colors.red[300],
                // ),
              ),
              title: const Text(
                'Priyanka',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                '+919867543243\nabc42@gmail.com',
                style: TextStyle(fontSize: 15),
              ),
              // trailing: Icon(
              //   Icons.check_circle,
              //   size: 20,
              //   color: Colors.green,
              // ),
            ),
            actions: [
              const Divider(),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/add-new-business',
                      arguments: widget.argus);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Image.asset(
                    //   'resources/images/house-icon-removebg-preview.png',
                    //   height: 50,
                    //   width: 50,
                    // ),
                    Icon(
                      Icons.person_add,
                      color: Colors.green,
                    ),
                    Text(
                      'Add New Business',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
                // icon: Icon(
                //   Icons.person_add,
                //   color: Colors.green,
                // ),
                // label: Text(
                //   'Add New Business',
                //   style: TextStyle(color: Colors.black, fontSize: 15),
                // ),
                // onPressed: () {
                //   Navigator.pop(context);
                // },
              )
            ],
          );
          // });
        });
  }

  // int currentIndex = 0;
  String outputSelectChipsInput = '';

  late int currentPageIndexValue = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          EssentialWidgetsCollection.showAlertDialogForLogout(context,
              content: "Do you want to exit from App?", taskOne: () {
            exit(0);
          }, taskTwo: () {
            Navigator.pop(context);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.blue,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: ListTile(
              onTap: () {
                showGroupsPopup(context);
              },
              title: const Text(
                'Business Name',
                style: TextStyle(
                    color: Color.fromARGB(255, 237, 235, 235), fontSize: 16),
              ),
              subtitle: const Row(
                children: [
                  Text(
                    'Retailer',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
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
            IconButton(
                onPressed: () {
                  _locations.map((location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(
                        location,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList();
                },
                icon: const Icon(
                  Icons.more_vert,
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
                BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                    if (state == InternetState.internetLost) {
                      return DurationButton(
                          width: 1,
                          height: 1,
                          hoverColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          coverColor: Colors.transparent,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                              context,
                              '/error',
                            );
                          },
                          duration: Durations.short2,
                          child: Container());
                    }
                    return Container();
                  },
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.green[100],
                              // radius: 15,
                              child: const Icon(
                                Icons.south_east_rounded,
                                color: Colors.green,
                              )),
                          title: const Text(
                            '\u20B9${0}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text('Advance Received'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        height: 70,
                        width: 0.2,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.red[50],
                              child: const Icon(
                                Icons.arrow_outward_sharp,
                                color: Colors.red,
                              )),
                          title: const Text(
                            '\u20B9${0}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text('Due Pending'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  height: screenSize.height / 1.2,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Text(
                          'UPCOMING DUE ACCOUNTS - 0',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        title: IconButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                backgroundColor: Colors.white,
                                scrollControlDisabledMaxHeightRatio: 0.3,
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                          Icons.sort,
                                          size: 30,
                                          weight: 50,
                                          color:
                                              Color.fromARGB(255, 50, 49, 49),
                                        ),
                                        title: const Text(
                                          'Sort By',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 50, 49, 49),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        trailing: TextButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          label: const Text(
                                            'clear',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[300],
                                      ),
                                      SelectChipsInput(
                                        marginBetweenChips:
                                            EdgeInsets.symmetric(
                                                horizontal:
                                                    screenSize.width * 0.09,
                                                vertical:
                                                    screenSize.height * 0.001),
                                        paddingInsideChipContainer:
                                            const EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 16.0),
                                        chipsText: const ['AMOUNT', 'NAME'],
                                        separatorCharacter: ";",
                                        selectedChipTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        unselectedChipTextStyle:
                                            const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        onTap: (p0, p1) {
                                          setState(() {
                                            outputSelectChipsInput = p0;
                                          });
                                        },
                                        prefixIcons: const [
                                          Icon(
                                            Icons.arrow_drop_down,
                                            size: 25.0,
                                            color: Colors.black,
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            size: 25.0,
                                            color: Colors.black,
                                          ),
                                        ],
                                        selectedPrefixIcon: const Padding(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: Icon(
                                            Icons.arrow_drop_up_outlined,
                                            size: 25.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        widgetContainerDecoration:
                                            BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          color: const Color.fromARGB(
                                              255, 249, 248, 248),
                                        ),
                                        unselectedChipDecoration: BoxDecoration(
                                          // color: Colors.green,
                                          border: Border.all(
                                              color: Colors.green, width: 1.8),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        selectedChipDecoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      SelectChipsInput(
                                        marginBetweenChips:
                                            EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.1,
                                        ),
                                        paddingInsideChipContainer:
                                            const EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 12.0),
                                        chipsText: const ['RECENT', 'DUE DATE'],
                                        separatorCharacter: ";",
                                        selectedChipTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        unselectedChipTextStyle:
                                            const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        onTap: (p0, p1) {
                                          setState(() {
                                            outputSelectChipsInput = p0;
                                          });
                                        },
                                        prefixIcons: const [
                                          Icon(
                                            Icons.arrow_drop_down,
                                            size: 25.0,
                                            color: Colors.black,
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            size: 25.0,
                                            color: Colors.black,
                                          ),
                                        ],
                                        selectedPrefixIcon: const Padding(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: Icon(
                                            Icons.arrow_drop_up_outlined,
                                            size: 25.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        widgetContainerDecoration:
                                            BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          color: const Color.fromARGB(
                                              255, 249, 248, 248),
                                        ),
                                        unselectedChipDecoration: BoxDecoration(
                                          // color: Colors.green,
                                          border: Border.all(
                                              color: Colors.green, width: 1.8),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        selectedChipDecoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.sort,
                              color: Color.fromARGB(255, 50, 49, 49),
                            )),
                        trailing: IconButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                backgroundColor: Colors.white,
                                scrollControlDisabledMaxHeightRatio: 0.3,
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                          Icons.sort,
                                          size: 30,
                                          weight: 50,
                                          color:
                                              Color.fromARGB(255, 50, 49, 49),
                                        ),
                                        title: const Text(
                                          'Filter',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 50, 49, 49),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        trailing: TextButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          label: const Text(
                                            'clear',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[300],
                                      ),
                                      SelectChipsInput(
                                        marginBetweenChips:
                                            EdgeInsets.symmetric(
                                                horizontal:
                                                    screenSize.width * 0.09,
                                                vertical:
                                                    screenSize.height * 0.01),
                                        paddingInsideChipContainer:
                                            const EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 16.0),
                                        chipsText: const [
                                          'Hide Zero Balance Accounts',
                                          'Hide DND'
                                        ],
                                        separatorCharacter: ";",
                                        selectedChipTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        unselectedChipTextStyle:
                                            const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        onTap: (p0, p1) {
                                          setState(() {
                                            outputSelectChipsInput = p0;
                                          });
                                        },
                                        widgetContainerDecoration:
                                            BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          color: const Color.fromARGB(
                                              255, 249, 248, 248),
                                        ),
                                        unselectedChipDecoration: BoxDecoration(
                                          // color: Colors.green,
                                          border: Border.all(
                                              color: Colors.green, width: 1.8),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        selectedChipDecoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.text_alignright,
                              color: Color.fromARGB(255, 50, 49, 49),
                            )),
                      ),
                      SizedBox(
                        height: screenSize.height / 2.5,
                        width: screenSize.width,
                        child: DefaultTabController(
                          length: 7,
                          child: Column(
                            children: <Widget>[
                              ButtonsTabBar(
                                labelSpacing: 8.0,
                                buttonMargin: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                radius: 50,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10.0),
                                // Customize the appearance and behavior of the tab bar
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 31, 1, 102),
                                    borderRadius: BorderRadius.circular(30)),

                                // borderWidth: 2,
                                // borderColor: Colors.black,
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                unselectedLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                // Add your tabs here
                                tabs: const [
                                  Tab(
                                    text: 'All',
                                  ),
                                  Tab(
                                    text: 'Today',
                                  ),
                                  Tab(
                                    text: 'Overdue',
                                  ),
                                  Tab(
                                    text: 'Upcoming',
                                  ),
                                  Tab(
                                    text: 'Tag',
                                  ),
                                  Tab(
                                    text: 'Groups',
                                  ),
                                  Tab(
                                    text: 'DND',
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    //tab 1: All
                                    Container(
                                      color: Colors.grey[100],
                                      // height: 200,
                                      // width: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Color.fromARGB(
                                                255, 230, 223, 246),
                                            child: Icon(
                                              CupertinoIcons.question,
                                              size: 50,
                                              color: Color.fromARGB(
                                                  255, 31, 1, 102),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Text(
                                            'No accounts',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 1, 102),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Text(
                                            'Add your client/parties to start collecting payments',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 31, 1, 102),
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    //tab 2: Today
                                    Container(
                                      color: Colors.grey[100],
                                      // height: 200,
                                      // width: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Color.fromARGB(
                                                255, 230, 223, 246),
                                            child: Icon(
                                              CupertinoIcons.search_circle_fill,
                                              size: 60,
                                              color: Colors.brown,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Text(
                                            'No Results',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 1, 102),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'No account fond with current filter/search. Please',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  ' change or clear filter/search',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    //tab 3: Overdue
                                    Container(
                                      color: Colors.grey[100],
                                      // height: 200,
                                      // width: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Color.fromARGB(
                                                255, 230, 223, 246),
                                            child: Icon(
                                              CupertinoIcons.search_circle_fill,
                                              size: 60,
                                              color: Colors.brown,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Text(
                                            'No Results',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 1, 102),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'No account fond with current filter/search. Please',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  ' change or clear filter/search',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    //tab 4: UpComing
                                    Container(
                                      color: Colors.grey[100],
                                      // height: 200,
                                      // width: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Color.fromARGB(
                                                255, 230, 223, 246),
                                            child: Icon(
                                              CupertinoIcons.search_circle_fill,
                                              size: 60,
                                              color: Colors.brown,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Text(
                                            'No Results',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 1, 102),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'No account fond with current filter/search. Please',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  ' change or clear filter/search',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    //tab 5: Tag
                                    Container(
                                      color: Colors.grey[100],
                                      // height: 200,
                                      // width: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Color.fromARGB(
                                                255, 247, 226, 218),
                                            child: Icon(
                                              CupertinoIcons.tag_fill,
                                              size: 60,
                                              color: Colors.brown,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Text(
                                            'No Tags',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 1, 102),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'No tags defined.',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  'Tag can be anything that is relevant for your business',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    //tab 6: Groups
                                    const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Color.fromARGB(
                                                255, 238, 233, 179),
                                            child: Icon(
                                              CupertinoIcons.person_3_fill,
                                              color: Color.fromARGB(
                                                  255, 50, 49, 49),
                                              size: 30,
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'No group Added!!',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),

                                    //tab 7: DND
                                    Container(
                                      color: Colors.grey[100],
                                      // height: 200,
                                      // width: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Color.fromARGB(
                                                255, 230, 223, 246),
                                            child: Icon(
                                              CupertinoIcons.search_circle_fill,
                                              size: 60,
                                              color: Colors.brown,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Text(
                                            'No Results',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 31, 1, 102),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'No account fond with current filter/search. Please',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  ' change or clear filter/search',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                      )
                      // SizedBox(
                      //   height: screenSize.height * 0.02,
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 31, 1, 102),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          onPressed: () {},
          child: const Icon(
            Icons.person_add,
            color: Colors.white,
            size: 28,
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

class SearchBarDelegate extends SearchDelegate {
  final TextEditingController searchController;

  SearchBarDelegate() : searchController = TextEditingController();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          searchController.clear();

          query = 'Search';
        },
      ),
    ];
  }

// actionsIconTheme: theme.actionIconTheme.copyWith()
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: Colors.white,
      appBarTheme: theme.appBarTheme.copyWith(
          color: Colors.blue,
          elevation: 5,
          titleTextStyle: const TextStyle(color: Colors.white)),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white, selectionColor: Colors.white),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
