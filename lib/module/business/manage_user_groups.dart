// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:dkapp/global_blocs/internet/internet_cubit.dart';
import 'package:dkapp/global_blocs/internet/internet_state.dart';
import 'package:dkapp/global_widget/animated_loading_placeholder_widget.dart';
import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/business/model/user_group_model.dart';
import 'package:dkapp/module/business/user_group_bloc/user_group_bloc.dart';
import 'package:dkapp/module/business/user_group_bloc/user_group_event.dart';
import 'package:dkapp/module/business/user_group_bloc/user_group_state.dart';
import 'package:dkapp/utils/exceptions.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ManageUseGroups extends StatefulWidget {
  late Map<String, dynamic> argus;
  ManageUseGroups({super.key, required this.argus});

  @override
  State<ManageUseGroups> createState() => _ManageUseGroupsState();
}

class _ManageUseGroupsState extends State<ManageUseGroups> {
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool showLoader = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  List<Contact>? _contacts;
  @override
  void initState() {
    fetchUserGroupList();
    super.initState();
  }

  fetchUserGroupList() {
    BlocProvider.of<UserGroupBloc>(context).add(UserGroupListFetchEvent(
        userId: sph.getString("userid")!,
        businessId: BusinessListResponseData.fromJson(
                jsonDecode(jsonEncode(widget.argus['businessData'])))
            .id!));
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetLost) {
          Map<String, dynamic> tempData = {};
          tempData.addEntries(widget.argus.entries);
          tempData.addEntries([const MapEntry("page", "accounts")]);
          // tempData = widget.argus.addEntries([const MapEntry("page", "login")]);
          Timer(Durations.medium2, () {
            Navigator.pushReplacementNamed(context, '/no-internet',
                arguments: tempData);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Manage User Group',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: BlocBuilder<UserGroupBloc, UserGroupState>(
            builder: (context, state) {
              if (state is UserGroupListLoadedState) {
                return SmartRefresher(
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

                    setState(() {
                      nameController.text = '';
                      mobileController.text = '';
                      descriptionController.text = '';
                    });
                    BlocProvider.of<UserGroupBloc>(context).add(
                        UserGroupListFetchEvent(
                            userId: sph.getString("userid")!,
                            businessId: BusinessListResponseData.fromJson(
                                    jsonDecode(jsonEncode(
                                        widget.argus['businessData'])))
                                .id!));
                  }),
                  onLoading: (() async {
                    await Future.delayed(const Duration(milliseconds: 1000));
                    // if failed,use loadFailed(),if no data return,use LoadNodata()

                    if (mounted) setState(() {});
                    refreshController.loadComplete();
                  }),
                  child: ListView.builder(
                    itemCount: state.successData!.length,
                    itemBuilder: (context, index) {
                      UserGroupResponseData userGroupData =
                          state.successData![index];
                      return Material(
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
                              userGroupData.name!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                  fontWeight: FontWeight.w700),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  userGroupData.mobile!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 31, 1, 102),
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  userGroupData.description!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 31, 1, 102),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              weight: 20.0,
                              color: Color.fromARGB(255, 31, 1, 102),
                            ),
                            onTap: () {
                              nameController.text = userGroupData.name!;
                              mobileController.text = userGroupData.mobile!;
                              descriptionController.text =
                                  userGroupData.description!;
                              editGroupBottomSheet(context, userGroupData);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is UserGroupListLoadingState) {
                return const Center(
                  child: AnimatedImageLoader(),
                );
              }
              if (state is UserGroupListFailedState) {
                return const Center(
                  child: Text("No User Group Found"),
                );
              }
              return const Center(
                child: AnimatedImageLoader(),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 31, 1, 102),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          onPressed: () => createGroupBottomSheet(context),
          child: const Icon(
            Icons.add,
            size: 28,
          ),
        ),
      ),
    );
  }

  Future<dynamic> editGroupBottomSheet(
          BuildContext context, UserGroupResponseData data) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: StatefulBuilder(
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
                      child: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: const Text(
                                    "Update Group",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                height: (state
                                        is AddNewUserGroupTextChangedErrorState)
                                    ? 80
                                    : 50,
                                child: TextFormField(
                                  controller: nameController,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 31, 1, 102)),
                                  onChanged: (value) {
                                    BlocProvider.of<UserGroupBloc>(context).add(
                                        AddNewUserGroupTextChangedEvent(
                                            groupName: nameController.text,
                                            groupMobile: mobileController.text,
                                            groupDescription:
                                                descriptionController.text));
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    prefixIcon: const Icon(Icons.person),
                                    prefixIconColor:
                                        const Color.fromARGB(255, 31, 1, 102),
                                    labelText: "Enter Group Name",
                                    labelStyle: const TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102)),
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
                                            is AddNewUserGroupTextChangedErrorState)
                                        ? state.groupNameError
                                        : null,
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
                                    horizontal: 20, vertical: 10),
                                height: (state
                                        is AddNewUserGroupTextChangedErrorState)
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
                                      BlocProvider.of<UserGroupBloc>(context)
                                          .add(AddNewUserGroupTextChangedEvent(
                                              groupName: nameController.text,
                                              groupMobile:
                                                  mobileController.text,
                                              groupDescription:
                                                  descriptionController.text));
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade300,
                                      counterText: '',
                                      prefix: const Text(
                                        "+91 ",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            pickContactAndSelect();
                                          },
                                          icon: const Icon(
                                              Icons.contact_phone_outlined)),
                                      suffixIconColor:
                                          const Color.fromARGB(255, 31, 1, 102),
                                      labelText: "Enter Mobile Number",
                                      labelStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 1, 102)),
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
                                              is AddNewUserGroupTextChangedErrorState)
                                          ? state.groupMobileError
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
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                height: (state
                                        is AddNewUserGroupTextChangedErrorState)
                                    ? 80
                                    : 50,
                                child: TextFormField(
                                  controller: descriptionController,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 31, 1, 102)),
                                  onChanged: (value) {
                                    BlocProvider.of<UserGroupBloc>(context).add(
                                        AddNewUserGroupTextChangedEvent(
                                            groupName: nameController.text,
                                            groupMobile: mobileController.text,
                                            groupDescription:
                                                descriptionController.text));
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    counterText: '',
                                    prefixIcon: const Icon(Icons.description),
                                    prefixIconColor:
                                        const Color.fromARGB(255, 31, 1, 102),
                                    labelText: "Enter Description",
                                    labelStyle: const TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102)),
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
                                            is AddNewUserGroupTextChangedErrorState)
                                        ? state.groupDescriptionError
                                        : null,
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
                                  horizontal: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          EssentialWidgetsCollection
                                              .showAlertDialogForLogout(context,
                                                  content:
                                                      "Do you want to delete this user group?",
                                                  taskOne: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            BlocProvider.of<UserGroupBloc>(
                                                    context)
                                                .add(UserGroupDeleteEvent(
                                                    groupId: data.id!,
                                                    userId: sph
                                                        .getString("userid")!,
                                                    businessId: BusinessListResponseData
                                                            .fromJson(jsonDecode(
                                                                jsonEncode(widget
                                                                        .argus[
                                                                    'businessData'])))
                                                        .id!));

                                            Navigator.pushReplacementNamed(
                                                context, '/manage-user-group',
                                                arguments: widget.argus);
                                          }, taskTwo: () {
                                            Navigator.pop(context);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.delete_outlined,
                                          size: 50,
                                          color: Colors.red,
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                nameController.text = '';
                                                mobileController.text = '';
                                                descriptionController.text = '';
                                              });
                                              Navigator.pop(context);
                                              Navigator.pushReplacementNamed(
                                                  context, '/manage-user-group',
                                                  arguments: widget.argus);
                                            },
                                            child: Material(
                                              elevation: 20,
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                  width: 100,
                                                  height: 50,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                      child: Text(
                                                    "Cancel".toCapitalized(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ))),
                                            ),
                                          ),
                                          (state is AddNewUserGroupValidState)
                                              ? InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      showLoader = true;
                                                    });
                                                    (showLoader == true)
                                                        ? showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                false,
                                                            builder: (context) {
                                                              return const AlertDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                title:
                                                                    AnimatedImageLoader(),
                                                              );
                                                            },
                                                          )
                                                        : Container();
                                                    updateUserGroupTrigger(
                                                        context: context,
                                                        userGroupData: data,
                                                        groupName:
                                                            nameController.text,
                                                        groupMobile:
                                                            mobileController
                                                                .text,
                                                        groupDescription:
                                                            descriptionController
                                                                .text,
                                                        userId: sph.getString(
                                                            "userid")!,
                                                        businessId: BusinessListResponseData
                                                                .fromJson(jsonDecode(
                                                                    jsonEncode(widget
                                                                            .argus[
                                                                        'businessData'])))
                                                            .id!);
                                                  },
                                                  child: Material(
                                                    elevation: 20,
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Container(
                                                        width: 100,
                                                        height: 50,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 5,
                                                            vertical: 10),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                            child: Text(
                                                          "Update"
                                                              .toCapitalized(),
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ))),
                                                  ),
                                                )
                                              : Material(
                                                  elevation: 20,
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Container(
                                                      width: 100,
                                                      height: 50,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5,
                                                          vertical: 10),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Center(
                                                          child: Text(
                                                        "Update"
                                                            .toCapitalized(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ))),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      );

  updateUserGroupTrigger(
      {BuildContext? context,
      UserGroupResponseData? userGroupData,
      String? groupName,
      String? groupMobile,
      String? groupDescription,
      String? userId,
      String? businessId}) {
    Navigator.pop(context!);
    Navigator.pop(context);
    BlocProvider.of<UserGroupBloc>(context).add(UpdateUserGroupEvent(
        groupId: userGroupData!.id!,
        groupName: groupName!,
        groupMobile: groupMobile!,
        groupDescription: groupDescription!,
        userId: userId!,
        businessId: businessId!));
    Navigator.pushReplacementNamed(context, '/manage-user-group',
        arguments: widget.argus);
  }

  Future<dynamic> createGroupBottomSheet(BuildContext context) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: StatefulBuilder(
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
                      child: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: const Text(
                                    "Add Group",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                height: (state
                                        is AddNewUserGroupTextChangedErrorState)
                                    ? 80
                                    : 50,
                                child: TextFormField(
                                  controller: nameController,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 31, 1, 102)),
                                  onChanged: (value) {
                                    BlocProvider.of<UserGroupBloc>(context).add(
                                        AddNewUserGroupTextChangedEvent(
                                            groupName: nameController.text,
                                            groupMobile: mobileController.text,
                                            groupDescription:
                                                descriptionController.text));
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    prefixIcon: const Icon(Icons.person),
                                    prefixIconColor:
                                        const Color.fromARGB(255, 31, 1, 102),
                                    labelText: "Enter Group Name",
                                    labelStyle: const TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102)),
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
                                            is AddNewUserGroupTextChangedErrorState)
                                        ? state.groupNameError
                                        : null,
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
                                    horizontal: 20, vertical: 10),
                                height: (state
                                        is AddNewUserGroupTextChangedErrorState)
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
                                      BlocProvider.of<UserGroupBloc>(context)
                                          .add(AddNewUserGroupTextChangedEvent(
                                              groupName: nameController.text,
                                              groupMobile:
                                                  mobileController.text,
                                              groupDescription:
                                                  descriptionController.text));
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade300,
                                      counterText: '',
                                      prefix: const Text(
                                        "+91 ",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            pickContactAndSelect();
                                          },
                                          icon: const Icon(
                                              Icons.contact_phone_outlined)),
                                      suffixIconColor:
                                          const Color.fromARGB(255, 31, 1, 102),
                                      labelText: "Enter Mobile Number",
                                      labelStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 1, 102)),
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
                                              is AddNewUserGroupTextChangedErrorState)
                                          ? state.groupMobileError
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
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                height: (state
                                        is AddNewUserGroupTextChangedErrorState)
                                    ? 80
                                    : 50,
                                child: TextFormField(
                                  controller: descriptionController,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 31, 1, 102)),
                                  onChanged: (value) {
                                    BlocProvider.of<UserGroupBloc>(context).add(
                                        AddNewUserGroupTextChangedEvent(
                                            groupName: nameController.text,
                                            groupMobile: mobileController.text,
                                            groupDescription:
                                                descriptionController.text));
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    counterText: '',
                                    prefixIcon: const Icon(Icons.description),
                                    prefixIconColor:
                                        const Color.fromARGB(255, 31, 1, 102),
                                    labelText: "Enter Description",
                                    labelStyle: const TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102)),
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
                                            is AddNewUserGroupTextChangedErrorState)
                                        ? state.groupDescriptionError
                                        : null,
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
                                  horizontal: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                nameController.text = '';
                                                mobileController.text = '';
                                                descriptionController.text = '';
                                              });
                                              Navigator.pop(context);
                                              Navigator.pushReplacementNamed(
                                                  context, '/manage-user-group',
                                                  arguments: widget.argus);
                                            },
                                            child: Material(
                                              elevation: 20,
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                  width: 100,
                                                  height: 50,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                      child: Text(
                                                    "Cancel".toCapitalized(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ))),
                                            ),
                                          ),
                                          (state is AddNewUserGroupValidState)
                                              ? InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      showLoader = true;
                                                    });
                                                    (showLoader == true)
                                                        ? showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                false,
                                                            builder: (context) {
                                                              return const AlertDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                title:
                                                                    AnimatedImageLoader(),
                                                              );
                                                            },
                                                          )
                                                        : Container();
                                                    createUserGroupTrigger(
                                                        context: context,
                                                        groupName:
                                                            nameController.text,
                                                        groupMobile:
                                                            mobileController
                                                                .text,
                                                        groupDescription:
                                                            descriptionController
                                                                .text,
                                                        userId: sph.getString(
                                                            "userid")!,
                                                        businessId: BusinessListResponseData
                                                                .fromJson(jsonDecode(
                                                                    jsonEncode(widget
                                                                            .argus[
                                                                        'businessData'])))
                                                            .id!);
                                                  },
                                                  child: Material(
                                                    elevation: 20,
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Container(
                                                        width: 100,
                                                        height: 50,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 5,
                                                            vertical: 10),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                            child: Text(
                                                          "Add".toCapitalized(),
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ))),
                                                  ),
                                                )
                                              : Material(
                                                  elevation: 20,
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Container(
                                                      width: 100,
                                                      height: 50,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5,
                                                          vertical: 10),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Center(
                                                          child: Text(
                                                        "Add".toCapitalized(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ))),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      );

  createUserGroupTrigger(
      {BuildContext? context,
      String? groupName,
      String? groupMobile,
      String? groupDescription,
      String? userId,
      String? businessId}) {
    Navigator.pop(context!);
    Navigator.pop(context);
    BlocProvider.of<UserGroupBloc>(context).add(AddNewUserGroupEvent(
        groupName: groupName!,
        groupMobile: groupMobile!,
        groupDescription: groupDescription!,
        userId: userId!,
        businessId: businessId!));
    if (widget.argus.containsKey("fromUserGroup")) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, '/manage-user-group',
          arguments: widget.argus);
    }
  }

  pickContactAndSelect() async {
    Contact? contact = await _contactPicker.selectContact();
    setState(() {
      _contacts = contact == null ? null : [contact];
      mobileController.text =
          _contacts!.first.phoneNumbers!.first.replaceAll("+91", '');
    });
  }
}
