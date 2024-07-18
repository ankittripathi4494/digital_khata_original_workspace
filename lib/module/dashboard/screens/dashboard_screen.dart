// ignore_for_file: deprecated_member_use, must_be_immutable, use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'dart:async';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:dkapp/global_widget/animated_loading_placeholder_widget.dart';
import 'package:dkapp/global_widget/bottom_nav_bar.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/business_bloc/business_bloc.dart';
import 'package:dkapp/module/business/business_bloc/business_event.dart';
import 'package:dkapp/module/business/business_bloc/business_state.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_bloc.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_event.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_state.dart';
import 'package:dkapp/module/customers/model/customer_response_model.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_chips_input/select_chips_input.dart';
import 'package:talker/talker.dart';

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
  BusinessListResponseData? selectedBusinessResponseData;
  SharedPreferencesHelper sph = SharedPreferencesHelper();

  // int currentIndex = 0;
  String outputSelectChipsInput = '';

  late int currentPageIndexValue = 0;

  late double advancedReceived = 0;

  late double duePending = 0;

  @override
  void initState() {
    fetchBusinessList();
    super.initState();
  }

  fetchBusinessList() {
    BlocProvider.of<BusinessBloc>(context)
        .add(BusinessListFetchEvent(userId: sph.getString("userid")!));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetLost) {
          // tempData = widget.argus.addEntries([const MapEntry("page", "login")]);
          Timer(Durations.medium2, () {
            Navigator.pushReplacementNamed(
              context,
              '/no-internet',
            );
          });
        }
      },
      child: DoubleBack(
         message:"Press back again to close",
        // canPop: false,
        // onPopInvoked: (didPop) {
        //   if (!didPop) {
        //     EssentialWidgetsCollection.showAlertDialogForLogoutMain(context,
        //         content: "Do you want to exit from App?", taskOne: () {
        //       exit(0);
        //     }, taskTwo: () {
        //       Navigator.pop(context);
        //     });
        //   }
        // },
        child: BlocBuilder<BusinessBloc, BusinessState>(
          builder: (context, state) {
            if (state is BusinessListLoadedState) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: Container(),
                  backgroundColor: Colors.blue,
                  flexibleSpace: InkWell(
                    onTap: () => showDialog(
                        // barrierColor: Colors.white,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: AlertDialog(
                              titlePadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              buttonPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              actionsPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              backgroundColor: Colors.white,
                              insetPadding: EdgeInsets.zero,
                              // titlePadding: const EdgeInsets.only(
                              //     right: 150.0,
                              //     left: 40.0,
                              //     top: 10.0), // Adjust width here
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              title: const Text('Select Business'),
                              content: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: state.successData?.length,
                                    itemBuilder: (context, index) {
                                      BusinessListResponseData businessData =
                                          state.successData![index];
                                      Talker().info(
                                          "Business Name:- ${businessData.bName}");
                                      return Material(
                                        color: Colors.white,
                                        child: ListTile(
                                          dense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 0.0),
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          onTap: () {
                                            BlocProvider.of<BusinessBloc>(
                                                    context)
                                                .add(SelectBusinessEvent(
                                                    userId: sph
                                                        .getString("userid")!,
                                                    businessData:
                                                        businessData));
                                            Navigator.pop(context);
                                            Navigator.pushReplacementNamed(
                                                context, '/dashboard',
                                                arguments: widget.argus);
                                          },
                                          minLeadingWidth: 0.0,
                                          leading: CircleAvatar(
                                            radius: 25,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 246, 242, 201),
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
                                          title: Text(
                                            businessData.bName!,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text(
                                            '${businessData.email}',
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          trailing: Visibility(
                                            visible: (businessData.isSelected ==
                                                    true)
                                                ? true
                                                : false,
                                            replacement: SizedBox.shrink(),
                                            child: Icon(
                                              Icons.check_circle,
                                              size: 20,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
        
                              actions: [
                                const Divider(),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton.icon(
                                    onPressed: () => addBusiness(),
                                    icon: const Icon(
                                      Icons.person_add,
                                      color: Colors.green,
                                    ),
                                    label: const Text(
                                      'Add New Business',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                          // });
                        }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: ListTile(
                        onTap: null,
                        title: Text(
                          'Business Name',
                          style: TextStyle(
                              color: Color.fromARGB(255, 237, 235, 235),
                              fontSize: 16),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              state.selectedBusinessData!.bName ?? '',
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
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        EssentialWidgetsCollection.autoScheduleTask(
                          context,
                          taskWaitDuration: Durations.medium3,
                          task: () {
                            setState(() {
                              advancedReceived = 0;
                              duePending = 0;
                            });
                            BlocProvider.of<CustomerBloc>(context).add(
                                CustomerListFetchEvent(
                                    userId: sph.getString("userid")!,
                                    businessId:
                                        state.selectedBusinessData?.id ?? ''));
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
                                  title: Text(
                                    '\u20B9${advancedReceived.abs().toStringAsFixed(2)}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: const Text('Advance Received'),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20.0),
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
                                  title: Text(
                                    '\u20B9${duePending.abs().toStringAsFixed(2)}',
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
                        customerTabList(screenSize, state.selectedBusinessData)
                      ],
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 31, 1, 102),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-customer', arguments: {
                      "selectedBusiness": state.selectedBusinessData
                    });
                  },
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
                    Navigator.pushNamed(
                      context,
                      '/dashboard',
                    );
                  } else if (currentPageIndexValue == 1) {
                    Navigator.pushNamed(
                      context,
                      '/invoice',
                    );
                  } else if (currentPageIndexValue == 2) {
                    Navigator.pushNamed(
                      context,
                      '/business',
                    );
                  } else if (currentPageIndexValue == 3) {
                    Navigator.pushNamed(
                      context,
                      '/accounts',
                    );
                  }
                }),
              );
            }
            if (state is BusinessListFailedState) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: Container(),
                  backgroundColor: Colors.blue,
                  flexibleSpace: InkWell(
                    onTap: () => showDialog(
                        // barrierColor: Colors.white,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: AlertDialog(
                              backgroundColor: Colors.white,
                              insetPadding: EdgeInsets.zero,
                              titlePadding: const EdgeInsets.only(
                                  right: 150.0,
                                  left: 40.0,
                                  top: 10.0), // Adjust width here
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              title: const Text('Select Business'),
                              content: Material(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  child: const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.no_accounts,
                                          size: 60,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('No Business Found'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
        
                              actions: [
                                const Divider(),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/add-new-business',
                                          arguments: widget.argus);
                                    },
                                    icon: const Icon(
                                      Icons.person_add,
                                      color: Colors.green,
                                    ),
                                    label: const Text(
                                      'Add New Business',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                          // });
                        }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: ListTile(
                        onTap: null,
                        title: Text(
                          'Business Name',
                          style: TextStyle(
                              color: Color.fromARGB(255, 237, 235, 235),
                              fontSize: 16),
                        ),
                        subtitle: Row(
                          children: const [
                            Text(
                              '',
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20.0),
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
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                title: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        backgroundColor: Colors.white,
                                        scrollControlDisabledMaxHeightRatio:
                                            0.3,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ListTile(
                                                leading: const Icon(
                                                  Icons.sort,
                                                  size: 30,
                                                  weight: 50,
                                                  color: Color.fromARGB(
                                                      255, 50, 49, 49),
                                                ),
                                                title: const Text(
                                                  'Sort By',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 50, 49, 49),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                                            screenSize.width *
                                                                0.09,
                                                        vertical:
                                                            screenSize.height *
                                                                0.001),
                                                paddingInsideChipContainer:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 16.0),
                                                chipsText: const [
                                                  'AMOUNT',
                                                  'NAME'
                                                ],
                                                separatorCharacter: ";",
                                                selectedChipTextStyle:
                                                    const TextStyle(
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
                                                selectedPrefixIcon:
                                                    const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5.0),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_drop_up_outlined,
                                                    size: 25.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                widgetContainerDecoration:
                                                    BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  color: const Color.fromARGB(
                                                      255, 249, 248, 248),
                                                ),
                                                unselectedChipDecoration:
                                                    BoxDecoration(
                                                  // color: Colors.green,
                                                  border: Border.all(
                                                      color: Colors.green,
                                                      width: 1.8),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                selectedChipDecoration:
                                                    BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                              ),
                                              SelectChipsInput(
                                                marginBetweenChips:
                                                    EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenSize.width * 0.1,
                                                ),
                                                paddingInsideChipContainer:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 12.0),
                                                chipsText: const [
                                                  'RECENT',
                                                  'DUE DATE'
                                                ],
                                                separatorCharacter: ";",
                                                selectedChipTextStyle:
                                                    const TextStyle(
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
                                                selectedPrefixIcon:
                                                    const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5.0),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_drop_up_outlined,
                                                    size: 25.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                widgetContainerDecoration:
                                                    BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  color: const Color.fromARGB(
                                                      255, 249, 248, 248),
                                                ),
                                                unselectedChipDecoration:
                                                    BoxDecoration(
                                                  // color: Colors.green,
                                                  border: Border.all(
                                                      color: Colors.green,
                                                      width: 1.8),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                selectedChipDecoration:
                                                    BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
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
                                      color: Color.fromARGB(255, 50, 49, 49),
                                    )),
                                trailing: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        backgroundColor: Colors.white,
                                        scrollControlDisabledMaxHeightRatio:
                                            0.3,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ListTile(
                                                leading: const Icon(
                                                  Icons.sort,
                                                  size: 30,
                                                  weight: 50,
                                                  color: Color.fromARGB(
                                                      255, 50, 49, 49),
                                                ),
                                                title: const Text(
                                                  'Filter',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 50, 49, 49),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                                            screenSize.width *
                                                                0.09,
                                                        vertical:
                                                            screenSize.height *
                                                                0.01),
                                                paddingInsideChipContainer:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 16.0),
                                                chipsText: const [
                                                  'Hide Zero Balance Accounts',
                                                  'Hide DND'
                                                ],
                                                separatorCharacter: ";",
                                                selectedChipTextStyle:
                                                    const TextStyle(
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
                                                      BorderRadius.circular(
                                                          16.0),
                                                  color: const Color.fromARGB(
                                                      255, 249, 248, 248),
                                                ),
                                                unselectedChipDecoration:
                                                    BoxDecoration(
                                                  // color: Colors.green,
                                                  border: Border.all(
                                                      color: Colors.green,
                                                      width: 1.8),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                selectedChipDecoration:
                                                    BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
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
                                        buttonMargin:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 5.0),
                                        radius: 50,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 10.0),
                                        // Customize the appearance and behavior of the tab bar
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 31, 1, 102),
                                            borderRadius:
                                                BorderRadius.circular(30)),
        
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
                                          physics:
                                              const NeverScrollableScrollPhysics(),
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
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 230, 223, 246),
                                                    child: Icon(
                                                      CupertinoIcons.question,
                                                      size: 50,
                                                      color: Color.fromARGB(
                                                          255, 31, 1, 102),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
                                                  ),
                                                  const Text(
                                                    'No accounts',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 31, 1, 102),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
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
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 230, 223, 246),
                                                    child: Icon(
                                                      CupertinoIcons
                                                          .search_circle_fill,
                                                      size: 60,
                                                      color: Colors.brown,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
                                                  ),
                                                  const Text(
                                                    'No Results',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 31, 1, 102),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(20.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'No account fond with current filter/search. Please',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    1,
                                                                    102),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          ' change or clear filter/search',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    1,
                                                                    102),
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
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 230, 223, 246),
                                                    child: Icon(
                                                      CupertinoIcons
                                                          .search_circle_fill,
                                                      size: 60,
                                                      color: Colors.brown,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
                                                  ),
                                                  const Text(
                                                    'No Results',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 31, 1, 102),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(20.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'No account fond with current filter/search. Please',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    1,
                                                                    102),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          ' change or clear filter/search',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    1,
                                                                    102),
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
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 230, 223, 246),
                                                    child: Icon(
                                                      CupertinoIcons
                                                          .search_circle_fill,
                                                      size: 60,
                                                      color: Colors.brown,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
                                                  ),
                                                  const Text(
                                                    'No Results',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 31, 1, 102),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(20.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'No account fond with current filter/search. Please',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    1,
                                                                    102),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          ' change or clear filter/search',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    1,
                                                                    102),
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
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 247, 226, 218),
                                                    child: Icon(
                                                      CupertinoIcons.tag_fill,
                                                      size: 60,
                                                      color: Colors.brown,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
                                                  ),
                                                  const Text(
                                                    'No Tags',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 31, 1, 102),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(20.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'No tags defined.',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    1,
                                                                    102),
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Tag can be anything that is relevant for your business',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    1,
                                                                    102),
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
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 238, 233, 179),
                                                    child: Icon(
                                                      CupertinoIcons
                                                          .person_3_fill,
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
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 230, 223, 246),
                                                    child: Icon(
                                                      CupertinoIcons
                                                          .search_circle_fill,
                                                      size: 60,
                                                      color: Colors.brown,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
                                                  ),
                                                  const Text(
                                                    'No Results',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 31, 1, 102),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.01,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(20.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'No account fond with current filter/search. Please',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    1,
                                                                    102),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          ' change or clear filter/search',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    1,
                                                                    102),
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
                    Navigator.pushNamed(
                      context,
                      '/dashboard',
                    );
                  } else if (currentPageIndexValue == 1) {
                    Navigator.pushNamed(
                      context,
                      '/invoice',
                    );
                  } else if (currentPageIndexValue == 2) {
                    Navigator.pushNamed(
                      context,
                      '/business',
                    );
                  } else if (currentPageIndexValue == 3) {
                    Navigator.pushNamed(
                      context,
                      '/accounts',
                    );
                  }
                }),
              );
            }
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: Container(),
                backgroundColor: Colors.blue,
                flexibleSpace: InkWell(
                  onTap: () => showDialog(
                      // barrierColor: Colors.white,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: AlertDialog(
                            backgroundColor: Colors.white,
                            insetPadding: EdgeInsets.zero,
                            titlePadding: const EdgeInsets.only(
                                right: 150.0,
                                left: 40.0,
                                top: 10.0), // Adjust width here
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            title: const Text('Select Business'),
                            content: const SizedBox(
                              width: 1,
                              height: 1,
                            ),
        
                            actions: [
                              const Divider(),
                              Align(
                                alignment: Alignment.center,
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/add-new-business',
                                        arguments: widget.argus);
                                  },
                                  icon: const Icon(
                                    Icons.person_add,
                                    color: Colors.green,
                                  ),
                                  label: const Text(
                                    'Add New Business',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                        // });
                      }),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: ListTile(
                      onTap: null,
                      title: Text(
                        'Business Name',
                        style: TextStyle(
                            color: Color.fromARGB(255, 237, 235, 235),
                            fontSize: 16),
                      ),
                      subtitle: Row(
                        children: const [
                          Text(
                            '',
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
                              margin:
                                  const EdgeInsets.symmetric(vertical: 20.0),
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                              title: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      backgroundColor: Colors.white,
                                      scrollControlDisabledMaxHeightRatio: 0.3,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                Icons.sort,
                                                size: 30,
                                                weight: 50,
                                                color: Color.fromARGB(
                                                    255, 50, 49, 49),
                                              ),
                                              title: const Text(
                                                'Sort By',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 50, 49, 49),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                          screenSize.width *
                                                              0.09,
                                                      vertical:
                                                          screenSize.height *
                                                              0.001),
                                              paddingInsideChipContainer:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 16.0),
                                              chipsText: const [
                                                'AMOUNT',
                                                'NAME'
                                              ],
                                              separatorCharacter: ";",
                                              selectedChipTextStyle:
                                                  const TextStyle(
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
                                                padding:
                                                    EdgeInsets.only(right: 5.0),
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
                                              unselectedChipDecoration:
                                                  BoxDecoration(
                                                // color: Colors.green,
                                                border: Border.all(
                                                    color: Colors.green,
                                                    width: 1.8),
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              selectedChipDecoration:
                                                  BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            SelectChipsInput(
                                              marginBetweenChips:
                                                  EdgeInsets.symmetric(
                                                horizontal:
                                                    screenSize.width * 0.1,
                                              ),
                                              paddingInsideChipContainer:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 12.0),
                                              chipsText: const [
                                                'RECENT',
                                                'DUE DATE'
                                              ],
                                              separatorCharacter: ";",
                                              selectedChipTextStyle:
                                                  const TextStyle(
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
                                                padding:
                                                    EdgeInsets.only(right: 5.0),
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
                                              unselectedChipDecoration:
                                                  BoxDecoration(
                                                // color: Colors.green,
                                                border: Border.all(
                                                    color: Colors.green,
                                                    width: 1.8),
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              selectedChipDecoration:
                                                  BoxDecoration(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                Icons.sort,
                                                size: 30,
                                                weight: 50,
                                                color: Color.fromARGB(
                                                    255, 50, 49, 49),
                                              ),
                                              title: const Text(
                                                'Filter',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 50, 49, 49),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                          screenSize.width *
                                                              0.09,
                                                      vertical:
                                                          screenSize.height *
                                                              0.01),
                                              paddingInsideChipContainer:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 16.0),
                                              chipsText: const [
                                                'Hide Zero Balance Accounts',
                                                'Hide DND'
                                              ],
                                              separatorCharacter: ";",
                                              selectedChipTextStyle:
                                                  const TextStyle(
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
                                              unselectedChipDecoration:
                                                  BoxDecoration(
                                                // color: Colors.green,
                                                border: Border.all(
                                                    color: Colors.green,
                                                    width: 1.8),
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              selectedChipDecoration:
                                                  BoxDecoration(
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 10.0),
                                      // Customize the appearance and behavior of the tab bar
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 31, 1, 102),
                                          borderRadius:
                                              BorderRadius.circular(30)),
        
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 230, 223, 246),
                                                  child: Icon(
                                                    CupertinoIcons.question,
                                                    size: 50,
                                                    color: Color.fromARGB(
                                                        255, 31, 1, 102),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
                                                ),
                                                const Text(
                                                  'No accounts',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 31, 1, 102),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
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
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 230, 223, 246),
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .search_circle_fill,
                                                    size: 60,
                                                    color: Colors.brown,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
                                                ),
                                                const Text(
                                                  'No Results',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 31, 1, 102),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
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
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 230, 223, 246),
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .search_circle_fill,
                                                    size: 60,
                                                    color: Colors.brown,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
                                                ),
                                                const Text(
                                                  'No Results',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 31, 1, 102),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
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
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 230, 223, 246),
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .search_circle_fill,
                                                    size: 60,
                                                    color: Colors.brown,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
                                                ),
                                                const Text(
                                                  'No Results',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 31, 1, 102),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
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
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 247, 226, 218),
                                                  child: Icon(
                                                    CupertinoIcons.tag_fill,
                                                    size: 60,
                                                    color: Colors.brown,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
                                                ),
                                                const Text(
                                                  'No Tags',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 31, 1, 102),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
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
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 238, 233, 179),
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .person_3_fill,
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
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 230, 223, 246),
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .search_circle_fill,
                                                    size: 60,
                                                    color: Colors.brown,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
                                                ),
                                                const Text(
                                                  'No Results',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 31, 1, 102),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height:
                                                      screenSize.height * 0.01,
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
                  Navigator.pushNamed(
                    context,
                    '/dashboard',
                  );
                } else if (currentPageIndexValue == 1) {
                  Navigator.pushNamed(
                    context,
                    '/invoice',
                  );
                } else if (currentPageIndexValue == 2) {
                  Navigator.pushNamed(
                    context,
                    '/business',
                  );
                } else if (currentPageIndexValue == 3) {
                  Navigator.pushNamed(
                    context,
                    '/accounts',
                  );
                }
              }),
            );
          },
        ),
      ),
    );
  }

  customerTabList(Size screenSize, BusinessListResponseData? selectedBusiness) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        if (state is CustomerListLoadedState) {
          return Container(
            decoration: BoxDecoration(color: Colors.grey[100]),
            height: screenSize.height / 1.2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  EssentialWidgetsCollection.autoScheduleTask(
                    context,
                    taskWaitDuration: Durations.medium3,
                    task: () {
                      double advancedReceivedTemp = 0;
                      double duePendingTemp = 0;
                      for (CustomerResponseData c in state.successData!) {
                        if (((c.amount != null) &&
                            (int.parse(c.amount!).sign == 1))) {
                          advancedReceivedTemp =
                              advancedReceivedTemp + int.parse(c.amount!);
                        } else if (((c.amount != null) &&
                            (int.parse(c.amount!).sign == -1))) {
                          duePendingTemp =
                              duePendingTemp + int.parse(c.amount!);
                        }
                      }
                      setState(() {
                        advancedReceived = advancedReceivedTemp;
                        duePending = duePendingTemp;
                      });
                    },
                  ),
                  ListTile(
                    leading: Text(
                      'UPCOMING DUE ACCOUNTS - ${state.successData?.length ?? 0}',
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
                                      color: Color.fromARGB(255, 50, 49, 49),
                                    ),
                                    title: const Text(
                                      'Sort By',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 50, 49, 49),
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
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey[300],
                                  ),
                                  SelectChipsInput(
                                    marginBetweenChips: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.09,
                                        vertical: screenSize.height * 0.001),
                                    paddingInsideChipContainer:
                                        const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 16.0),
                                    chipsText: const ['AMOUNT', 'NAME'],
                                    separatorCharacter: ";",
                                    selectedChipTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    unselectedChipTextStyle: const TextStyle(
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
                                    widgetContainerDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      color: const Color.fromARGB(
                                          255, 249, 248, 248),
                                    ),
                                    unselectedChipDecoration: BoxDecoration(
                                      // color: Colors.green,
                                      border: Border.all(
                                          color: Colors.green, width: 1.8),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    selectedChipDecoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  SelectChipsInput(
                                    marginBetweenChips: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.1,
                                    ),
                                    paddingInsideChipContainer:
                                        const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 12.0),
                                    chipsText: const ['RECENT', 'DUE DATE'],
                                    separatorCharacter: ";",
                                    selectedChipTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    unselectedChipTextStyle: const TextStyle(
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
                                    widgetContainerDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: const Color.fromARGB(
                                          255, 249, 248, 248),
                                    ),
                                    unselectedChipDecoration: BoxDecoration(
                                      // color: Colors.green,
                                      border: Border.all(
                                          color: Colors.green, width: 1.8),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    selectedChipDecoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(30.0),
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
                                      color: Color.fromARGB(255, 50, 49, 49),
                                    ),
                                    title: const Text(
                                      'Filter',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 50, 49, 49),
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
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey[300],
                                  ),
                                  SelectChipsInput(
                                    marginBetweenChips: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.09,
                                        vertical: screenSize.height * 0.01),
                                    paddingInsideChipContainer:
                                        const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 16.0),
                                    chipsText: const [
                                      'Hide Zero Balance Accounts',
                                      'Hide DND'
                                    ],
                                    separatorCharacter: ";",
                                    selectedChipTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    unselectedChipTextStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    onTap: (p0, p1) {
                                      setState(() {
                                        outputSelectChipsInput = p0;
                                      });
                                    },
                                    widgetContainerDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      color: const Color.fromARGB(
                                          255, 249, 248, 248),
                                    ),
                                    unselectedChipDecoration: BoxDecoration(
                                      // color: Colors.green,
                                      border: Border.all(
                                          color: Colors.green, width: 1.8),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    selectedChipDecoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(30.0),
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
                    height: screenSize.height / 1,
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
                                color: const Color.fromARGB(255, 31, 1, 102),
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
                                _allDataTab(screenSize, state.successData,
                                    selectedBusiness),

                                //tab 2: Today
                                _todayDataTab(screenSize, state.successData),

                                //tab 3: Overdue
                                _overdueDataTab(screenSize, state.successData),

                                //tab 4: UpComing
                                _upcomingDataTab(screenSize, state.successData),

                                //tab 5: Tag
                                _tagDataTab(screenSize, state.successData),
                                //tab 6: Groups
                                _groupDataTab(screenSize, state.successData),

                                //tab 7: DND
                                _dndDataTab(screenSize, state.successData),
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
            ),
          );
        }
        return Container(
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
                                  color: Color.fromARGB(255, 50, 49, 49),
                                ),
                                title: const Text(
                                  'Sort By',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 50, 49, 49),
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
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey[300],
                              ),
                              SelectChipsInput(
                                marginBetweenChips: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.09,
                                    vertical: screenSize.height * 0.001),
                                paddingInsideChipContainer:
                                    const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 16.0),
                                chipsText: const ['AMOUNT', 'NAME'],
                                separatorCharacter: ";",
                                selectedChipTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                unselectedChipTextStyle: const TextStyle(
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
                                widgetContainerDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color:
                                      const Color.fromARGB(255, 249, 248, 248),
                                ),
                                unselectedChipDecoration: BoxDecoration(
                                  // color: Colors.green,
                                  border: Border.all(
                                      color: Colors.green, width: 1.8),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                selectedChipDecoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              SelectChipsInput(
                                marginBetweenChips: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.1,
                                ),
                                paddingInsideChipContainer:
                                    const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 12.0),
                                chipsText: const ['RECENT', 'DUE DATE'],
                                separatorCharacter: ";",
                                selectedChipTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                unselectedChipTextStyle: const TextStyle(
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
                                widgetContainerDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color:
                                      const Color.fromARGB(255, 249, 248, 248),
                                ),
                                unselectedChipDecoration: BoxDecoration(
                                  // color: Colors.green,
                                  border: Border.all(
                                      color: Colors.green, width: 1.8),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                selectedChipDecoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30.0),
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
                                  color: Color.fromARGB(255, 50, 49, 49),
                                ),
                                title: const Text(
                                  'Filter',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 50, 49, 49),
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
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey[300],
                              ),
                              SelectChipsInput(
                                marginBetweenChips: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.09,
                                    vertical: screenSize.height * 0.01),
                                paddingInsideChipContainer:
                                    const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 16.0),
                                chipsText: const [
                                  'Hide Zero Balance Accounts',
                                  'Hide DND'
                                ],
                                separatorCharacter: ";",
                                selectedChipTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                unselectedChipTextStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                onTap: (p0, p1) {
                                  setState(() {
                                    outputSelectChipsInput = p0;
                                  });
                                },
                                widgetContainerDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color:
                                      const Color.fromARGB(255, 249, 248, 248),
                                ),
                                unselectedChipDecoration: BoxDecoration(
                                  // color: Colors.green,
                                  border: Border.all(
                                      color: Colors.green, width: 1.8),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                selectedChipDecoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30.0),
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
                            color: const Color.fromARGB(255, 31, 1, 102),
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
                            _allDataTab(screenSize, [], null),

                            //tab 2: Today
                            _todayDataTab(screenSize, []),

                            //tab 3: Overdue
                            _overdueDataTab(screenSize, []),

                            //tab 4: UpComing
                            _upcomingDataTab(screenSize, []),

                            //tab 5: Tag
                            _tagDataTab(screenSize, []),
                            //tab 6: Groups
                            _groupDataTab(screenSize, []),

                            //tab 7: DND
                            _dndDataTab(screenSize, []),
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
        );
      },
    );
  }

  _groupDataTab(Size screenSize, List<CustomerResponseData>? customerData) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: 30,
            backgroundColor: Color.fromARGB(255, 238, 233, 179),
            child: Icon(
              CupertinoIcons.person_3_fill,
              color: Color.fromARGB(255, 50, 49, 49),
              size: 30,
            )),
        SizedBox(
          height: 20,
        ),
        Text(
          'No group Added!!',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  _dndDataTab(Size screenSize, List<CustomerResponseData>? customerData) {
    return Container(
      color: Colors.grey[100],
      // height: 200,
      // width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color.fromARGB(255, 230, 223, 246),
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
                color: Color.fromARGB(255, 31, 1, 102),
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
                    color: Color.fromARGB(255, 31, 1, 102),
                    fontSize: 12,
                  ),
                ),
                Text(
                  ' change or clear filter/search',
                  style: TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _tagDataTab(Size screenSize, List<CustomerResponseData>? customerData) {
    return Container(
      color: Colors.grey[100],
      // height: 200,
      // width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color.fromARGB(255, 247, 226, 218),
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
                color: Color.fromARGB(255, 31, 1, 102),
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
                    color: Color.fromARGB(255, 31, 1, 102),
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Tag can be anything that is relevant for your business',
                  style: TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _upcomingDataTab(Size screenSize, List<CustomerResponseData>? customerData) {
    return Container(
      color: Colors.grey[100],
      // height: 200,
      // width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color.fromARGB(255, 230, 223, 246),
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
                color: Color.fromARGB(255, 31, 1, 102),
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
                    color: Color.fromARGB(255, 31, 1, 102),
                    fontSize: 12,
                  ),
                ),
                Text(
                  ' change or clear filter/search',
                  style: TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _overdueDataTab(Size screenSize, List<CustomerResponseData>? customerData) {
    return Container(
      color: Colors.grey[100],
      // height: 200,
      // width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color.fromARGB(255, 230, 223, 246),
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
                color: Color.fromARGB(255, 31, 1, 102),
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
                    color: Color.fromARGB(255, 31, 1, 102),
                    fontSize: 12,
                  ),
                ),
                Text(
                  ' change or clear filter/search',
                  style: TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _todayDataTab(Size screenSize, List<CustomerResponseData>? customerData) {
    return Container(
      color: Colors.grey[100],
      // height: 200,
      // width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color.fromARGB(255, 230, 223, 246),
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
                color: Color.fromARGB(255, 31, 1, 102),
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
                    color: Color.fromARGB(255, 31, 1, 102),
                    fontSize: 12,
                  ),
                ),
                Text(
                  ' change or clear filter/search',
                  style: TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  _allDataTab(Size screenSize, List<CustomerResponseData>? customerData,
      BusinessListResponseData? selectedBusiness) {
    if (customerData!.isNotEmpty) {
      return Container(
        color: Colors.grey[100],
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: const WaterDropHeader(
            waterDropColor: Color.fromARGB(255, 31, 1, 102),
            idleIcon: AnimatedImagePlaceholderLoader(),
          ),
          controller: refreshController,
          onRefresh: (() async {
            // monitor network fetch
            await Future.delayed(const Duration(milliseconds: 1000));
            // if failed,use refreshFailed()

            BlocProvider.of<CustomerBloc>(context).add(CustomerListFetchEvent(
                userId: sph.getString("userid")!,
                businessId: selectedBusiness?.id ?? ''));
          }),
          onLoading: (() async {
            await Future.delayed(const Duration(milliseconds: 1000));
            // if failed,use loadFailed(),if no data return,use LoadNodata()

            if (mounted) setState(() {});
            refreshController.loadComplete();
          }),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: customerData.length,
            itemBuilder: (context, index) {
              CustomerResponseData cd = customerData[index];
              // Talker().info(customerData[index].toJson());
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
                    Navigator.pushNamed(context, '/customer-screen-details',
                        arguments: {
                          'customerData': cd,
                          'selectedBusiness': selectedBusiness
                        });
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: const Icon(
                        Icons.person_2_sharp,
                        color: Colors.grey,
                      ),
                    ),
                    title: Text(
                      cd.fullname ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 31, 1, 102),
                      ),
                    ),
                    subtitle: Text(cd.mobile ?? ''),
                    trailing: Column(
                      children: [
                        (cd.amount != null)
                            ? (((double.parse(cd.amount!) > 0))
                                ? Text(
                                    '\u{20B9} ${cd.amount ?? 0}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w700),
                                  )
                                : Text(
                                    '\u{20B9} ${cd.amount ?? 0}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700),
                                  ))
                            : Text(
                                '\u{20B9} ${cd.amount ?? 0}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w700),
                              ),
                        (cd.amount != null)
                            ? ((double.parse(cd.amount!) > 0)
                                ? Text(
                                    'CREDIT',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    'DUE',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ))
                            : Text(
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
        ),
      );
    } else {
      return Container(
        color: Colors.grey[100],
        // height: 200,
        // width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const CircleAvatar(
            //   radius: 30,
            //   backgroundColor: Color.fromARGB(255, 230, 223, 246),
            //   child: Icon(
            //     CupertinoIcons.question,
            //     size: 50,
            //     color: Color.fromARGB(255, 31, 1, 102),
            //   ),
            // ),
            // SizedBox(
            //   height: screenSize.height * 0.01,
            // ),
            const Text(
              'No accounts',
              style: TextStyle(
                  color: Color.fromARGB(255, 31, 1, 102),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            const Text(
              'Add your client/parties to start collecting payments',
              style: TextStyle(
                color: Color.fromARGB(255, 31, 1, 102),
                fontSize: 12,
              ),
            )
          ],
        ),
      );
    }
  }

  addBusiness() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/add-new-business').then((_) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    });
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
