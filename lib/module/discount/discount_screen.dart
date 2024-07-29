// ignore_for_file: must_be_immutable, library_private_types_in_public_api, avoid_print

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/discount/discount_bloc/discount_bloc.dart';
import 'package:dkapp/module/discount/discount_bloc/discount_event.dart';
import 'package:dkapp/module/discount/discount_bloc/discount_state.dart';
import 'package:dkapp/module/discount/model/discount_list_response_model.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DiscountScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  DiscountScreen({super.key, required this.argus});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  late SharedPreferencesHelper sph;
  DiscountListResponseData? selectedDiscountListResponseData;
  late DiscountBloc discountBloc;
  bool selectedDiscount = false;
  List<DiscountListResponseData> discountListResponseData = [];

  @override
  void initState() {
    super.initState();
    sph = SharedPreferencesHelper();

    fetchSelectedDiscount();
  }

  fetchSelectedDiscount() {
    if (widget.argus.containsKey("discountData")) {
      LoggerUtil().errorData(
          "discountData exist with ${(widget.argus["discountData"] as DiscountListResponseData).toJson()}");
      discountBloc = DiscountBloc()
        ..add(ToggleDiscountSelection(
            customerId:
                (widget.argus['customerData'] as SelectedCustomerResponseData)
                    .id!,
            userId: sph.getString("userid")!,
            businessId:
                (widget.argus['selectedBusiness'] as BusinessListResponseData)
                    .id!,
            discount:
                (widget.argus["discountData"] as DiscountListResponseData)));
    } else {
      discountBloc = DiscountBloc()
        ..add(
          DiscountListFetchEvent(
            customerId:
                (widget.argus['customerData'] as SelectedCustomerResponseData)
                    .id!,
            userId: sph.getString("userid")!,
            businessId:
                (widget.argus['selectedBusiness'] as BusinessListResponseData)
                    .id!,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Discount',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
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
                size: 25,
              ))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
        child: BlocProvider(
          create: (_) => discountBloc,
          child: BlocBuilder<DiscountBloc, DiscountState>(
            builder: (context, state) {
              if (state is DiscountListLoadingState) {
                return Center(child: AnimatedImageLoader());
              } else if (state is DiscountListLoadedState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.successData!.length,
                  itemBuilder: (context, index) {
                    final discountData = state.successData![index];
                    LoggerUtil().criticalData(discountData.toJson());
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.01,
                          horizontal: screenSize.width * 0.03),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 203, 202, 202),
                                blurRadius: 6.0,
                                offset: Offset(0.0, 0.1))
                          ],
                          color: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.02),
                        child: CheckboxListTile(
                          selected: (discountData.isSelected == null)
                              ? false
                              : discountData.isSelected!,
                          activeColor: Colors.green,
                          controlAffinity: ListTileControlAffinity.trailing,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.01),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                discountData.title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                (discountData.disType == 'A')
                                    ? '\u{20B9} ${discountData.amount!}'
                                    : '${discountData.amount!} %',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                    fontSize: 20),
                              )
                            ],
                          ),
                          value: discountData.isSelected,
                          checkboxShape: const CircleBorder(
                              side: BorderSide(
                                  color: Colors.green, width: 2),
                              eccentricity: 0.8),
                          onChanged: (value) {
                            Navigator.pop(context, discountData);
                          },
                        ),
                      ),
                    );
                  },
                );
              } else if (state is DiscountListFailedState) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(255, 210, 208, 208),
                          width: 1.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 203, 202, 202),
                          blurRadius: 1.0,
                          offset: Offset(0.0, 0.1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.03,
                      vertical: screenSize.height * 0.01,
                    ),
                    child: Image.asset(
                      "resources/images/empty-folder.png",
                      height: screenSize.height * 0.1,
                    ),
                  ),
                );
              } else {
                return Center(child: AnimatedImageLoader());
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 31, 1, 102),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        onPressed: () {
          showModalBottomSheet<void>(
            backgroundColor: Colors.white,
            scrollControlDisabledMaxHeightRatio: 0.55,
            showDragHandle: true,
            context: context,
            builder: (BuildContext context) {
              return BlocProvider(
                create: (context) => DiscountBloc(),
                child: ModelSheetAddedForm(
                  argus: widget.argus,
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 50,
        ),
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
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
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
      // textTheme: theme.textTheme
      //     .copyWith(bodyLarge: const TextStyle(color: Colors.white)
      // )
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

class ModelSheetAddedForm extends StatefulWidget {
  late Map<String, dynamic> argus;
  ModelSheetAddedForm({super.key, required this.argus});

  @override
  _ModelSheetAddedFormState createState() => _ModelSheetAddedFormState();
}

class _ModelSheetAddedFormState extends State<ModelSheetAddedForm> {
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  bool? isPercent;
  int initIndex = 1;
  TextEditingController discountNameController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<DiscountBloc, DiscountState>(
            builder: (context, state) {
              if (state is AddNewDiscountSuccessState) {
                return EssentialWidgetsCollection.autoScheduleTask(
                  context,
                  taskWaitDuration: Durations.medium4,
                  task: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/discount',
                        arguments: {
                          'customerData': (widget.argus['customerData']
                              as SelectedCustomerResponseData),
                          'selectedBusiness': (widget.argus['selectedBusiness']
                              as BusinessListResponseData),
                          "updatePlan": true,
                          'fromCustomerScreen':
                              (widget.argus.containsKey('fromCustomerScreen'))
                                  ? true
                                  : false
                        });
                    EssentialWidgetsCollection.showSuccessSnackbar(context,
                        description: "Discount created Successfully");
                  },
                );
              }
              if (state is AddNewDiscountFailedState) {
                return EssentialWidgetsCollection.autoScheduleTask(
                  context,
                  taskWaitDuration: Durations.medium4,
                  task: () {
                    Navigator.pop(context);
                    EssentialWidgetsCollection.showErrorSnackbar(context,
                        description: "Discount creation failed");
                  },
                );
              }
              if (state is AddNewDiscountLoadingState) {
                return Center(
                  child: AnimatedImageLoader(),
                );
              }
              return Container();
            },
          ),
          const Center(
            child: Text(
              'Add New Discount',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.05,
                vertical: screenSize.height * 0.03),
            child: const Text(
              'Discount Name',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          // SizedBox(
          //   height: screenSize.height * 0.03,
          // ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
            ),
            child: TextFormField(
              controller: discountNameController,
              // autofocus: true,
              enabled: true,
              enableInteractiveSelection: true,
              style: const TextStyle(
                color: Color.fromARGB(255, 31, 1, 102),
              ),
              decoration: InputDecoration(
                hintText: 'Discount Name',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 31, 1, 102),
                    )),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: const Text(
              'Discount Value',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
            ),
            child: TextFormField(
              controller: discountAmountController,
              // autofocus: true,
              enabled: true,
              enableInteractiveSelection: true,
              style: const TextStyle(
                color: Color.fromARGB(255, 31, 1, 102),
              ),

              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.01,
                    horizontal: screenSize.width * 0.03),
                prefixIcon: Icon((isPercent == true)
                    ? FontAwesomeIcons.percent
                    : FontAwesomeIcons.indianRupeeSign),
                prefixIconColor: Colors.grey,
                suffixIcon: ToggleSwitch(
                  minWidth: 40.0,
                  minHeight: 30.0,
                  initialLabelIndex: initIndex,
                  cornerRadius: 0.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  activeBgColor: const [Colors.green],
                  totalSwitches: 2,
                  icons: const [
                    FontAwesomeIcons.indianRupeeSign,
                    FontAwesomeIcons.percent,
                  ],
                  iconSize: 30.0,
                  borderWidth: 2.0,
                  borderColor: const [Colors.transparent],
                  onToggle: (index) {
                    print('switched to: $index');
                    if (index == 0) {
                      setState(() {
                        isPercent = false;
                        initIndex = index!;
                      });
                    } else {
                      setState(() {
                        isPercent = true;
                        initIndex = index!;
                      });
                    }
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 31, 1, 102),
                    )),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.05,
          ),
          Center(
            child: InkWell(
              onTap: () {
                BlocProvider.of<DiscountBloc>(context).add(AddDiscountEvent(
                    customerId: (widget.argus['customerData']
                            as SelectedCustomerResponseData)
                        .id!,
                    userId: sph.getString("userid")!,
                    businessId: (widget.argus['selectedBusiness']
                            as BusinessListResponseData)
                        .id!,
                    discountTitle: discountNameController.text,
                    discountAmount: discountAmountController.text,
                    discountType: (isPercent == true) ? 'P' : 'A'));
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.4,
                    vertical: screenSize.height * 0.016),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 31, 1, 102),
                    borderRadius: BorderRadius.circular(10.0)),
                child: const Text(
                  'SAVE',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
