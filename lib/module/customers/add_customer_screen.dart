// ignore_for_file: must_be_immutable, avoid_print

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
import 'package:dkapp/utils/exceptions.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCustomerScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  AddCustomerScreen({super.key, required this.argus});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  UserGroupResponseData? selectedGroup;
  List<UserGroupResponseData> usergroupList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController groupController = TextEditingController();
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
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
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
            "Add Account",
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
        body: Column(
          children: [
            (updatedData == true)
                ? EssentialWidgetsCollection.autoScheduleTask(context,
                    task: () {
                    print("datya");
                    setState(() {
                      updatedData = false;
                    });
                    BlocProvider.of<CustomerBloc>(context).add(
                        AddCustomerTextChangeEvent(
                            customerName: nameController.text,
                            customerEmail: emailController.text,
                            customerMobile: mobileController.text,
                            customerUserGroup: groupController.text));
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
                    },
                  );
                }
                if (state is UserGroupListFailedState) {
                  return EssentialWidgetsCollection.autoScheduleTask(
                    context,
                    childWidget: Container(),
                    taskWaitDuration: Durations.short4,
                    task: () {
                      print("faield");
                      setState(() {
                        usergroupList.addAll([]);
                      });
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
                          (state is AddNewCustomerSuccessState)
                              ? EssentialWidgetsCollection.autoScheduleTask(
                                  context,
                                  childWidget: Container(),
                                  taskWaitDuration: Durations.long2,
                                  task: () {
                                    EssentialWidgetsCollection
                                        .showSuccessSnackbar(
                                            context, state.successMessage);

                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/dashboard');
                                  },
                                )
                              : Container(),
                          (state is AddNewCustomerFailedState)
                              ? EssentialWidgetsCollection.autoScheduleTask(
                                  context,
                                  childWidget: Container(),
                                  taskWaitDuration: Durations.long2,
                                  task: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/add-customer',
                                        arguments: widget.argus);
                                    EssentialWidgetsCollection
                                        .showErrorSnackbar(
                                            context, state.failedMessage);
                                  },
                                )
                              : Container(),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            height:
                                (state is AddNewCustomerTextChangedErrorState)
                                    ? 80
                                    : 50,
                            child: TextFormField(
                              controller: nameController,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 31, 1, 102)),
                              onChanged: (value) {
                                BlocProvider.of<CustomerBloc>(context).add(
                                    AddCustomerTextChangeEvent(
                                        customerName: nameController.text,
                                        customerEmail: emailController.text,
                                        customerMobile: mobileController.text,
                                        customerUserGroup:
                                            groupController.text));
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
                                        is AddNewCustomerTextChangedErrorState)
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
                                (state is AddNewCustomerTextChangedErrorState)
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
                                      AddCustomerTextChangeEvent(
                                          customerName: nameController.text,
                                          customerEmail: emailController.text,
                                          customerMobile: mobileController.text,
                                          customerUserGroup:
                                              groupController.text));
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
                                          is AddNewCustomerTextChangedErrorState)
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
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            height:
                                (state is AddNewCustomerTextChangedErrorState)
                                    ? 80
                                    : 50,
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 31, 1, 102)),
                              onChanged: (value) {
                                BlocProvider.of<CustomerBloc>(context).add(
                                    AddCustomerTextChangeEvent(
                                        customerName: nameController.text,
                                        customerEmail: emailController.text,
                                        customerMobile: mobileController.text,
                                        customerUserGroup:
                                            groupController.text));
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade300,
                                counterText: '',
                                prefixIcon: const Icon(Icons.mail),
                                prefixIconColor:
                                    const Color.fromARGB(255, 31, 1, 102),
                                labelText: "Enter Email",
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
                                        is AddNewCustomerTextChangedErrorState)
                                    ? state.customerEmailError
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
                                (state is AddNewCustomerTextChangedErrorState)
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
                                            is AddNewCustomerTextChangedErrorState)
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
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              nameController.text = '';
                              mobileController.text = '';
                              emailController.text = '';
                            });
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, '/dashboard',
                                arguments: widget.argus);
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
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  "Cancel".toCapitalized(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ))),
                          ),
                        ),
                        (state is AddNewCustomerValidState)
                            ? InkWell(
                                onTap: () async {
                                  BlocProvider.of<CustomerBloc>(context).add(
                                      AddCustomerEvent(
                                          customerName: nameController.text,
                                          customerEmail: emailController.text,
                                          customerMobile: mobileController.text,
                                          customerUserGroup: selectedGroup,
                                          businessId: (widget
                                                      .argus['selectedBusiness']
                                                  as BusinessListResponseData)
                                              .id!,
                                          userId: sph.getString("userid")!));
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                      AddCustomerTextChangeEvent(
                                          customerName: nameController.text,
                                          customerEmail: emailController.text,
                                          customerMobile: mobileController.text,
                                          customerUserGroup:
                                              groupController.text));
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        "Save".toCapitalized(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ))),
                                ),
                              ),
                      ],
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

                                      print(selectedGroup!.name);
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
}
