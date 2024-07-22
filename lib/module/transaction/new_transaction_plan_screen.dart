// ignore_for_file: must_be_immutable, unnecessary_to_list_in_spreads

import 'dart:io';
import 'dart:async' as t1;
import 'package:dkapp/global_blocs/internet/internet_cubit.dart';
import 'package:dkapp/global_blocs/internet/internet_state.dart';
import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/plan/plan_bloc/plan_bloc.dart';
import 'package:dkapp/module/plan/plan_bloc/plan_event.dart';
import 'package:dkapp/module/plan/plan_bloc/plan_state.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talker/talker.dart';

class NewTransactionPlanScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  NewTransactionPlanScreen({super.key, required this.argus});

  @override
  State<NewTransactionPlanScreen> createState() =>
      _NewTransactionPlanScreenState();
}

class _NewTransactionPlanScreenState extends State<NewTransactionPlanScreen> {
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  int count = 1;
  TextEditingController planNameController = TextEditingController();
  TextEditingController planAmountController = TextEditingController();
  TextEditingController planDescController = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetLost) {
          t1.Timer(Durations.medium2, () {
            Navigator.pushReplacementNamed(
              context,
              '/no-internet',
            );
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/invoice');
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            'New Transaction Plan',
            style: TextStyle(color: Colors.white, fontSize: 25),
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
        body: BlocBuilder<PlanBloc, PlanState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(color: Colors.grey[100]),
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.height * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (state is AddNewPlanSuccessState)
                        ? EssentialWidgetsCollection.autoScheduleTask(
                            context,
                            taskWaitDuration: Durations.medium3,
                            task: () {
                              Talker().info(
                                  "Success Message:- ${state.successMessage}");
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(context, '/plan',
                                  arguments: {
                                    'customerData':
                                        (widget.argus['customerData']
                                            as SelectedCustomerResponseData),
                                    'selectedBusiness':
                                        (widget.argus['selectedBusiness']
                                            as BusinessListResponseData),
                                    'fromCustomerScreen': (widget.argus
                                            .containsKey('fromCustomerScreen'))
                                        ? true
                                        : false,
                                    "updatePlan": true
                                  });
                              EssentialWidgetsCollection.showSuccessSnackbar(
                                  context,
                                  description: "Plan Created Successfully");
                            },
                          )
                        : Container(),
                    (state is AddNewPlanFailedState)
                        ? EssentialWidgetsCollection.autoScheduleTask(
                            context,
                            taskWaitDuration: Durations.medium3,
                            task: () {
                              Navigator.pushReplacementNamed(
                                  context, '/new-transaction-plan',
                                  arguments: widget.argus);
                              EssentialWidgetsCollection.showErrorSnackbar(
                                  context,
                                  description: state.failedMessage);
                            },
                          )
                        : Container(),
                    (state is AddNewPlanLoadingState)
                        ? AnimatedImageLoader(
                            indicatorType: null,
                            loaderType: LoaderType.placeholder,
                          )
                        : Container(),
                    const Text(
                      'Title',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    TextFormField(
                      cursorColor: const Color.fromARGB(255, 31, 1, 102),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 31, 1, 102),
                      ),
                      keyboardType: TextInputType.name,
                      controller: planNameController,
                      decoration: InputDecoration(
                          hintText: 'Example Bike loan',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              // Color.fromARGB(255, 31, 1, 102),
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.03,
                    ),
                    const Text(
                      'Amount',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    TextFormField(
                      cursorColor: const Color.fromARGB(255, 31, 1, 102),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 31, 1, 102),
                      ),
                      controller: planAmountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      ],
                      decoration: InputDecoration(
                          prefixText: planAmountController.text.isEmpty
                              ? '\u{20B9}\t'
                              : null,
                          prefixStyle:
                              const TextStyle(color: Colors.grey, fontSize: 20),
                          hintText: '${0}',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 20),
                          border: OutlineInputBorder(
                              // Color.fromARGB(255, 31, 1, 102),
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                          : timeDurationOptions.elementAt(2);
                                });
                                showModalBottomSheet<void>(
                                  showDragHandle: true,
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        Size screenSize =
                                            MediaQuery.of(context).size;
                                        return SizedBox(
                                          width: screenSize.width,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    screenSize.width * 0.05),
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: screenSize.height *
                                                        0.04),
                                                ...timeDurationOptions
                                                    .map((option) {
                                                  return RadioListTile(
                                                    selectedTileColor:
                                                        Colors.green,
                                                    groupValue:
                                                        selectedTimeDuration,
                                                    title: Text(
                                                      option['text'],
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    value: option,
                                                    onChanged: (v) {
                                                      setState(() {
                                                        selectedTimeDuration =
                                                            v;
                                                      });
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          count++;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.05,
                                    ),
                                    Text(
                                      '$count',
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
                                          count--;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.03,
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
                            padding:
                                EdgeInsets.only(right: screenSize.width * 0.69),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    EssentialWidgetsCollection.showAlertDialog(
                                        context,
                                        icon: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                            Divider(
                                                color: Colors.green,
                                                thickness: 2)
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
                                                      source:
                                                          ImageSource.gallery)
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
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: screenSize.width * 0.69),
                              child: Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.01),
                                color: Colors.grey[100],
                                surfaceTintColor: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                shadowColor:
                                    const Color.fromARGB(255, 203, 202, 202),
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
                      scrollPadding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.1),
                      enableInteractiveSelection: true,
                      maxLength: 100,
                      minLines: 5,
                      maxLines: 10,
                      controller: planDescController,
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
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: keyboardIsOpened
            ? null
            : Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 50,
                width: screenSize.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (planNameController.text.isNotEmpty) {
                        if (planAmountController.text.isNotEmpty) {
                          //!Added Save part
                          BlocProvider.of<PlanBloc>(context).add(AddPlanEvent(
                              planImages: planImage,
                              businessId: (widget.argus['selectedBusiness']
                                      as BusinessListResponseData)
                                  .id!,
                              customerId: (widget.argus['customerData']
                                      as SelectedCustomerResponseData)
                                  .id!,
                              userId: sph.getString("userid")!,
                              planTitle: planNameController.text,
                              planAmount: planAmountController.text,
                              planNotes: planDescController.text,
                              planType: (selectedTimeDuration != null)
                                  ? selectedTimeDuration!['parameter']
                                  : timeDurationOptions
                                      .elementAt(2)['parameter'],
                              noOfEmis: count.toString()));
                        } else {
                          EssentialWidgetsCollection.showErrorSnackbar(context,
                              description: "Please enter plan amount");
                        }
                      } else {
                        EssentialWidgetsCollection.showErrorSnackbar(context,
                            description: "Please enter plan name");
                      }
                    },
                    child: const Text("Save")),
              ),
      ),
    );
  }
}
