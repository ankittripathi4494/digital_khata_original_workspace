// ignore_for_file: must_be_immutable, unnecessary_to_list_in_spreads, deprecated_member_use, unused_field, unused_local_variable, avoid_print

import 'dart:io';

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/plan/model/plan_list_response_model.dart';
import 'package:dkapp/module/plan/plan_bloc/plan_bloc.dart';
import 'package:dkapp/module/plan/plan_bloc/plan_event.dart';
import 'package:dkapp/module/plan/plan_bloc/plan_state.dart';
import 'package:dkapp/module/recurring/recurring_bloc/recurring_bloc.dart';
import 'package:dkapp/module/recurring/recurring_bloc/recurring_event.dart';
import 'package:dkapp/module/recurring/recurring_bloc/recurring_state.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';
import 'package:http/http.dart' as http;

class RecurringTransactionScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  RecurringTransactionScreen({super.key, required this.argus});

  @override
  State<RecurringTransactionScreen> createState() =>
      _RecurringTransactionScreenState();
}

class _RecurringTransactionScreenState
    extends State<RecurringTransactionScreen> {
  List<Map<String, dynamic>>? dateTimeList;
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  TextEditingController planNameController = TextEditingController();
  TextEditingController planAmountController = TextEditingController();
  TextEditingController planDescController = TextEditingController();
  TextEditingController planStartDateController = TextEditingController();
  TextEditingController planEndDateController = TextEditingController();
  String? _selectedLocation;
  DateTime? planStartDate;
  DateTime? planEndDate;
  int count = 1;
  bool updateStatus = false;
  Map<String, dynamic>? selectedTimeDuration;
  List<Map<String, dynamic>> timeDurationOptions = [
    {'text': 'Daily', 'parameter': 'daily'},
    {'text': 'Weekly', 'parameter': 'weekly'},
    {'text': 'Monthly', 'parameter': 'monthly'},
    {'text': 'Quarterly', 'parameter': 'quarterly'},
    {'text': 'HalfYearly', 'parameter': 'halfyearly'},
    {'text': 'Yearly', 'parameter': 'yearly'},
  ];

  final ImagePicker _picker = ImagePicker();
  XFile? planImage;
  getDataTimeofStartFormat(
      {Map<String, dynamic>? selectedTimeDuration,
      int? dataCount,
      DateTime? planStartDate,
      DateTime? planEndDate,
      String? amount}) {
    List<Map<String, dynamic>> dateTimeList = [];
    switch (selectedTimeDuration!['parameter']) {
      case 'daily':
        for (int i = 0; i < dataCount!; i++) {
          Map<String, dynamic> map = {};
          map['datetime'] = DateTime(
            planStartDate!.year,
            planStartDate.month,
            planStartDate.day,
            planStartDate.hour,
            planStartDate.minute,
          ).add(Duration(days: i));
          map['amount'] = amount;
          dateTimeList.add(map);
        }
        return dateTimeList;
      case 'weekly':
        for (int i = 0; i < dataCount!; i++) {
          Map<String, dynamic> map = {};
          map['datetime'] = DateTime(
            planStartDate!.year,
            planStartDate.month,
            planStartDate.day,
            planStartDate.hour,
            planStartDate.minute,
          ).add(Duration(days: i * 7));
          map['amount'] = amount;
          dateTimeList.add(map);
        }
        return dateTimeList;

      case 'monthly':
        for (int i = 0; i < dataCount!; i++) {
          Map<String, dynamic> map = {};
          map['datetime'] = DateTime(
            planStartDate!.year,
            planStartDate.month + (i * 1),
            planStartDate.day,
            planStartDate.hour,
            planStartDate.minute,
          );

          map['amount'] = amount;
          dateTimeList.add(map);
        }
        return dateTimeList;

      case 'quarterly':
        for (int i = 0; i < dataCount!; i++) {
          Map<String, dynamic> map = {};
          map['datetime'] = DateTime(
            planStartDate!.year,
            planStartDate.month + (i * 3),
            planStartDate.day,
            planStartDate.hour,
            planStartDate.minute,
          );

          map['amount'] = amount;
          dateTimeList.add(map);
        }
        return dateTimeList;

      case 'halfyearly':
        for (int i = 0; i < dataCount!; i++) {
          Map<String, dynamic> map = {};
          map['datetime'] = DateTime(
            planStartDate!.year,
            planStartDate.month + (i * 6),
            planStartDate.day,
            planStartDate.hour,
            planStartDate.minute,
          );

          map['amount'] = amount;
          dateTimeList.add(map);
        }
        return dateTimeList;

      case 'yearly':
        for (int i = 0; i < dataCount!; i++) {
          Map<String, dynamic> map = {};
          map['datetime'] = DateTime(
            planStartDate!.year + (i * 1),
            planStartDate.month,
            planStartDate.day,
            planStartDate.hour,
            planStartDate.minute,
          );

          map['amount'] = amount;
          dateTimeList.add(map);
        }
        return dateTimeList;
    }
  }

  changeDeployDropdown(
      {Map<String, dynamic>? selectedTimeDuration,
      int? dataCount,
      DateTime? planStartDate,
      DateTime? planEndDate}) {
    switch (selectedTimeDuration!['parameter']) {
      case 'daily':
        planEndDate = DateTime(
          planStartDate!.year,
          planStartDate.month,
          planStartDate.day,
          planStartDate.hour,
          planStartDate.minute,
        ).add(Duration(days: dataCount!));

        planEndDateController.text =
            DateFormat('dd-MM-yyyy').format(planEndDate);
      case 'weekly':
        planEndDate = DateTime(
          planStartDate!.year,
          planStartDate.month,
          planStartDate.day,
          planStartDate.hour,
          planStartDate.minute,
        ).add(Duration(days: dataCount! * 7));

        planEndDateController.text =
            DateFormat('dd-MM-yyyy').format(planEndDate);
      case 'monthly':
        planEndDate = DateTime(
          planStartDate!.year,
          planStartDate.month + (dataCount! * 1),
          planStartDate.day,
          planStartDate.hour,
          planStartDate.minute,
        );

        planEndDateController.text =
            DateFormat('dd-MM-yyyy').format(planEndDate);
      case 'quarterly':
        planEndDate = DateTime(
          planStartDate!.year,
          planStartDate.month + (dataCount! * 3),
          planStartDate.day,
          planStartDate.hour,
          planStartDate.minute,
        );

        planEndDateController.text =
            DateFormat('dd-MM-yyyy').format(planEndDate);
      case 'halfyearly':
        planEndDate = DateTime(
          planStartDate!.year,
          planStartDate.month + (dataCount! * 6),
          planStartDate.day,
          planStartDate.hour,
          planStartDate.minute,
        );

        planEndDateController.text =
            DateFormat('dd-MM-yyyy').format(planEndDate);
      case 'yearly':
        planEndDate = DateTime(
          planStartDate!.year + (dataCount! * 1),
          planStartDate.month,
          planStartDate.day,
          planStartDate.hour,
          planStartDate.minute,
        );

        planEndDateController.text =
            DateFormat('dd-MM-yyyy').format(planEndDate);

      default:
    }
  }

  @override
  void initState() {
    (widget.argus.containsKey("selectedPlan"))
        ? fetchSelectedPlan(
            widget.argus["selectedPlan"] as PlanListResponseData)
        : null;
    super.initState();
  }

  fetchSelectedPlan(PlanListResponseData planData) {
    print("Selected Plan:- ${planData.toJson()}");
    BlocProvider.of<PlanBloc>(context).add(PlanDetailFetchEvent(
        businessId:
            (widget.argus['selectedBusiness'] as BusinessListResponseData).id!,
        customerId:
            (widget.argus['customerData'] as SelectedCustomerResponseData).id!,
        userId: sph.getString("userid")!,
        loanPlanId: planData.id!));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Recurring Transaction',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  backgroundColor: Colors.white,
                  scrollControlDisabledMaxHeightRatio: 0.4,
                  showDragHandle: true,
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: screenSize.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.04,
                            ),
                            const Text(
                              'Recurring Entry',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            const Text(
                              'Future Invoices Will Not Be Generated',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.04,
                            ),
                            const Text(
                              'Recurring Entry + Generated Invoices',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            const Text(
                              'Future Invoices Will Not Be Generated',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'Generated Invoices Will Be Cancelled',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'Linked Transactions To This Invoice Will Be Unlinked',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'Generated Cash Out Entry For This Invoice Will Be Removed',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
          child: Column(
            children: [
              widget.argus.containsKey("selectedPlan")
                  ? (BlocBuilder<PlanBloc, PlanState>(
                      builder: (context, state) {
                        if (state is PlanDetailLoadedState) {
                          return EssentialWidgetsCollection.autoScheduleTask(
                              context, task: () {
                            for (Map<String, dynamic> e
                                in timeDurationOptions) {
                              if (e['parameter']
                                      .toString()
                                      .toLowerCase()
                                      .trim() ==
                                  (widget.argus["selectedPlan"]
                                          as PlanListResponseData)
                                      .emiType!
                                      .toLowerCase()
                                      .trim()) {
                                setState(() {
                                  selectedTimeDuration = e;
                                });
                              }
                            }
                            setState(() {
                              planNameController.text =
                                  (widget.argus["selectedPlan"]
                                          as PlanListResponseData)
                                      .title!;
                              planAmountController.text =
                                  (widget.argus["selectedPlan"]
                                          as PlanListResponseData)
                                      .amount!;
                              planDescController.text =
                                  (widget.argus["selectedPlan"]
                                          as PlanListResponseData)
                                      .notes!;
                              count = int.parse((widget.argus["selectedPlan"]
                                      as PlanListResponseData)
                                  .noOfEmi!);
                              // planImage = ((widget.argus["selectedPlan"]
                              //                 as PlanListResponseData)
                              //             .image !=
                              //         null)
                              //     ? (widget.argus["selectedPlan"]
                              //             as PlanListResponseData)
                              //         .image
                              //     : null;
                              planStartDate = DateTime(
                                  DateTime.parse((widget.argus["selectedPlan"]
                                              as PlanListResponseData)
                                          .createdDate
                                          .toString())
                                      .year,
                                  DateTime.parse((widget.argus["selectedPlan"]
                                              as PlanListResponseData)
                                          .createdDate
                                          .toString())
                                      .month,
                                  DateTime.parse((widget.argus["selectedPlan"]
                                              as PlanListResponseData)
                                          .createdDate
                                          .toString())
                                      .day,
                                  DateTime.parse((widget.argus["selectedPlan"]
                                              as PlanListResponseData)
                                          .createdDate
                                          .toString())
                                      .hour,
                                  DateTime.parse((widget.argus["selectedPlan"] as PlanListResponseData).createdDate.toString()).minute);

                              String formattedPlanStartDate =
                                  DateFormat('dd-MM-yyyy HH:mm a')
                                      .format(planStartDate!);
                              planStartDateController.text =
                                  formattedPlanStartDate;
                              planEndDate = planStartDate;
                              String formattedPlanEndDate =
                                  DateFormat('dd-MM-yyyy').format(planEndDate!);
                              planEndDateController.text = formattedPlanEndDate;
                            });

                            changeDeployDropdown(
                                selectedTimeDuration: selectedTimeDuration,
                                dataCount: count,
                                planStartDate: planStartDate,
                                planEndDate: planEndDate);
                          }, taskWaitDuration: Durations.short2);
                        }
                        return Container();
                      },
                    ))
                  : Container(),
              (!widget.argus.containsKey('fromCustomerScreen'))
                  ? Column(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/select-customer');
                          },
                          child: TextFormField(
                            enabled: false,
                            enableInteractiveSelection: false,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 31, 1, 102),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Select Customer',
                              hintStyle: const TextStyle(color: Colors.black),
                              prefixIcon: const Icon(
                                Icons.person_2_outlined,
                                color: Colors.black,
                              ),
                              suffixIcon: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                                size: 18,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              (planNameController.text.isNotEmpty)
                  ? TextFormField(
                      enabled: true,
                      enableInteractiveSelection: false,
                      controller: planNameController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 31, 1, 102),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Plan',
                        hintStyle: const TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                planNameController.text = '';
                                planAmountController.text = '';
                                planDescController.text = '';
                                count = 1;
                                planImage = null;
                                selectedTimeDuration =
                                    (selectedTimeDuration != null)
                                        ? selectedTimeDuration
                                        : timeDurationOptions[2];
                                planStartDate = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  (DateTime.now().minute < 30)
                                      ? DateTime.now().hour
                                      : DateTime.now().hour + 1,
                                  (DateTime.now().minute < 30) ? 30 : 00,
                                );

                                String formattedPlanStartDate =
                                    DateFormat('dd-MM-yyyy HH:mm a')
                                        .format(planStartDate!);
                                planStartDateController.text =
                                    formattedPlanStartDate;
                                planEndDate = planStartDate;
                                String formattedPlanEndDate =
                                    DateFormat('dd-MM-yyyy')
                                        .format(planEndDate!);
                                planEndDateController.text =
                                    formattedPlanEndDate;
                              });
                            },
                            icon: const Icon(Icons.cancel_rounded)),
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
                    )
                  : InkWell(
                      onTap: () async {
                        Navigator.pushNamed(context, '/plan', arguments: {
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
                      },
                      child: TextFormField(
                        enabled: false,
                        enableInteractiveSelection: false,
                        controller: planNameController,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 31, 1, 102),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Plan',
                          hintStyle: const TextStyle(color: Colors.black),
                          suffixIcon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 18,
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
                height: screenSize.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.65),
                child: const Text(
                  'Amount',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              TextFormField(
                enabled: true,
                enableInteractiveSelection: false,
                controller: planAmountController,
                style: const TextStyle(
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                ],
                decoration: InputDecoration(
                  prefixText:
                      planAmountController.text.isEmpty ? '\u{20B9}\t' : null,
                  prefixStyle:
                      const TextStyle(color: Colors.grey, fontSize: 20),
                  hintText: '${0}',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
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
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Repeat Every',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedTimeDuration =
                                (selectedTimeDuration != null)
                                    ? selectedTimeDuration
                                    : timeDurationOptions[2];
                          });
                          showModalBottomSheet<void>(
                            showDragHandle: true,
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  Size screenSize = MediaQuery.of(context).size;
                                  return SizedBox(
                                    width: screenSize.width,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.05),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Center(
                                            child: Text(
                                              'Repeat Every',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: screenSize.height * 0.04),
                                          ...timeDurationOptions.map((option) {
                                            return RadioListTile(
                                              selectedTileColor: Colors.green,
                                              groupValue: selectedTimeDuration,
                                              title: Text(
                                                option['text'],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              value: option,
                                              onChanged: (v) {
                                                setState(() {
                                                  count = 1;
                                                  selectedTimeDuration = v;
                                                });
                                                changeDeployDropdown(
                                                    selectedTimeDuration:
                                                        selectedTimeDuration,
                                                    dataCount: count,
                                                    planStartDate:
                                                        planStartDate,
                                                    planEndDate: planEndDate);
                                              },
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .trailing,
                                              activeColor: Colors.green,
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ).then((c) {
                            setState(() {});
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.06,
                                vertical: screenSize.height * 0.014),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (selectedTimeDuration != null)
                                      ? selectedTimeDuration!['text']
                                      : 'Monthly',
                                  style: const TextStyle(
                                      // fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.05,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                  size: 20,
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Repeat For',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.01,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.01,
                              vertical: screenSize.height * 0.0005),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (count >= 2) {
                                    setState(() {
                                      count--;
                                    });
                                    changeDeployDropdown(
                                        selectedTimeDuration:
                                            selectedTimeDuration,
                                        dataCount: count,
                                        planStartDate: planStartDate,
                                        planEndDate: planEndDate);
                                  } else {
                                    setState(() {
                                      count = 1;
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05,
                              ),
                              Text(
                                count.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    count++;
                                  });
                                  changeDeployDropdown(
                                      selectedTimeDuration:
                                          selectedTimeDuration,
                                      dataCount: count,
                                      planStartDate: planStartDate,
                                      planEndDate: planEndDate);
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ],
                          )),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.65),
                child: const Text(
                  'Start From',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                onTap: () async {
                  showDatePicker(
                    context: context,

                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    // firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          primarySwatch: Colors.grey,
                          splashColor: Colors.black,
                          colorScheme: const ColorScheme.light(
                            primary: Colors.white,
                            onSecondary: Colors.black,
                            onPrimary: Colors.black,
                            surface: Color.fromARGB(255, 31, 1, 102),
                            surfaceVariant: Colors.grey,
                            onSurface: Colors.white,
                          ),
                          dialogBackgroundColor: Colors.white,
                        ),
                        child: child!,
                      );
                    },
                    // currentDate: DateTime(DateTime.january),
                  ).then((c) {
                    setState(() {
                      planStartDate = DateTime(
                        c!.year,
                        c.month,
                        c.day,
                        (DateTime.now().minute < 30)
                            ? DateTime.now().hour
                            : DateTime.now().hour + 1,
                        (DateTime.now().minute < 30) ? 30 : 00,
                      );

                      String formattedPlanStartDate =
                          DateFormat('dd-MM-yyyy HH:mm a')
                              .format(planStartDate!);
                      planStartDateController.text = formattedPlanStartDate;
                    });
                  });
                },
                child: TextFormField(
                  enabled: false,
                  enableInteractiveSelection: false,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 31, 1, 102),
                  ),
                  controller: planStartDateController,
                  decoration: InputDecoration(
                    hintText: '24-05-2024 10:30 AM',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 114, 113, 113),
                      fontSize: 15.0,
                    ),
                    suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.05,
                            vertical: screenSize.height * 0.01),
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: Color.fromARGB(255, 96, 96, 96),
                        )),
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
                height: screenSize.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(right: screenSize.width * 0.1),
                          child: const Text(
                            'End On',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            showDatePicker(
                              context: context,

                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              // firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData(
                                    primarySwatch: Colors.grey,
                                    splashColor: Colors.black,
                                    colorScheme: const ColorScheme.light(
                                      primary: Colors.white,
                                      onSecondary: Colors.black,
                                      onPrimary: Colors.black,
                                      surface: Color.fromARGB(255, 31, 1, 102),
                                      surfaceVariant: Colors.grey,
                                      onSurface: Colors.white,
                                    ),
                                    dialogBackgroundColor: Colors.white,
                                  ),
                                  child: child!,
                                );
                              },
                              // currentDate: DateTime(DateTime.january),
                            ).then((c) {
                              setState(() {
                                planEndDate = c;
                                String formattedPlanEndDate =
                                    DateFormat('dd-MM-yyyy')
                                        .format(planEndDate!);
                                planEndDateController.text =
                                    formattedPlanEndDate;
                              });
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.01),
                            child: TextFormField(
                              enabled: false,
                              enableInteractiveSelection: false,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                              controller: planEndDateController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.017,
                                    horizontal: screenSize.width * 0.03),
                                hintText: '24-05-2024',
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 114, 113, 113),
                                  fontSize: 15.0,
                                ),
                                suffixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.05,
                                        vertical: screenSize.height * 0.01),
                                    child: const Icon(
                                      Icons.calendar_month_rounded,
                                      color: Color.fromARGB(255, 96, 96, 96),
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                    )),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(right: screenSize.width * 0.15),
                          child: const Text(
                            'Name',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.02),
                          child: TextFormField(
                            controller: planNameController,
                            cursorColor: const Color.fromARGB(255, 31, 1, 102),
                            showCursor: true,
                            canRequestFocus: true,
                            enabled: true,
                            enableInteractiveSelection: true,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 31, 1, 102),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.017,
                                  horizontal: screenSize.width * 0.03),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ],
                      //   ),
                      // ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.69),
                child: const Text(
                  'Remarks',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              (planImage != null)
                  ? Padding(
                      padding: EdgeInsets.only(right: screenSize.width * 0.69),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              EssentialWidgetsCollection.showAlertDialog(
                                  context,
                                  icon: const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Choose Option",
                                        style: TextStyle(
                                            fontSize: 18,
                                            letterSpacing: 1.2,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      Divider(color: Colors.green, thickness: 2)
                                    ],
                                  ),
                                  title: TextButton.icon(
                                    onPressed: () async {
                                      _picker
                                          .pickImage(
                                              maxHeight: 480,
                                              maxWidth: 640,
                                              source: ImageSource.camera)
                                          .then((c) {
                                        setState(() {
                                          planImage = c;
                                        });
                                        Talker().info(
                                            "Captured Image From Camera :- ${planImage!.path}");
                                        Navigator.pop(context);
                                      });
                                    },
                                    label: const Text(
                                      "Camera",
                                      style: TextStyle(
                                          fontSize: 16,
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black),
                                    ),
                                    icon: const Icon(
                                      Icons.camera,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                  content: TextButton.icon(
                                      onPressed: () {
                                        _picker
                                            .pickImage(
                                                maxHeight: 480,
                                                maxWidth: 640,
                                                source: ImageSource.gallery)
                                            .then((c) {
                                          setState(() {
                                            planImage = c;
                                          });
                                          Talker().info(
                                              "Captured Image From gallery :- ${planImage!.path}");
                                          Navigator.pop(context);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.image_search,
                                        size: 25,
                                        color: Colors.black,
                                      ),
                                      label: const Text(
                                        "Gallery",
                                        style: TextStyle(
                                            fontSize: 16,
                                            letterSpacing: 1.2,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black),
                                      )));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              margin: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.01),
                              color: Colors.grey[100],
                              child: Image.file(File(planImage!.path)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    planImage = null;
                                  });
                                },
                                icon: const Icon(
                                  Icons.cancel_rounded,
                                  size: 40,
                                  color: Colors.grey,
                                )),
                          )
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        EssentialWidgetsCollection.showAlertDialog(context,
                            icon: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Choose Option",
                                  style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Divider(color: Colors.green, thickness: 2)
                              ],
                            ),
                            title: TextButton.icon(
                              onPressed: () async {
                                _picker
                                    .pickImage(
                                        maxHeight: 480,
                                        maxWidth: 640,
                                        source: ImageSource.camera)
                                    .then((c) {
                                  setState(() {
                                    planImage = c;
                                  });
                                  Talker().info(
                                      "Captured Image From Camera :- ${planImage!.path}");
                                  Navigator.pop(context);
                                });
                              },
                              label: const Text(
                                "Camera",
                                style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                              icon: const Icon(
                                Icons.camera,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                            content: TextButton.icon(
                                onPressed: () {
                                  _picker
                                      .pickImage(
                                          maxHeight: 480,
                                          maxWidth: 640,
                                          source: ImageSource.gallery)
                                      .then((c) {
                                    setState(() {
                                      planImage = c;
                                    });
                                    Talker().info(
                                        "Captured Image From gallery :- ${planImage!.path}");
                                    Navigator.pop(context);
                                  });
                                },
                                icon: const Icon(
                                  Icons.image_search,
                                  size: 25,
                                  color: Colors.black,
                                ),
                                label: const Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                )));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(right: screenSize.width * 0.69),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.01),
                          color: Colors.grey[100],
                          surfaceTintColor: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          shadowColor: const Color.fromARGB(255, 203, 202, 202),
                          elevation: 2.0,
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.download_for_offline_rounded,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                                Text(
                                  'Add New',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              TextFormField(
                enabled: true,
                controller: planDescController,
                scrollPadding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.1),
                enableInteractiveSelection: true,
                maxLength: 100,
                minLines: 5,
                maxLines: 10,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1000),
                ],
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                style: const TextStyle(
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                decoration: InputDecoration(
                  hintText: 'Add a note',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 114, 113, 113),
                    fontSize: 15.0,
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
              SizedBox(
                height: screenSize.height * 0.1,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          previewPart(context, screenSize);
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 31, 1, 102),
          ),
          padding: EdgeInsets.symmetric(
              vertical: screenSize.height * 0.015,
              horizontal: screenSize.width * 0.27),
          child: const Text(
            'Preview and SAVE',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Future<void> previewPart(BuildContext context, Size screenSize) {
    dateTimeList = getDataTimeofStartFormat(
        selectedTimeDuration: selectedTimeDuration,
        dataCount: count,
        planStartDate: DateFormat("dd-MM-yyyy hh:mm a")
            .parse(planStartDateController.text),
        planEndDate: DateFormat("dd-MM-yyyy").parse(planEndDateController.text),
        amount: planAmountController.text);
    return showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      scrollControlDisabledMaxHeightRatio: 0.9,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: true,
          child: PreviewScreen(
              planAmountController: planAmountController,
              count: count,
              planStartDateController: planStartDateController,
              planEndDateController: planEndDateController,
              dateTimeList: dateTimeList,
              widget: widget,
              sph: sph,
              planNameController: planNameController,
              planDescController: planDescController,
              selectedTimeDuration: selectedTimeDuration,
              planImage: planImage),
        );
      },
    );
  }

  Future<void> updateRecurringTransactionPart(BuildContext context) async {}
}

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({
    super.key,
    required this.planAmountController,
    required this.count,
    required this.planStartDateController,
    required this.planEndDateController,
    required this.dateTimeList,
    required this.widget,
    required this.sph,
    required this.planNameController,
    required this.planDescController,
    required this.selectedTimeDuration,
    required this.planImage,
  });

  final TextEditingController planAmountController;
  final int count;
  final TextEditingController planStartDateController;
  final TextEditingController planEndDateController;
  final List<Map<String, dynamic>>? dateTimeList;
  final RecurringTransactionScreen widget;
  final SharedPreferencesHelper sph;
  final TextEditingController planNameController;
  final TextEditingController planDescController;
  final Map<String, dynamic>? selectedTimeDuration;
  final XFile? planImage;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Billing Calander',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SizedBox(
        width: screenSize.width,
        child: Column(
          children: [
            BlocBuilder<RecurringBloc, RecurringState>(
              builder: (context, state) {
                if (state is AddNewRecurringTransactionSuccessState) {
                  return EssentialWidgetsCollection.autoScheduleTask(
                    context,
                    taskWaitDuration: Durations.medium3,
                    task: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, '/customer-screen-details',
                          arguments: {
                            'customerData': (widget.argus['customerData']
                                as SelectedCustomerResponseData),
                            'selectedBusiness':
                                (widget.argus['selectedBusiness']
                                    as BusinessListResponseData),
                          });
                      EssentialWidgetsCollection.showSuccessSnackbar(context,
                          description: state.successMessage);
                    },
                  );
                }
                if (state is AddNewRecurringTransactionFailedState) {
                  return EssentialWidgetsCollection.autoScheduleTask(
                    context,
                    taskWaitDuration: Durations.medium3,
                    task: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, '/recurring-transaction',
                          arguments: widget.argus);
                      EssentialWidgetsCollection.showErrorSnackbar(context,
                          description: state.failedMessage);
                    },
                  );
                }
                if (state is AddNewRecurringTransactionLoadingState) {
                  return const AnimatedImageLoader();
                } 
                return Container();
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Billing Calander',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        (double.parse(planAmountController.text) * count)
                            .toStringAsFixed(2),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Transactions',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        count.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "${DateFormat('dd-MM-yyyy').format(DateFormat("dd-MM-yyyy hh:mm a").parse(planStartDateController.text))} - ${planEndDateController.text}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dateTimeList!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd-MM-yyyy\nhh:mm a')
                                .format(dateTimeList![index]["datetime"]),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "\u{20B9} ${dateTimeList![index]["amount"]}",
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
        child: TextButton(
            style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                backgroundColor: const Color.fromARGB(255, 31, 1, 102),
                minimumSize: Size(screenSize.width, screenSize.height * 0.05)),
            onPressed: () async {
              BlocProvider.of<RecurringBloc>(context).add(
                  AddRecurringTransactionEvent(
                      customerId: (widget.argus['customerData']
                              as SelectedCustomerResponseData)
                          .id!,
                      userId: sph.getString("userid")!,
                      businessId: (widget.argus['selectedBusiness']
                              as BusinessListResponseData)
                          .id!,
                      planTitle: planNameController.text,
                      planAmount: planAmountController.text,
                      planNotes: planDescController.text,
                      planType: selectedTimeDuration!['parameter'],
                      noOfEmis: count.toString(),
                      planStartDate: DateFormat('yyyy-MM-dd').format(
                          DateFormat("dd-MM-yyyy hh:mm a")
                              .parse(planStartDateController.text)),
                      planEndDate: DateFormat('yyyy-MM-dd').format(
                          DateFormat("dd-MM-yyyy")
                              .parse(planEndDateController.text))));
              // await updateTranPart(context);
            },
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  Future<void> updateTranPart(BuildContext context) async {
    print("Data");
    try {
      var requestForImage = http.MultipartRequest(
          'POST',
          Uri.http(
              APIPathList.mainDomain, APIPathList.createRecurringTransaction));
      requestForImage.fields['branch_id'] =
          (widget.argus['selectedBusiness'] as BusinessListResponseData).id!;
      requestForImage.fields['token'] = 'bnbuujn';
      requestForImage.fields['user_id'] = sph.getString("userid")!;
      requestForImage.fields['customer_id'] =
          (widget.argus['customerData'] as SelectedCustomerResponseData).id!;
      requestForImage.fields['title'] = planNameController.text;
      requestForImage.fields['amount'] = planAmountController.text;
      requestForImage.fields['notes'] = planDescController.text;
      requestForImage.fields['emi_type'] = selectedTimeDuration!['parameter'];
      requestForImage.fields['no_of_EMI'] = count.toString();
      requestForImage.fields['start_date'] = DateFormat('yyyy-MM-dd').format(
          DateFormat("dd-MM-yyyy hh:mm a").parse(planStartDateController.text));
      requestForImage.fields['end_date'] = DateFormat('yyyy-MM-dd')
          .format(DateFormat("dd-MM-yyyy").parse(planEndDateController.text));

      requestForImage.headers["HTTP_AUTHORIZATION"] =
          '${DateTime.now().millisecondsSinceEpoch}';

      if ((planImage != null)) {
        requestForImage.files
            .add(await http.MultipartFile.fromPath("images", planImage!.path));
      } else {
        requestForImage.files
            .add(http.MultipartFile.fromBytes("images", [], filename: ''));
      }

      var responsePlanImage = await requestForImage.send();
      if (responsePlanImage.statusCode == 200) {
        Talker().info("Image uplodade success with plan Creation");
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/customer-screen-details',
            arguments: {
              'customerData': (widget.argus['customerData']
                  as SelectedCustomerResponseData),
              'selectedBusiness': (widget.argus['selectedBusiness']
                  as BusinessListResponseData),
            });
        EssentialWidgetsCollection.autoScheduleTask(
          context,
          taskWaitDuration: Durations.medium3,
          task: () {
            EssentialWidgetsCollection.showSuccessSnackbar(context,
                description: responsePlanImage.reasonPhrase!);
          },
        );
      } else {
        EssentialWidgetsCollection.autoScheduleTask(
          context,
          taskWaitDuration: Durations.medium3,
          task: () {
            EssentialWidgetsCollection.showErrorSnackbar(context,
                description:
                    'Request failed with status: ${responsePlanImage.statusCode}.');
          },
        );
      }
    } on PlatformException {
      EssentialWidgetsCollection.autoScheduleTask(
        context,
        taskWaitDuration: Durations.medium3,
        task: () {
          EssentialWidgetsCollection.showErrorSnackbar(context,
              description: 'Failed to get platform version.');
        },
      );
    }
  }
}
