// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/tax/model/tax_list_response_model.dart';
import 'package:dkapp/module/tax/tax_bloc/tax_bloc.dart';
import 'package:dkapp/module/tax/tax_bloc/tax_event.dart';
import 'package:dkapp/module/tax/tax_bloc/tax_state.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaxScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  TaxScreen({super.key, required this.argus});

  @override
  State<TaxScreen> createState() => _TaxScreenState();
}

class _TaxScreenState extends State<TaxScreen> {
  late SharedPreferencesHelper sph;
  TaxListResponseData? selectedTaxListResponseData;
  late TaxBloc taxBloc;
  List<TaxListResponseData> taxListResponseData = [];
  @override
  void initState() {
    super.initState();
    sph = SharedPreferencesHelper();

    fetchSelectedTax();
  }

  fetchSelectedTax() {
    if (widget.argus.containsKey("taxData")) {
      LoggerUtil().errorData(
          "taxData exist with ${(widget.argus["taxData"] as TaxListResponseData).toJson()}");

      taxBloc = TaxBloc()
        ..add(ToggleTaxSelection(
            customerId:
                (widget.argus['customerData'] as SelectedCustomerResponseData)
                    .id!,
            userId: sph.getString("userid")!,
            businessId:
                (widget.argus['selectedBusiness'] as BusinessListResponseData)
                    .id!,
            tax: (widget.argus["taxData"] as TaxListResponseData)));
    } else {
      taxBloc = TaxBloc()
        ..add(
          TaxListFetchEvent(
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
          'Tax',
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
          create: (_) => taxBloc,
          child: BlocBuilder<TaxBloc, TaxState>(
            builder: (context, state) {
              if (state is TaxListLoadingState) {
                return Center(child: AnimatedImageLoader());
              } else if (state is TaxListLoadedState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.successData!.length,
                  itemBuilder: (context, index) {
                    final taxData = state.successData![index];
                    LoggerUtil().criticalData(taxData.toJson());
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
                          selected: (taxData.isSelected == null)
                              ? false
                              : taxData.isSelected!,
                          activeColor: Colors.green,
                          controlAffinity: ListTileControlAffinity.trailing,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.01),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                taxData.title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '${taxData.amount!} %',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                    fontSize: 20),
                              )
                            ],
                          ),
                          value: taxData.isSelected,
                          checkboxShape: const CircleBorder(
                              side: BorderSide(color: Colors.green, width: 2),
                              eccentricity: 0.8),
                          onChanged: (value) {
                            Navigator.pop(context, taxData);
                          },
                        ),
                      ),
                    );
                  },
                );
              } else if (state is TaxListFailedState) {
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
                create: (context) => TaxBloc(),
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
  TextEditingController taxNameController = TextEditingController();
  TextEditingController taxAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<TaxBloc, TaxState>(
            builder: (context, state) {
              if (state is AddNewTaxSuccessState) {
                return EssentialWidgetsCollection.autoScheduleTask(
                  context,
                  taskWaitDuration: Durations.medium4,
                  task: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/tax', arguments: {
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
                        description: "Tax created Successfully");
                  },
                );
              }
              if (state is AddNewTaxFailedState) {
                return EssentialWidgetsCollection.autoScheduleTask(
                  context,
                  taskWaitDuration: Durations.medium4,
                  task: () {
                    Navigator.pop(context);
                    EssentialWidgetsCollection.showErrorSnackbar(context,
                        description: "Tax creation failed");
                  },
                );
              }
              if (state is AddNewTaxLoadingState) {
                return Center(
                  child: AnimatedImageLoader(),
                );
              }
              return Container();
            },
          ),
          const Center(
            child: Text(
              'Add New Tax',
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
              'Tax Name',
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
              controller: taxNameController,
              // autofocus: true,
              enabled: true,
              enableInteractiveSelection: true,
              style: const TextStyle(
                color: Color.fromARGB(255, 31, 1, 102),
              ),
              decoration: InputDecoration(
                hintText: 'Tax Name',
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
              'Tax Percentage',
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
              controller: taxAmountController,
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
                prefixIcon: const Icon(FontAwesomeIcons.percent),
                prefixIconColor: Colors.grey,
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
                BlocProvider.of<TaxBloc>(context).add(AddTaxEvent(
                  customerId: (widget.argus['customerData']
                          as SelectedCustomerResponseData)
                      .id!,
                  userId: sph.getString("userid")!,
                  businessId: (widget.argus['selectedBusiness']
                          as BusinessListResponseData)
                      .id!,
                  taxTitle: taxNameController.text,
                  taxAmount: taxAmountController.text,
                ));
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
