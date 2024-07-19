// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_bloc.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_event.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/utils/exceptions.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talker/talker.dart';

class ProfileDetailScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ProfileDetailScreen({super.key, required this.argus});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen>
    with TickerProviderStateMixin {
  TextEditingController billingCycleController = TextEditingController();

  ScrollController? _scrollController;
  bool lastStatus = true;
  final ImagePicker _picker = ImagePicker();
  XFile? retailerImage;
  String? retailerImageFile;
  double height = 200;
  List<Map<String, dynamic>> contactList = [];
  List<Map<String, dynamic>> durationList = [
    {"id": '1', "duration": "7 days"},
    {"id": '2', "duration": "10 days"},
    {"id": '3', "duration": "15 days"},
    {"id": '4', "duration": "Custom"},
    {"id": '5', "duration": "Forever"},
  ];
  Map<String, dynamic>? selectedDuration;
  bool overdueRemainder = false;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
         decoration: BoxDecoration(color: Colors.grey[100]),
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.blue,
                pinned: true,
                expandedHeight: 310,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  title: _isShrink
                      ? Text(
                          (widget.argus['customerData']
                                  as SelectedCustomerResponseData)
                              .fullname!,
                          style: const TextStyle(color: Colors.white),
                        )
                      : null,
                  background: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 48),
                          child: ((retailerImage != null)
                              ? Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 80,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                    File(retailerImage!.path)))),
                                      ),
                                    ),
                                    Positioned(
                                      top: screenSize.height * 0.11,
                                      left: screenSize.width * 0.26,
                                      child: CircleAvatar(
                                          backgroundColor: const Color.fromARGB(
                                              255, 31, 1, 102),
                                          radius: 23,
                                          child: IconButton(
                                              onPressed: () async {
                                                retailerImage =
                                                    await _picker.pickImage(
                                                        maxHeight: 480,
                                                        maxWidth: 640,
                                                        source:
                                                            ImageSource.gallery);
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
                                )
                              : Stack(
                                  children: [
                                    CircleAvatar(
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
                                          backgroundColor: const Color.fromARGB(
                                              255, 31, 1, 102),
                                          radius: 23,
                                          child: IconButton(
                                              onPressed: () async {
                                                retailerImage =
                                                    await _picker.pickImage(
                                                        maxHeight: 480,
                                                        maxWidth: 640,
                                                        source:
                                                            ImageSource.gallery);
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
                                )),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          (widget.argus['customerData']
                                  as SelectedCustomerResponseData)
                              .fullname!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '\u{20B9} ${(((widget.argus['customerData'] as SelectedCustomerResponseData).creditAmount != null) ? double.parse((widget.argus['customerData'] as SelectedCustomerResponseData).creditAmount!) : 0) - (((widget.argus['customerData'] as SelectedCustomerResponseData).debitAmount != null) ? double.parse((widget.argus['customerData'] as SelectedCustomerResponseData).debitAmount!) : 0)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<CustomerBloc>(context).add(
                            CustomerDeleteEvent(
                                customerId: (widget.argus['customerData']
                                        as SelectedCustomerResponseData)
                                    .id!,
                                userId: SharedPreferencesHelper()
                                    .getString("userid")!,
                                businessId: (widget.argus['selectedBusiness']
                                        as BusinessListResponseData)
                                    .id!));
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/dashboard',
                            arguments: widget.argus);
                      },
                      icon: const Icon(Icons.delete_outline)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit-customer-screen',
                            arguments: {
                              'customerData': (widget.argus['customerData']
                                  as SelectedCustomerResponseData),
                              'selectedBusiness':
                                  (widget.argus['selectedBusiness']
                                      as BusinessListResponseData)
                            });
                      },
                      icon: const Icon(Icons.edit_square))
                ],
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                    child: ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text((widget.argus['customerData']
                                  as SelectedCustomerResponseData)
                              .mobile!),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.blue),
                            onPressed: () {
                              openAlternatNumberSheetAdd();
                            },
                            label: const Text("Alternate Numbers"),
                            icon: const Icon(Icons.add),
                          )
                        ],
                      ),
                    )),
                Container(
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
                    child: ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: Text((widget.argus['customerData']
                              as SelectedCustomerResponseData)
                          .email!),
                    )),
                Container(
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
                    child: const ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Text(
                        "Add Label..",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    )),
                Container(
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
                    child: ExpansionTile(
                      onExpansionChanged: null,
                      initiallyExpanded: true,
                      maintainState: true,
                      trailing: const SizedBox(),
                      shape: Border.all(color: Colors.transparent),
                      collapsedShape: Border.all(color: Colors.transparent),
                      title: Text(
                        "Communication".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            letterSpacing: 1.5),
                      ),
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          selected: true,
                          selectedColor: Colors.grey.withOpacity(0.5),
                          selectedTileColor: Colors.grey.withOpacity(0.5),
                          enabled: false,
                          leading: const Icon(
                            FontAwesomeIcons.paperPlane,
                            color: Colors.amber,
                            size: 30,
                          ),
                          title: const Padding(
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Remainders",
                            ),
                          ),
                          titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          subtitle: const Text(
                            "Remainders feature is turned off. You can turn it on My Business Screen",
                          ),
                          subtitleTextStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          trailing: CupertinoSwitch(
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            openDNDDurationList();
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          leading: const Icon(
                            FontAwesomeIcons.ban,
                            color: Colors.red,
                            size: 30,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Do not Disturb".toTitleCase(),
                            ),
                          ),
                          titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          subtitle: const Text(
                            "When this switch is on. automatic remainder messages will not be sent and manual remainder will be disabled till the end of DND period.",
                          ),
                          subtitleTextStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            openOverdueRemainderSheet();
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          leading: const Icon(
                            FontAwesomeIcons.calendarDays,
                            color: Colors.deepOrange,
                            size: 30,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Overdue Remainders".toTitleCase(),
                            ),
                          ),
                          titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          subtitle: const Text(
                            "When this switch is on. automatic remainder messages will not be sent and manual remainder will be disabled till the end of DND period.",
                          ),
                          subtitleTextStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          visualDensity:
                              const VisualDensity(vertical: -4, horizontal: 0),
                          onTap: () {
                            showFormForBillingCycleBottomSheet(context);
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          leading: const Icon(
                            FontAwesomeIcons.rotate,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Billing Cycle".toTitleCase(),
                                ),
                                (billingCycleController.text.isNotEmpty)
                                    ? Text(
                                        "${billingCycleController.text} days",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.green,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          leading: const Icon(
                            FontAwesomeIcons.rocketchat,
                            color: Colors.cyan,
                            size: 30,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Remainder Activity Log".toTitleCase(),
                            ),
                          ),
                          titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          subtitle: const Text(
                            "Check the remainder send to customer",
                          ),
                          subtitleTextStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showFormForBillingCycleBottomSheet(BuildContext context) =>
      showModalBottomSheet(
        showDragHandle: true,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        elevation: 20,
        sheetAnimationStyle: AnimationStyle(curve: Curves.bounceInOut),
        backgroundColor: Colors.white,
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

  openAlternatNumberSheetAdd() {
    showModalBottomSheet(
        showDragHandle: true,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        elevation: 20,
        sheetAnimationStyle: AnimationStyle(curve: Curves.bounceInOut),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            padding: MediaQuery.of(context).viewInsets,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple),
                      onPressed: () {},
                      child: const Text("Save")),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  openDNDDurationList() {
    showModalBottomSheet(
        showDragHandle: true,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: false,
        context: context,
        elevation: 20,
        sheetAnimationStyle: AnimationStyle(curve: Curves.bounceInOut),
        backgroundColor: Colors.white,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
                padding: MediaQuery.of(context).viewInsets,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: durationList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> duration = durationList[index];

                    return RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: duration,
                      groupValue: selectedDuration,
                      onChanged: (value) {
                        setState(() {
                          selectedDuration = value;
                        });
                      },
                      title: Text(
                        duration["duration"],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ));
          });
        });
  }

  openOverdueRemainderSheet() {
    showModalBottomSheet(
        useSafeArea: false,
        showDragHandle: true,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        elevation: 20,
        sheetAnimationStyle: AnimationStyle(curve: Curves.bounceInOut),
        backgroundColor: Colors.white,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.9, // Adjust this factor to set the height
            child: StatefulBuilder(builder: (context, setState) {
              setState(() {
                overdueRemainder = true;
              });
              return Container(
                  padding: MediaQuery.of(context).viewInsets,
                  width: MediaQuery.of(context).size.width,
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                      leading: IconButton(
                          onPressed: () {
                            setState(() {
                              overdueRemainder = !overdueRemainder;
                            });
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.circleArrowLeft,
                            size: 30,
                          )),
                      actions: [
                        Transform.scale(
                          scale:
                              0.7, // Adjust this value to change the size of the switch
                          child: CupertinoSwitch(
                            value: overdueRemainder,
                            onChanged: (value) {
                              setState(() {
                                overdueRemainder = !overdueRemainder;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                    body: Container(
                      margin: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            headingWidget(),
                          ],
                        ),
                      ),
                    ),
                  ));
            }),
          );
        });
  }

  headingWidget() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Remainder",
          style: TextStyle(
              fontSize: 20,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
            width: 100,
            child: Divider(
              color: Colors.green,
              height: 5,
              thickness: 5,
            )),
        SizedBox(
          height: 10,
        ),
        Text(
          "Set your due or payment cycle and desired remainder policy for this account",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
