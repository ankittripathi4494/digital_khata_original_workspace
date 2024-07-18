// ignore_for_file: must_be_immutable, avoid_print

import 'dart:async' as t1;
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dkapp/global_widget/animated_loading_placeholder_widget.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/profile/model/transaction_list_response_model.dart';
import 'package:dkapp/module/profile/transactions/transactions_bloc.dart';
import 'package:dkapp/module/profile/transactions/transactions_event.dart';
import 'package:dkapp/module/profile/transactions/transactions_state.dart';
import 'package:dkapp/utils/image_list.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as i;
import 'package:dkapp/global_blocs/internet/internet_cubit.dart';
import 'package:dkapp/global_blocs/internet/internet_state.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:talker/talker.dart';

class WriteOffScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  WriteOffScreen({super.key, required this.argus});

  @override
  State<WriteOffScreen> createState() => _WriteOffScreenState();
}

class _WriteOffScreenState extends State<WriteOffScreen> {
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  final ImagePicker _picker = ImagePicker();
  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  XFile? attachImage;

  @override
  void initState() {
    fetchTransactionData();
    super.initState();
  }

  fetchTransactionData() {
    if (widget.argus.containsKey('transactionData')) {
      setState(() {
        amountController.text = double.parse(
                (widget.argus['transactionData'] as TransactionListResponseData)
                    .afterTransAmount!)
            .abs()
            .toString();
      });
    }
  }

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
          iconTheme: const IconThemeData(color: Colors.white),
          title: ListTile(
            contentPadding: const EdgeInsets.all(0),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              (widget.argus['customerData'] as SelectedCustomerResponseData)
                  .fullname!,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            subtitle: Text(
              '\u{20B9} ${(widget.argus['customerData'] as SelectedCustomerResponseData).amount ?? 0}',
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          actions: [
            IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.delete,
                  size: 30,
                ))
          ],
        ),
        body: Container(
           decoration: BoxDecoration(color: Colors.grey[100]),
          child: BlocBuilder<TransactionsBloc, TransactionsState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        (state is AddNewCashTransactionSuccessState)
                            ? EssentialWidgetsCollection.autoScheduleTask(
                                context,
                                taskWaitDuration: Durations.medium3,
                                task: () {
                                  Talker().info(
                                      "Same Page Redirection:- ${state.samePageRedirection}");
                                  if (state.samePageRedirection == true) {
                                    setState(() {
                                      amountController.clear();
                                      attachImage = null;
                                      notesController.clear();
                                    });
                                    Navigator.pushReplacementNamed(
                                        context, '/cash-in-screen',
                                        arguments: widget.argus);
                                  } else {
                                    Navigator.pushReplacementNamed(
                                        context, '/customer-screen-details',
                                        arguments: widget.argus);
                                  }
                                  EssentialWidgetsCollection.showSuccessSnackbar(
                                      context,
                                      description: "Transaction Successfull");
                                },
                              )
                            : Container(),
                        (state is AddNewCashTransactionFailedState)
                            ? EssentialWidgetsCollection.autoScheduleTask(
                                context,
                                taskWaitDuration: Durations.medium3,
                                task: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/cash-in-screen',
                                      arguments: widget.argus);
                                  EssentialWidgetsCollection.showErrorSnackbar(
                                      context,
                                      description: state.failedMessage);
                                },
                              )
                            : Container(),
                        (state is AddNewCashTransactionLoadingState)
                            ? const AnimatedImagePlaceholderLoader()
                            : Container(),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.008,
                          ),
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
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Write off",
                                  style: TextStyle(
                                      fontSize: 20,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),
                                  height: 50,
                                  child: TextFormField(
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    enabled: false,
                                    style: TextStyle(
                                        color: ((widget.argus['transactionData']
                                                        as TransactionListResponseData)
                                                    .transType !=
                                                'D')
                                            ? Colors.red
                                            : Colors.green,
                                        letterSpacing: 1.2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                                      filled: false,
                                      fillColor: Colors.grey.shade300,
                                      counterText: '',
                                      prefixIcon: const Icon(
                                        Icons.currency_rupee,
                                        size: 20,
                                      ),
                                      prefixIconColor: ((widget.argus[
                                                          'transactionData']
                                                      as TransactionListResponseData)
                                                  .transType !=
                                              'D')
                                          ? Colors.red
                                          : Colors.green,
                                      hintText: "0",
                                      hintStyle: const TextStyle(
                                          color: Colors.black,
                                          letterSpacing: 1.2,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                            width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                            width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                            width: 2),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                            width: 2),
                                      ),
                                      errorText: null,
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                            width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          iconColor: Colors.blue,
                                        ),
                                        onPressed: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          ).then((c) {
                                            if (c != null) {
                                              setState(() {
                                                selectedDate = c;
                                              });
                                            }
                                            showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            ).then((t) {
                                              if (t != null) {
                                                setState(() {
                                                  selectedTime = t;
                                                });
                                              }
                                            });
                                          });
                                        },
                                        label: Text(
                                            i.DateFormat('MM-dd-y hh:mm a')
                                                .format(((selectedDate != null) &&
                                                        (selectedTime != null))
                                                    ? _combineDateTime(
                                                        selectedDate!,
                                                        selectedTime!)
                                                    : DateTime.now())),
                                        icon: const Icon(
                                          Icons.calendar_month,
                                        ),
                                      ),
                                      TextButton.icon(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.blue,
                                        ),
                                        onPressed: () {},
                                        label: const Text("Link"),
                                        icon: const Icon(Icons.link),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.008,
                          ),
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
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: DividerTheme(
                              data: const DividerThemeData(
                                  color: Colors.green, thickness: 1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
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
                                                  attachImage = c;
                                                });
                                                Talker().info(
                                                    "Captured Image From Camera :- ${attachImage!.path}");
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
                                                    attachImage = c;
                                                  });
                                                  Talker().info(
                                                      "Captured Image From gallery :- ${attachImage!.path}");
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
                                    contentPadding: const EdgeInsets.all(0),
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    leading: const Icon(
                                      Icons.image,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Attachment",
                                          style: TextStyle(
                                              fontSize: 16,
                                              letterSpacing: 1.2,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        (widget.argus
                                                .containsKey('transactionData'))
                                            ? (((widget.argus['transactionData']
                                                            as TransactionListResponseData)
                                                        .image !=
                                                    null)
                                                ? ((attachImage != null)
                                                    ? Image.file(
                                                        File(attachImage!.path),
                                                        width: 100,
                                                        height: 100,
                                                      )
                                                    : CachedNetworkImage(
                                                        imageUrl:
                                                            "${NetworkImagePathList.imagePathTrans}${(widget.argus['transactionData'] as TransactionListResponseData).image}",
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          color:
                                                              Colors.transparent,
                                                          width: 100,
                                                          height: 100,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image:
                                                                        imageProvider)),
                                                          ),
                                                        ),
                                                        placeholder:
                                                            (context, url) =>
                                                                CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey[300],
                                                          radius: 45,
                                                          child:
                                                              const AnimatedImagePlaceholderLoader(),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey[300],
                                                          radius: 80,
                                                          child: Image.asset(
                                                            'resources/images/house-icon-removebg-preview.png',
                                                            height: 80,
                                                            width: 80,
                                                          ),
                                                        ),
                                                      ))
                                                : (attachImage != null)
                                                    ? Image.file(
                                                        File(attachImage!.path),
                                                        width: 100,
                                                        height: 100,
                                                      )
                                                    : Container())
                                            : ((attachImage != null)
                                                ? Image.file(
                                                    File(attachImage!.path),
                                                    width: 100,
                                                    height: 100,
                                                  )
                                                : Container())
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    leading: const Icon(
                                      Icons.chat,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                    title: const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "Notes/ Remarks",
                                        style: TextStyle(
                                            fontSize: 16,
                                            letterSpacing: 1.2,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                    ),
                                    subtitle: TextFormField(
                                      controller: notesController,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null, // Set this
          
                                      style: const TextStyle(
                                          color: Colors.black,
                                          letterSpacing: 1.2,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        filled: false,
                                        fillColor: Colors.grey.shade300,
                                        counterText: '',
                                        hintText: "Add your notes here..",
                                        hintStyle: const TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 1.2,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                        errorText: null,
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(
                                        iconColor: Colors.blue,
                                        foregroundColor: Colors.blue),
                                    onPressed: () async {},
                                    label: const Text(
                                      "Add Custom Properties",
                                      style: TextStyle(
                                          fontSize: 16,
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black),
                                    ),
                                    icon: const Icon(
                                      Icons.add_circle_outline,
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
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
                      if (amountController.text.isNotEmpty) {
                        if ((widget.argus['transactionData']
                                    as TransactionListResponseData)
                                .transType ==
                            'D') {
                          BlocProvider.of<TransactionsBloc>(context).add(
                              AddCashTransactionEvent(
                                  samePageRedirection: false,
                                  customerId: (widget.argus['customerData']
                                          as SelectedCustomerResponseData)
                                      .id!,
                                  businessId: (widget.argus['selectedBusiness']
                                          as BusinessListResponseData)
                                      .id!,
                                  userId: sph.getString("userid")!,
                                  transactionType: 'C',
                                  transactionAmount: amountController.text,
                                  transactionNotes: notesController.text,
                                  transactionImages: attachImage));
                        } else {
                          BlocProvider.of<TransactionsBloc>(context).add(
                              AddCashTransactionEvent(
                                  samePageRedirection: false,
                                  customerId: (widget.argus['customerData']
                                          as SelectedCustomerResponseData)
                                      .id!,
                                  businessId: (widget.argus['selectedBusiness']
                                          as BusinessListResponseData)
                                      .id!,
                                  userId: sph.getString("userid")!,
                                  transactionType: 'D',
                                  transactionAmount: amountController.text,
                                  transactionNotes: notesController.text,
                                  transactionImages: attachImage));
                        }
                      } else {
                        EssentialWidgetsCollection.showErrorSnackbar(context,
                            description:
                                "Please fill amount to complete transaction");
                      }
                    },
                    child: const Text("Save")),
              ),
      ),
    );
  }

  _combineDateTime(DateTime date, TimeOfDay time) {
    final DateTime combinedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return combinedDateTime;
  }
}
