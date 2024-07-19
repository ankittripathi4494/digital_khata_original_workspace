// ignore_for_file: must_be_immutable, use_build_context_synchronously, unnecessary_null_comparison, avoid_print

import 'dart:async';

import 'package:dkapp/global_blocs/internet/internet_cubit.dart';
import 'package:dkapp/global_blocs/internet/internet_state.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/business/model/user_group_model.dart';
import 'package:dkapp/module/business/user_group_bloc/user_group_bloc.dart';
import 'package:dkapp/module/business/user_group_bloc/user_group_event.dart';
import 'package:dkapp/module/business/user_group_bloc/user_group_state.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_bloc.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_event.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_state.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/utils/exceptions.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class EditCustomerScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  EditCustomerScreen({super.key, required this.argus});

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  UserGroupResponseData? selectedGroup;
  List<UserGroupResponseData> usergroupList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController billingCycleController = TextEditingController();
  Map<String, dynamic>? sendUpdateAddress;
  bool showLoader = false;
  bool updatedData = false;
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  @override
  void initState() {
    super.initState();
    fetchUserGroupList();
  }

  fetchUserGroupList() {
    BlocProvider.of<UserGroupBloc>(context).add(UserGroupListFetchEvent(
        businessId:
            (widget.argus['selectedBusiness'] as BusinessListResponseData).id!,
        userId: sph.getString("userid")!));
  }

  fillFormDetails() {
    Talker().info((widget.argus['customerData'] as SelectedCustomerResponseData)
        .toJson());
    nameController.text =
        ((widget.argus['customerData'] as SelectedCustomerResponseData)
                    .fullname !=
                null)
            ? (widget.argus['customerData'] as SelectedCustomerResponseData)
                .fullname!
            : '';

    mobileController.text = ((widget.argus['customerData']
                    as SelectedCustomerResponseData)
                .mobile !=
            null)
        ? (widget.argus['customerData'] as SelectedCustomerResponseData).mobile!
        : '';
    emailController.text =
        ((widget.argus['customerData'] as SelectedCustomerResponseData).email !=
                null)
            ? (widget.argus['customerData'] as SelectedCustomerResponseData)
                .email!
            : '';
    dobController.text =
        ((widget.argus['customerData'] as SelectedCustomerResponseData).dob !=
                null)
            ? DateFormat('y-M-d').format(DateTime.parse(
                (widget.argus['customerData'] as SelectedCustomerResponseData)
                    .dob!))
            : '';
    billingCycleController.text =
        ((widget.argus['customerData'] as SelectedCustomerResponseData)
                    .billingCycle !=
                null)
            ? (widget.argus['customerData'] as SelectedCustomerResponseData)
                .billingCycle!
            : '';

    addressController.text =
        ((widget.argus['customerData'] as SelectedCustomerResponseData)
                    .address !=
                null)
            ? (widget.argus['customerData'] as SelectedCustomerResponseData)
                .address!
            : '';

    if (usergroupList.isNotEmpty) {
      for (UserGroupResponseData ex in usergroupList) {
        if (ex.id ==
            (widget.argus['customerData'] as SelectedCustomerResponseData)
                .groupId) {
          Talker().info("Selected");
          setState(() {
            selectedGroup = ex;
            groupController.text = selectedGroup?.name ?? '';
          });
        }
      }
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
          // tempData = widget.argus.addEntries([const MapEntry("page", "login")]);
          Timer(Durations.medium2, () {
            Navigator.pushReplacementNamed(
              context,
              '/no-internet',
            );
          });
        }
      },
      child: Scaffold(
         backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
          ),
          automaticallyImplyLeading: false,
          title: const Text(
            "Edit Customer",
            style: TextStyle(
                color: Color.fromARGB(255, 31, 1, 102),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.contact_phone_outlined)),
          ],
        ),
        body: Container(
           decoration: BoxDecoration(color: Colors.grey[100]),
          child: Column(
            children: [
              (updatedData == true)
                  ? EssentialWidgetsCollection.autoScheduleTask(context,
                      task: () {
                      Talker().info("datya");
                      setState(() {
                        updatedData = false;
                      });
                      BlocProvider.of<CustomerBloc>(context).add(
                          UpdateCustomerTextChangeEvent(
                              customerName: nameController.text,
                              customerEmail: emailController.text,
                              customerMobile: mobileController.text,
                              customerUserGroup: groupController.text,
                              customerAddress: addressController.text,
                              customerBilling: billingCycleController.text,
                              customerDob: dobController.text));
                    }, taskWaitDuration: Durations.short4)
                  : Container(),
              BlocBuilder<UserGroupBloc, UserGroupState>(
                builder: (context, state) {
                  if (state is UserGroupListLoadedState) {
                    return EssentialWidgetsCollection.autoScheduleTask(
                      context,
                      childWidget: Container(),
                      taskWaitDuration: Durations.short4,
                      task: () {
                        setState(() {
                          usergroupList.addAll(state.successData!);
                        });
                        fillFormDetails();
                      },
                    );
                  }
                  if (state is UserGroupListFailedState) {
                    return EssentialWidgetsCollection.autoScheduleTask(
                      context,
                      childWidget: Container(),
                      taskWaitDuration: Durations.short4,
                      task: () {
                        Talker().info("faield");
                        setState(() {
                          usergroupList.addAll([]);
                        });
                        fillFormDetails();
                      },
                    );
                  }
                  return Container();
                },
              ),
              Flexible(
                child: BlocBuilder<CustomerBloc, CustomerState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            (state is UpdateCustomerSuccessState)
                                ? EssentialWidgetsCollection.autoScheduleTask(
                                    context,
                                    childWidget: Container(),
                                    taskWaitDuration: Durations.long2,
                                    task: () {
                                      EssentialWidgetsCollection
                                          .showSuccessSnackbar(
                                              context, title: null, description: state.successMessage);
          
                                      Navigator.pop(context);
                                      Navigator.pushReplacementNamed(
                                          context, '/customer-screen-details',
                                          arguments: widget.argus);
                                    },
                                  )
                                : Container(),
                            (state is UpdateCustomerFailedState)
                                ? EssentialWidgetsCollection.autoScheduleTask(
                                    context,
                                    childWidget: Container(),
                                    taskWaitDuration: Durations.long2,
                                    task: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/edit-customer-screen',
                                          arguments: widget.argus);
                                      EssentialWidgetsCollection
                                          .showErrorSnackbar(
                                              context, title: null, description: state.failedMessage);
                                    },
                                  )
                                : Container(),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              height:
                                  (state is UpdateCustomerTextChangedErrorState)
                                      ? 80
                                      : 50,
                              child: TextFormField(
                                controller: nameController,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 31, 1, 102)),
                                onChanged: (value) {
                                  BlocProvider.of<CustomerBloc>(context).add(
                                      UpdateCustomerTextChangeEvent(
                                          customerName: nameController.text,
                                          customerEmail: emailController.text,
                                          customerMobile: mobileController.text,
                                          customerUserGroup: groupController.text,
                                          customerAddress: addressController.text,
                                          customerBilling:
                                              billingCycleController.text,
                                          customerDob: dobController.text));
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  prefixIcon: const Icon(Icons.person),
                                  prefixIconColor:
                                      const Color.fromARGB(255, 31, 1, 102),
                                  labelText: "Enter Name",
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 31, 1, 102)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                        width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                        width: 2),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                        width: 2),
                                  ),
                                  errorText: (state
                                          is UpdateCustomerTextChangedErrorState)
                                      ? state.customerNameError
                                      : null,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                        width: 2),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              height:
                                  (state is UpdateCustomerTextChangedErrorState)
                                      ? 80
                                      : 50,
                              child: TextFormField(
                                  controller: mobileController,
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 31, 1, 102)),
                                  onChanged: (value) {
                                    BlocProvider.of<CustomerBloc>(context).add(
                                        UpdateCustomerTextChangeEvent(
                                            customerName: nameController.text,
                                            customerEmail: emailController.text,
                                            customerMobile: mobileController.text,
                                            customerUserGroup:
                                                groupController.text,
                                            customerAddress:
                                                addressController.text,
                                            customerBilling:
                                                billingCycleController.text,
                                            customerDob: dobController.text));
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    counterText: '',
                                    prefix: const Text(
                                      "+91 ",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 31, 1, 102),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    labelText: "Enter Mobile Number",
                                    labelStyle: const TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102)),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 31, 1, 102),
                                          width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 31, 1, 102),
                                          width: 2),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 31, 1, 102),
                                          width: 2),
                                    ),
                                    errorText: (state
                                            is UpdateCustomerTextChangedErrorState)
                                        ? state.customerMobileError
                                        : null,
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 31, 1, 102),
                                          width: 2),
                                    ),
                                  )),
                            ),
                            // Container(
                            //   margin: const EdgeInsets.symmetric(
                            //       horizontal: 20, vertical: 10),
                            //   height:
                            //       (state is UpdateCustomerTextChangedErrorState)
                            //           ? 80
                            //           : 50,
                            //   child: TextFormField(
                            //     controller: emailController,
                            //     keyboardType: TextInputType.emailAddress,
                            //     style: const TextStyle(
                            //         color: Color.fromARGB(255, 31, 1, 102)),
                            //     onChanged: (value) {
                            //       BlocProvider.of<CustomerBloc>(context).add(
                            //           UpdateCustomerTextChangeEvent(
                            //               customerName: nameController.text,
                            //               customerEmail: emailController.text,
                            //               customerMobile: mobileController.text,
                            //               customerUserGroup: groupController.text,
                            //               customerAddress: addressController.text,
                            //               customerBilling:
                            //                   billingCycleController.text,
                            //               customerDob: dobController.text));
                            //     },
                            //     decoration: InputDecoration(
                            //       filled: true,
                            //       fillColor: Colors.grey.shade300,
                            //       counterText: '',
                            //       prefixIcon: const Icon(Icons.mail),
                            //       prefixIconColor:
                            //           const Color.fromARGB(255, 31, 1, 102),
                            //       labelText: "Enter Email",
                            //       labelStyle: const TextStyle(
                            //           color: Color.fromARGB(255, 31, 1, 102)),
                            //       enabledBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: const BorderSide(
                            //             color: Color.fromARGB(255, 31, 1, 102),
                            //             width: 2),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: const BorderSide(
                            //             color: Color.fromARGB(255, 31, 1, 102),
                            //             width: 2),
                            //       ),
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: const BorderSide(
                            //             color: Color.fromARGB(255, 31, 1, 102),
                            //             width: 2),
                            //       ),
                            //       errorText: (state
                            //               is UpdateCustomerTextChangedErrorState)
                            //           ? state.customerEmailError
                            //           : null,
                            //       errorBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: const BorderSide(
                            //             color: Color.fromARGB(255, 31, 1, 102),
                            //             width: 2),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            
                            // Container(
                            //   margin: const EdgeInsets.symmetric(
                            //       horizontal: 20, vertical: 10),
                            //   height:
                            //       (state is UpdateCustomerTextChangedErrorState)
                            //           ? 80
                            //           : 50,
                            //   child: InkWell(
                            //     onTap: () {
                            //       showDatePicker(
                            //               context: context,
                            //               firstDate: DateTime(1900),
                            //               lastDate: DateTime(
                            //                   DateTime.now().year,
                            //                   DateTime.now().month,
                            //                   DateTime.now().day))
                            //           .then((s) {
                            //         setState(() {
                            //           dobController.text = DateFormat('y-M-d')
                            //               .format(DateTime.parse(s.toString()));
                            //         });
                            //         BlocProvider.of<CustomerBloc>(context).add(
                            //             UpdateCustomerTextChangeEvent(
                            //                 customerName: nameController.text,
                            //                 customerEmail: emailController.text,
                            //                 customerMobile: mobileController.text,
                            //                 customerUserGroup:
                            //                     groupController.text,
                            //                 customerAddress:
                            //                     addressController.text,
                            //                 customerBilling:
                            //                     billingCycleController.text,
                            //                 customerDob: dobController.text));
                            //       });
                            //     },
                            //     child: TextFormField(
                            //         controller: dobController,
                            //         enabled: false,
                            //         maxLines:
                            //             null, // Allows the text field to grow vertically
                            //         keyboardType: TextInputType.multiline,
                            //         style: const TextStyle(
                            //             color: Color.fromARGB(255, 31, 1, 102),
                            //             fontWeight: FontWeight.w600),
                            //         decoration: InputDecoration(
                            //           filled: true,
                            //           fillColor: Colors.grey.shade300,
                            //           counterText: '',
                            //           labelText: "Select DOB",
                            //           labelStyle: const TextStyle(
                            //               color: Color.fromARGB(255, 31, 1, 102)),
                            //           disabledBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           enabledBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           focusedBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           border: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           errorText: (state
                            //                   is UpdateCustomerTextChangedErrorState)
                            //               ? state.customerDobError
                            //               : null,
                            //           errorBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //         )),
                            //   ),
                            // ),
                            
                            // Container(
                            //   margin: const EdgeInsets.symmetric(
                            //       horizontal: 20, vertical: 10),
                            //   height:
                            //       (state is UpdateCustomerTextChangedErrorState)
                            //           ? 80
                            //           : 50,
                            //   child: InkWell(
                            //     onTap: () => (sendUpdateAddress != null)
                            //         ? _navigateAndGetResultAddressUpdate(context)
                            //         : _navigateAndGetResultAddress(context),
                            //     child: TextFormField(
                            //         controller: addressController,
                            //         enabled: false,
                            //         maxLines:
                            //             null, // Allows the text field to grow vertically
                            //         keyboardType: TextInputType.multiline,
                            //         style: const TextStyle(
                            //             color: Color.fromARGB(255, 31, 1, 102),
                            //             fontWeight: FontWeight.w600),
                            //         decoration: InputDecoration(
                            //           filled: true,
                            //           fillColor: Colors.grey.shade300,
                            //           counterText: '',
                            //           labelText: "Select Address",
                            //           labelStyle: const TextStyle(
                            //               color: Color.fromARGB(255, 31, 1, 102)),
                            //           disabledBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           enabledBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           focusedBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           border: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           errorText: (state
                            //                   is UpdateCustomerTextChangedErrorState)
                            //               ? state.customerAddressError
                            //               : null,
                            //           errorBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //         )),
                            //   ),
                            // ),
                            
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              height:
                                  (state is UpdateCustomerTextChangedErrorState)
                                      ? 80
                                      : 50,
                              child: InkWell(
                                onTap: () {
                                  (selectedGroup != null)
                                      ? showSelectedUserGroupBottomSheet(context)
                                      : showUserGroupListBottomSheet(context);
                                },
                                child: TextFormField(
                                    controller: groupController,
                                    enabled: false,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                        fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade300,
                                      counterText: '',
                                      labelText: "Select Group",
                                      labelStyle: const TextStyle(
                                          color: Color.fromARGB(255, 31, 1, 102)),
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
                                      errorText: (state
                                              is UpdateCustomerTextChangedErrorState)
                                          ? state.userGroupResponseDataError
                                          : null,
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                            width: 2),
                                      ),
                                    )),
                              ),
                            ),
                            
                            // Container(
                            //   margin: const EdgeInsets.symmetric(
                            //       horizontal: 20, vertical: 10),
                            //   height:
                            //       (state is UpdateCustomerTextChangedErrorState)
                            //           ? 80
                            //           : 50,
                            //   child: InkWell(
                            //     onTap: () {
                            //       showFormForBillingCycleBottomSheet(context);
                            //     },
                            //     child: TextFormField(
                            //         controller: billingCycleController,
                            //         enabled: false,
                            //         style: const TextStyle(
                            //             color: Color.fromARGB(255, 31, 1, 102),
                            //             fontWeight: FontWeight.w600),
                            //         decoration: InputDecoration(
                            //           filled: true,
                            //           fillColor: Colors.grey.shade300,
                            //           counterText: '',
                            //           labelText:
                            //               "Select Business Cycle (in Days)",
                            //           labelStyle: const TextStyle(
                            //               color: Color.fromARGB(255, 31, 1, 102)),
                            //           disabledBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           enabledBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           focusedBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           border: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //           errorText: (state
                            //                   is UpdateCustomerTextChangedErrorState)
                            //               ? state.customerBillingError
                            //               : null,
                            //           errorBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //             borderSide: const BorderSide(
                            //                 color:
                            //                     Color.fromARGB(255, 31, 1, 102),
                            //                 width: 2),
                            //           ),
                            //         )),
                            //   ),
                            // ),
                          
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: keyboardIsOpened
            ? null
            : BlocBuilder<CustomerBloc, CustomerState>(
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: (state is UpdateCustomerValidState)
                        ? InkWell(
                            onTap: () async {
                              BlocProvider.of<CustomerBloc>(context).add(
                                  UpdateCustomerEvent(
                                      customerDob: dobController.text,
                                      customerBilling:
                                          billingCycleController.text,
                                      customerAddress: addressController.text,
                                      customerName: nameController.text,
                                      customerEmail: emailController.text,
                                      customerMobile: mobileController.text,
                                      customerUserGroup: selectedGroup,
                                      businessId:
                                          (widget.argus['selectedBusiness']
                                                  as BusinessListResponseData)
                                              .id!,
                                      userId: sph.getString("userid")!,
                                      customerId: (widget.argus['customerData']
                                              as SelectedCustomerResponseData)
                                          .id!));
                            },
                            child: Material(
                              elevation: 20,
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                  width: screenSize.width * 0.4,
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    "Save".toCapitalized(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ))),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              BlocProvider.of<CustomerBloc>(context).add(
                                  UpdateCustomerTextChangeEvent(
                                      customerName: nameController.text,
                                      customerEmail: emailController.text,
                                      customerMobile: mobileController.text,
                                      customerUserGroup: groupController.text,
                                      customerAddress: addressController.text,
                                      customerBilling:
                                          billingCycleController.text,
                                      customerDob: dobController.text));
                            },
                            child: Material(
                              elevation: 20,
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                  width: screenSize.width * 0.4,
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    "Save".toCapitalized(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ))),
                            ),
                          ),
                  );
                },
              ),
      ),
    );
  }

  Future<dynamic> showUserGroupListBottomSheet(BuildContext context) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<UserGroupBloc, UserGroupState>(
                builder: (context, state) {
                  return Container(
                    padding: MediaQuery.of(context).viewInsets,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(0.0)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.white, Colors.white])),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: (state is UserGroupListLoadedState)
                                ? state.successData!.length
                                : 0,
                            itemBuilder: (context, index) {
                              UserGroupResponseData? userGroupData =
                                  (state is UserGroupListLoadedState)
                                      ? state.successData![index]
                                      : null;
                              return Material(
                                elevation: 20,
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(colors: [
                                        Colors.white,
                                        Colors.white
                                      ])),
                                  child: ListTile(
                                    title: Text(
                                      userGroupData?.name ?? '',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 31, 1, 102),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      weight: 20.0,
                                      color: Color.fromARGB(255, 31, 1, 102),
                                    ),
                                    onTap: () {
                                      this.setState(() {
                                        selectedGroup = userGroupData;
                                        groupController.text =
                                            selectedGroup!.name ?? '';

                                        updatedData = true;
                                      });
                                      Navigator.pop(context);

                                      Talker().info(selectedGroup!.name);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      );

  Future<dynamic> showSelectedUserGroupBottomSheet(BuildContext context) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<UserGroupBloc, UserGroupState>(
                builder: (context, state) {
                  return Container(
                    padding: MediaQuery.of(context).viewInsets,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(0.0)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.white, Colors.white])),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          elevation: 20,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                    colors: [Colors.white, Colors.white])),
                            child: ListTile(
                              title: Text(
                                selectedGroup?.name ?? '',
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 31, 1, 102),
                                    fontWeight: FontWeight.w400),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                weight: 20.0,
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                              onTap: null,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                elevation: 20,
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white),
                            onPressed: () {
                              this.setState(
                                () {
                                  selectedGroup = null;
                                  groupController.text = '';
                                  updatedData = true;
                                },
                              );
                              Navigator.pop(context);
                            },
                            label: const Text("Remove"),
                            icon: const Icon(Icons.delete),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      );

  Future<dynamic> showFormForBillingCycleBottomSheet(BuildContext context) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            padding: MediaQuery.of(context).viewInsets,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0)),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Colors.white, Colors.white])),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  elevation: 20,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            colors: [Colors.white, Colors.white])),
                    child: ListTile(
                      title: const Text(
                        'Billing Cycle (in Days)',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 31, 1, 102),
                            fontWeight: FontWeight.w400),
                      ),
                      subtitle: Form(
                          child: TextFormField(
                              controller: billingCycleController,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 31, 1, 102),
                                  fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade300,
                                counterText: '',
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                      width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                      width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                      width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                      width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                      width: 2),
                                ),
                              ))),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        elevation: 20,
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      setState(
                        () {
                          billingCycleController.text =
                              billingCycleController.text;
                          updatedData = true;
                        },
                      );
                      Navigator.pop(context);
                    },
                    child: const Text("Update"),
                  ),
                )
              ],
            ),
          );
        },
      );

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
        addressController.text = add;
        sendUpdateAddress = res;
      });
    }
    BlocProvider.of<CustomerBloc>(context).add(UpdateCustomerTextChangeEvent(
        customerName: nameController.text,
        customerEmail: emailController.text,
        customerMobile: mobileController.text,
        customerUserGroup: groupController.text,
        customerAddress: addressController.text,
        customerBilling: billingCycleController.text,
        customerDob: dobController.text));
  }

  _navigateAndGetResultAddressUpdate(BuildContext context) async {
    final Map<String, dynamic>? res =
        await Navigator.pushNamed(context, '/add-business-address', arguments: {
      "address": sendUpdateAddress!['completeAddress'],
      "currentPostion": sendUpdateAddress!['currentPostion']
    }) as Map<String, dynamic>?;

    // Sending result back to FirstScreen
    Talker().info("Selected address:- ${res!['completeAddress'].toString()}");
    Iterator<MapEntry<String, dynamic>> i =
        res['completeAddress'].entries.iterator;
    addressController.clear();
    String add = '';
    while (i.moveNext()) {
      add += "${i.current.value},";
    }

    if (res != null) {
      setState(() {
        addressController.text = add;
        sendUpdateAddress = res;
      });
    }
    BlocProvider.of<CustomerBloc>(context).add(UpdateCustomerTextChangeEvent(
        customerName: nameController.text,
        customerEmail: emailController.text,
        customerMobile: mobileController.text,
        customerUserGroup: groupController.text,
        customerAddress: addressController.text,
        customerBilling: billingCycleController.text,
        customerDob: dobController.text));
  }
}
