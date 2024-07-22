// ignore_for_file: must_be_immutable, avoid_Talker().info, unnecessary_null_comparison, use_build_context_synchronously, unnecessary_nullable_for_final_variable_declarations
import 'dart:io';

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/business_bloc/business_event.dart';
import 'package:dkapp/module/business_type/model/business_type_list_response_model.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talker/talker.dart';

import '../business/business_bloc/business_bloc.dart';
import '../business/business_bloc/business_state.dart';

class AddNewBusinessScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  AddNewBusinessScreen({super.key, required this.argus});

  @override
  State<AddNewBusinessScreen> createState() => _AddNewBusinessScreenState();
}

class _AddNewBusinessScreenState extends State<AddNewBusinessScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessWebsiteController = TextEditingController();
  TextEditingController businessTaxController = TextEditingController();
  String? signatureImageFile;
  final ImagePicker _picker = ImagePicker();
  XFile? retailerImage;
  String? retailerImageFile;
  Map<String, dynamic>? sendUpdateAddress;
  Map<String, dynamic>? sendUpdateBusinessType;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DoubleBack(
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading:
              (widget.argus.containsKey("fromLoginPage") ? false : true),
          iconTheme: const IconThemeData(color: Colors.white, weight: 3),
          backgroundColor: Colors.blue,
          title: const Text(
            'Create New Business',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: Column(
            children: [
              BlocBuilder<BusinessBloc, BusinessState>(
                buildWhen: (previous, current) {
                  // Rebuild the widget only if the state is changing from submitting to another state
                  return current is AddNewBusinessSuccessState;
                },
                builder: (context, state) {
                  if (state is AddNewBusinessSuccessState) {
                    return EssentialWidgetsCollection.autoScheduleTask(
                      context,
                      childWidget: Container(),
                      taskWaitDuration: Durations.long2,
                      task: () {
                        EssentialWidgetsCollection.showSuccessSnackbar(context,
                            title: null, description: state.successMessage);
                        if (widget.argus.containsKey("fromLoginPage")) {
                          SharedPreferencesHelper().remove("loginType");
                        }
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/dashboard');
                      },
                    );
                  }
                  if (state is AddNewBusinessFailedState) {
                    return EssentialWidgetsCollection.autoScheduleTask(
                      context,
                      childWidget: Container(),
                      taskWaitDuration: Durations.long2,
                      task: () {
                        Navigator.pushReplacementNamed(
                            context, '/add-new-business',
                            arguments: widget.argus);
                        EssentialWidgetsCollection.showErrorSnackbar(context,
                            title: null, description: state.failedMessage);
                      },
                    );
                  }

                  return Container();
                },
              ),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: BlocBuilder<BusinessBloc, BusinessState>(
                    builder: (context, state) {
                      return Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          Stack(
                            children: [
                              (retailerImage != null)
                                  ? CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 80,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(
                                                    retailerImage!.path)))),
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius: 80,
                                      child: Image.asset(
                                        'resources/images/house-icon-removebg-preview.png',
                                        height: 80,
                                        width: 80,
                                      ),
                                    ),
                              Positioned(
                                top: screenSize.height * 0.11,
                                left: screenSize.width * 0.26,
                                child: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 31, 1, 102),
                                    radius: 23,
                                    child: IconButton(
                                        onPressed: () async {
                                          retailerImage =
                                              await _picker.pickImage(
                                                  maxHeight: 480,
                                                  maxWidth: 640,
                                                  source: ImageSource.gallery);
                                          Talker().info(
                                              "Captured Image From Camera :- ${retailerImage!.path}");
                                          setState(() {
                                            retailerImageFile =
                                                retailerImage!.path;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 23,
                                        ))),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        // right: screenSize.width * 0.55,
                                        top: screenSize.height * 0.01),
                                    child: const Text(
                                      'Business Name',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.01,
                                ),
                                TextFormField(
                                  key: _formKey,
                                  controller: businessNameController,
                                  textCapitalization: TextCapitalization.words,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    BlocProvider.of<BusinessBloc>(context).add(
                                        AddNewBusinessTextChangedEvent(
                                            businessName:
                                                businessNameController.text,
                                            businessType:
                                                businessTypeController.text,
                                            businessAddress:
                                                businessAddressController.text,
                                            businessEmail:
                                                businessEmailController.text,
                                            businessWebsite:
                                                businessWebsiteController.text,
                                            businessTaxNumber:
                                                businessTaxController.text));
                                  },
                                  keyboardType: TextInputType.name,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    errorText: (state
                                            is AddNewBusinessTextChangedErrorState)
                                        ? state.businessNameError
                                        : null,
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    // hintText: 'Eg.Abc Kirana',
                                    // hintStyle: const TextStyle(color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 31, 1, 102),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.02,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        // right: screenSize.width * 0.4,
                                        top: screenSize.height * 0.01),
                                    child: const Text(
                                      'What your business do?',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.01,
                                ),
                                InkWell(
                                  onTap: () => (sendUpdateBusinessType != null)
                                      ? _navigateAndGetResultBusinessTypeUpdate(
                                          context)
                                      : _navigateAndGetResultBusinessType(
                                          context),
                                  child: TextFormField(
                                    controller: businessTypeController,
                                    enableInteractiveSelection: false,
                                    maxLines:
                                        null, // Allows the text field to grow vertically
                                    keyboardType: TextInputType.multiline,
                                    enabled: false,
                                    // onTap: () {
                                    //   showGroupsPopup(context);
                                    // },
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: const TextStyle(color: Colors.black),

                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      errorText: (state
                                              is AddNewBusinessTextChangedErrorState)
                                          ? state.businessTypeError
                                          : null,
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      // hintText: 'Eg.Recharge,grocery etc',
                                      // hintStyle: const TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      // focusedBorder: OutlineInputBorder(
                                      //     borderSide: const BorderSide(color: Colors.grey),
                                      //     borderRadius: BorderRadius.circular(8.0)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.02,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        // right: screenSize.width * 0.5,
                                        top: screenSize.height * 0.01),
                                    child: const Text(
                                      'Business Address',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.01,
                                ),
                                InkWell(
                                  onTap: () => (sendUpdateAddress != null)
                                      ? _navigateAndGetResultAddressUpdate(
                                          context)
                                      : _navigateAndGetResultAddress(context),
                                  child: TextFormField(
                                    controller: businessAddressController,
                                    enableInteractiveSelection: false,
                                    enabled: false,
                                    // onTap: () {
                                    //   showGroupsPopup(context);
                                    // },
                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines:
                                        null, // Allows the text field to grow vertically
                                    keyboardType: TextInputType.multiline,
                                    style: const TextStyle(color: Colors.black),

                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      errorText: (state
                                              is AddNewBusinessTextChangedErrorState)
                                          ? state.businessAddressError
                                          : null,
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      // hintText: 'Address',
                                      // hintStyle: const TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      // focusedBorder: OutlineInputBorder(
                                      //     borderSide: const BorderSide(color: Colors.grey),
                                      //     borderRadius: BorderRadius.circular(8.0)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.02,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      // right: screenSize.width * 0.4,
                                      top: screenSize.height * 0.01,
                                    ),
                                    child: const Text(
                                      'Business Email Address',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.01,
                                ),
                                TextFormField(
                                  controller: businessEmailController,
                                  enabled: true,
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    BlocProvider.of<BusinessBloc>(context).add(
                                        AddNewBusinessTextChangedEvent(
                                            businessName:
                                                businessNameController.text,
                                            businessType:
                                                businessTypeController.text,
                                            businessAddress:
                                                businessAddressController.text,
                                            businessEmail:
                                                businessEmailController.text,
                                            businessWebsite:
                                                businessWebsiteController.text,
                                            businessTaxNumber:
                                                businessTaxController.text));
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    errorText: (state
                                            is AddNewBusinessTextChangedErrorState)
                                        ? state.businessEmailError
                                        : null,
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    // hintText: 'Eg.sample@domain.com',
                                    // hintStyle: const TextStyle(color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 31, 1, 102),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: screenSize.width * 0.47,
                                  ),
                                  child: const Text(
                                    'you will get monthly report on this mail ID',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 8),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.02,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      // right: screenSize.width * 0.68,
                                      top: screenSize.height * 0.01,
                                    ),
                                    child: const Text(
                                      'Website',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.01,
                                ),
                                TextFormField(
                                  controller: businessWebsiteController,
                                  enableInteractiveSelection: true,
                                  enabled: true,
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.name,
                                  cursorColor: Colors.black,
                                  onChanged: (value) {
                                    BlocProvider.of<BusinessBloc>(context).add(
                                        AddNewBusinessTextChangedEvent(
                                            businessName:
                                                businessNameController.text,
                                            businessType:
                                                businessTypeController.text,
                                            businessAddress:
                                                businessAddressController.text,
                                            businessEmail:
                                                businessEmailController.text,
                                            businessWebsite:
                                                businessWebsiteController.text,
                                            businessTaxNumber:
                                                businessTaxController.text));
                                  },
                                  decoration: InputDecoration(
                                    // hintText: 'Eg.www.sample.com',
                                    // hintStyle: const TextStyle(color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 31, 1, 102),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    errorText: (state
                                            is AddNewBusinessTextChangedErrorState)
                                        ? state.businessWebsiteError
                                        : null,
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.02,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      // right: screenSize.width * 0.41,
                                      top: screenSize.height * 0.01,
                                    ),
                                    child: const Text(
                                      'Business Tax Number',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.01,
                                ),
                                TextFormField(
                                  controller: businessTaxController,
                                  enableInteractiveSelection: true,
                                  enabled: true,
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.name,
                                  cursorColor: Colors.black,
                                  onChanged: (value) {
                                    BlocProvider.of<BusinessBloc>(context).add(
                                        AddNewBusinessTextChangedEvent(
                                            businessName:
                                                businessNameController.text,
                                            businessType:
                                                businessTypeController.text,
                                            businessAddress:
                                                businessAddressController.text,
                                            businessEmail:
                                                businessEmailController.text,
                                            businessWebsite:
                                                businessWebsiteController.text,
                                            businessTaxNumber:
                                                businessTaxController.text));
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 31, 1, 102),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    errorText: (state
                                            is AddNewBusinessTextChangedErrorState)
                                        ? state.businessTaxNumberError
                                        : null,
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.06,
                                ),
                                (state is AddNewBusinessLoadingState)
                                    ?  Center(
                                        child: AnimatedImageLoader(),
                                      )
                                    : ((state is AddNewBusinessValidState)
                                        ? InkWell(
                                            onTap: () async {
                                              BlocProvider.of<BusinessBloc>(
                                                      context)
                                                  .add(AddNewBusinessEvent(
                                                      businessName:
                                                          businessNameController
                                                              .text,
                                                      businessType:
                                                          businessTypeController
                                                              .text,
                                                      businessAddress:
                                                          businessAddressController
                                                              .text,
                                                      businessEmail:
                                                          businessEmailController
                                                              .text,
                                                      businessWebsite:
                                                          businessWebsiteController
                                                              .text,
                                                      businessTaxNumber:
                                                          businessTaxController
                                                              .text,
                                                      userId:
                                                          SharedPreferencesHelper()
                                                              .getString(
                                                                  "userid")!));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenSize.width * 0.35,
                                                  vertical: screenSize.height *
                                                      0.016),
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 31, 1, 102),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0)),
                                              child: const Text(
                                                'Save',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    screenSize.width * 0.35,
                                                vertical:
                                                    screenSize.height * 0.016),
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            child: const Text(
                                              'Save',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                            ),
                                          )),
                                SizedBox(
                                  height: screenSize.height * 0.04,
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateAndGetResultAddress(BuildContext context) async {
    final Map<String, dynamic>? res = await Navigator.pushNamed(
      context,
      '/add-business-address',
    ) as Map<String, dynamic>?;

    Talker().info("Selected address:- ${res!['completeAddress'].toString()}");
    Iterator<MapEntry<String, dynamic>> i =
        res['completeAddress'].entries.iterator;
    String add = '';
    while (i.moveNext()) {
      add += "${i.current.value},";
    }

    if (res != null) {
      setState(() {
        businessAddressController.text = add;
        sendUpdateAddress = res;
      });
    }
    BlocProvider.of<BusinessBloc>(context).add(AddNewBusinessTextChangedEvent(
        businessName: businessNameController.text,
        businessType: businessTypeController.text,
        businessAddress: businessAddressController.text,
        businessEmail: businessEmailController.text,
        businessWebsite: businessWebsiteController.text,
        businessTaxNumber: businessTaxController.text));
  }

  _navigateAndGetResultAddressUpdate(BuildContext context) async {
    final Map<String, dynamic>? res =
        await Navigator.pushNamed(context, '/add-business-address', arguments: {
      "address": sendUpdateAddress!['completeAddress'],
      // "currentPostion": sendUpdateAddress!['currentPostion']
    }) as Map<String, dynamic>?;

    // Sending result back to FirstScreen
    Talker().info("Selected address:- ${res!['completeAddress'].toString()}");
    Iterator<MapEntry<String, dynamic>> i =
        res['completeAddress'].entries.iterator;
    businessAddressController.clear();
    String add = '';
    while (i.moveNext()) {
      add += "${i.current.value},";
    }

    if (res != null) {
      setState(() {
        businessAddressController.text = add;
        sendUpdateAddress = res;
      });
    }
    BlocProvider.of<BusinessBloc>(context).add(AddNewBusinessTextChangedEvent(
        businessName: businessNameController.text,
        businessType: businessTypeController.text,
        businessAddress: businessAddressController.text,
        businessEmail: businessEmailController.text,
        businessWebsite: businessWebsiteController.text,
        businessTaxNumber: businessTaxController.text));
  }

  _navigateAndGetResultBusinessType(BuildContext context) async {
    String outputResultBusinessType = "";

    final Map<String, dynamic>? rese = await Navigator.pushNamed(
      context,
      '/business-type',
    ) as Map<String, dynamic>;

    // Sending result back to FirstScreen
    Talker().info(
        "Selected Business Types:- ${(rese!['selectedData'] as List<BusinessTypeListResponseData>).map((c) => c.toJson().toString())}");
    Talker().info("Selected Choices:- ${rese['choices'].toString()}");

    if (rese.containsKey("selectedData")) {
      for (var i = 0;
          i <
              (rese["selectedData"] as List<BusinessTypeListResponseData>)
                  .length;
          i++) {
        if (i ==
            (rese["selectedData"] as List<BusinessTypeListResponseData>)
                    .length -
                1) {
          if ((rese["selectedData"] as List<BusinessTypeListResponseData>)[i]
                  .isChecked ==
              true) {
            outputResultBusinessType +=
                "${(rese["selectedData"] as List<BusinessTypeListResponseData>)[i].name}";
          }
        } else {
          if ((rese["selectedData"] as List<BusinessTypeListResponseData>)[i]
                  .isChecked ==
              true) {
            outputResultBusinessType +=
                "${(rese["selectedData"] as List<BusinessTypeListResponseData>)[i].name},";
          }
        }
      }
    }

    if (rese.containsKey("choices")) {
      if ((rese["choices"] as List<String>).length == 1) {
        outputResultBusinessType +=
            ",${(rese["choices"] as List<String>).first}";
      } else {
        for (var i = 0; i < (rese["choices"] as List<String>).length; i++) {
          if (i == (rese["choices"] as List<String>).length - 1) {
            outputResultBusinessType += (rese["choices"] as List<String>)[i];
          } else {
            outputResultBusinessType +=
                ",${(rese["choices"] as List<String>)[i]},";
          }
        }
      }
    }

    setState(() {
      businessTypeController.text = outputResultBusinessType;
    });
    if (rese != null) {
      setState(() {
        sendUpdateBusinessType = rese;
      });
    }
    BlocProvider.of<BusinessBloc>(context).add(AddNewBusinessTextChangedEvent(
        businessName: businessNameController.text,
        businessType: businessTypeController.text,
        businessAddress: businessAddressController.text,
        businessEmail: businessEmailController.text,
        businessWebsite: businessWebsiteController.text,
        businessTaxNumber: businessTaxController.text));
  }

  _navigateAndGetResultBusinessTypeUpdate(BuildContext context) async {
    String outputResultBusinessTypeUpdate = "";
    final Map<String, dynamic>? resa =
        await Navigator.pushNamed(context, '/business-type', arguments: {
      "selectedData": sendUpdateBusinessType!['selectedData'],
      "choices": sendUpdateBusinessType!['choices']
    }) as Map<String, dynamic>?;

    // Sending result back to FirstScreen
    (resa!["selectedData"] as List<BusinessTypeListResponseData>).map((c) {
      Talker().info("Selected Business Types Update:- ${c.name}");
    });

    Talker().info(
        "Selected Choices Update:- ${(resa['choices'] as List<String>).toList().toString()}");

    if (resa.containsKey("selectedData")) {
      for (var i = 0;
          i <
              (resa["selectedData"] as List<BusinessTypeListResponseData>)
                  .length;
          i++) {
        if (i ==
            (resa["selectedData"] as List<BusinessTypeListResponseData>)
                    .length -
                1) {
          if ((resa["selectedData"] as List<BusinessTypeListResponseData>)[i]
                  .isChecked ==
              true) {
            outputResultBusinessTypeUpdate +=
                "${(resa["selectedData"] as List<BusinessTypeListResponseData>)[i].name}";
          }
        } else {
          if ((resa["selectedData"] as List<BusinessTypeListResponseData>)[i]
                  .isChecked ==
              true) {
            outputResultBusinessTypeUpdate +=
                "${(resa["selectedData"] as List<BusinessTypeListResponseData>)[i].name},";
          }
        }
      }
    }

    if (resa.containsKey("choices")) {
      if ((resa["choices"] as List<String>).length == 1) {
        outputResultBusinessTypeUpdate +=
            ",${(resa["choices"] as List<String>).first}";
      } else {
        for (var i = 0; i < (resa["choices"] as List<String>).length; i++) {
          if (i == (resa["choices"] as List<String>).length - 1) {
            outputResultBusinessTypeUpdate +=
                (resa["choices"] as List<String>)[i];
          } else {
            outputResultBusinessTypeUpdate +=
                ",${(resa["choices"] as List<String>)[i]},";
          }
        }
      }
    }

    setState(() {
      businessTypeController.text = outputResultBusinessTypeUpdate;
    });
    if (resa != null) {
      setState(() {
        sendUpdateBusinessType = resa;
      });
    }
    BlocProvider.of<BusinessBloc>(context).add(AddNewBusinessTextChangedEvent(
        businessName: businessNameController.text,
        businessType: businessTypeController.text,
        businessAddress: businessAddressController.text,
        businessEmail: businessEmailController.text,
        businessWebsite: businessWebsiteController.text,
        businessTaxNumber: businessTaxController.text));
  }
}
