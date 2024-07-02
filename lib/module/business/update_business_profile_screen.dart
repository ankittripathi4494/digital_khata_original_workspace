// ignore_for_file: must_be_immutable, unnecessary_null_comparison, unnecessary_nullable_for_final_variable_declarations, avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business/business_bloc/business_bloc.dart';
import 'package:dkapp/module/business/business_bloc/business_event.dart';
import 'package:dkapp/module/business/business_bloc/business_state.dart';
import 'package:dkapp/module/business_type/model/business_type_list_response_model.dart';
import 'package:dkapp/module/edit_profile/model/country_response_model.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/location_handler.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'model/business_list_response_model.dart';

class UpdateBusinessProfileScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  UpdateBusinessProfileScreen({super.key, required this.argus});

  @override
  State<UpdateBusinessProfileScreen> createState() =>
      _UpdateBusinessProfileScreenState();
}

class _UpdateBusinessProfileScreenState
    extends State<UpdateBusinessProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessWebsiteController = TextEditingController();
  TextEditingController businessTaxController = TextEditingController();

  TextEditingController businessContactController = TextEditingController();
  Map<String, dynamic>? sendUpdateAddress;
  Map<String, dynamic>? sendUpdateBusinessType;
  String? signatureImageFile;
  final ImagePicker _picker = ImagePicker();
  XFile? retailerImage;
  String? retailerImageFile;
  List<CountryResponseData>? countryList;
  CountryResponseData? selectedCountry;
  bool callFunc = false;
  Position? currentPostion;
  String? selectedCountryName;

  @override
  void initState() {
    getCountryList();

    super.initState();
  }

  getCountryList() async {
    var map = {};
    try {
      map['token'] = 'bnbuujn';
      map['search'] = '';

      http.Response response = await http.post(
          Uri.http(APIPathList.mainDomain, APIPathList.getCountryList),
          body: map,
          headers: {
            "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
          });

      if (response.statusCode == 200) {
        CountryResponseModel jsonResponse =
            CountryResponseModel.fromJson(convert.jsonDecode(response.body));

        if (jsonResponse.response != "failure") {
          if (kDebugMode) {
            print(jsonResponse.toString());
          }

          setState(() {
            countryList = jsonResponse.data;
            // selectedCountry = countryList!.first;
          });
        } else {
          EssentialWidgetsCollection.showErrorSnackbar(
              context, jsonResponse.message!);
        }
      } else {
        EssentialWidgetsCollection.showErrorSnackbar(
            context, 'Request failed with status: ${response.statusCode}.');
      }
    } on PlatformException {
      EssentialWidgetsCollection.showErrorSnackbar(
          context, 'Failed to get platform version.');
    }
    fillFormDetails();
  }

  fillFormDetails() {
    LocationHandler.getCurrentPosition().then(
      (value) {
        LocationHandler.getCountryFromLatLng(value!).then((vw) {
          for (CountryResponseData ex in countryList!) {
            if (ex.name == vw) {
              setState(() {
                selectedCountry = ex;
              });
            }
          }
          businessNameController.text =
              ((widget.argus['businessProfileData'] as BusinessListResponseData)
                          .bName !=
                      null)
                  ? (widget.argus['businessProfileData']
                          as BusinessListResponseData)
                      .bName!
                  : '';
          businessContactController.text =
              ((widget.argus['businessProfileData'] as BusinessListResponseData)
                          .mobile !=
                      null)
                  ? (widget.argus['businessProfileData']
                          as BusinessListResponseData)
                      .mobile!
                  : '';
          businessEmailController.text =
              ((widget.argus['businessProfileData'] as BusinessListResponseData)
                          .email !=
                      null)
                  ? (widget.argus['businessProfileData']
                          as BusinessListResponseData)
                      .email!
                  : '';
          businessWebsiteController.text =
              ((widget.argus['businessProfileData'] as BusinessListResponseData)
                          .website !=
                      null)
                  ? (widget.argus['businessProfileData']
                          as BusinessListResponseData)
                      .website!
                  : '';
          businessTaxController.text =
              ((widget.argus['businessProfileData'] as BusinessListResponseData)
                          .gstNo !=
                      null)
                  ? (widget.argus['businessProfileData']
                          as BusinessListResponseData)
                      .gstNo!
                  : '';
          businessAddressController.text =
              ((widget.argus['businessProfileData'] as BusinessListResponseData)
                          .address !=
                      null)
                  ? (widget.argus['businessProfileData']
                          as BusinessListResponseData)
                      .address!
                  : '';
          businessTypeController.text =
              ((widget.argus['businessProfileData'] as BusinessListResponseData)
                          .businessType !=
                      null)
                  ? (widget.argus['businessProfileData']
                          as BusinessListResponseData)
                      .businessType!
                  : '';
        });
      },
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      if (kDebugMode) {
        print("ERROR$error");
      }
    });
    return await Geolocator.getCurrentPosition();
  }

  showDeletePopup(context) async {
    // exit from app
    return showDialog(
        // barrierColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            title: const Text('Are you sure?'),
            content: const Text(
              'Once a business is deleted, all related \nkhata accounts and transactions will \nbe deleted forever. This data cant not be \nrecovered.',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.black),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      callFunc = true;
                    });
                  },
                  child: const Text(
                    'YES,DELETE',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          );
          // });
        });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Update Business Profile',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        actions: [
          BlocBuilder<BusinessBloc, BusinessState>(
            bloc: BusinessBloc()
              ..add(BusinessListFetchEvent(
                  userId: SharedPreferencesHelper().getString("userid")!)),
            builder: (context, state) {
              if (state is BusinessListLoadedState) {
                return IconButton(
                    onPressed: () {
                      if (state.successData!.length > 1) {
                        showDeletePopup(context);
                      } else {
                        EssentialWidgetsCollection.showErrorSnackbar(
                            context, "Business cannot delete !!");
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ));
              }
              return Container();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            (callFunc == true)
                ? EssentialWidgetsCollection.autoScheduleTask(
                    context,
                    childWidget: Container(),
                    taskWaitDuration: Durations.medium2,
                    task: () {
                      Navigator.pop(context);
                      BlocProvider.of<BusinessBloc>(context).add(
                          SelectedBusinessDeleteEvent(
                              userId: SharedPreferencesHelper()
                                  .getString("userid")!,
                              businessId: (widget.argus['businessProfileData']
                                      as BusinessListResponseData)
                                  .id!));

                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                        context,
                        '/business',
                      );
                    },
                  )
                : Container(),
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
                              borderRadius: BorderRadius.circular(80),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(retailerImage!.path)))),
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
                      backgroundColor: const Color.fromARGB(255, 31, 1, 102),
                      radius: 23,
                      child: IconButton(
                          onPressed: () async {
                            retailerImage = await _picker.pickImage(
                                maxHeight: 480,
                                maxWidth: 640,
                                source: ImageSource.gallery);
                            debugPrint(
                                "Captured Image From Camera :- ${retailerImage!.path}");
                            setState(() {
                              retailerImageFile = retailerImage!.path;
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
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenSize.width * 0.55,
                        top: screenSize.height * 0.01),
                    child: const Text(
                      'Business Name',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 18),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Business name can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      // if (_formKey.currentState!.validate()) {
                      //   print("Validated");
                      // } else {
                      //   print("Not Validated");
                      // }
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Kiran',
                      hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 31, 1, 102),
                          ),
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenSize.width * 0.55,
                        top: screenSize.height * 0.01),
                    child: const Text(
                      'Mobile number',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: businessContactController,
                          textCapitalization: TextCapitalization.words,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            // hintText: '+919867544367',
                            // hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.send_to_mobile),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenSize.width * 0.5,
                        top: screenSize.height * 0.01),
                    child: const Text(
                      'Business Address',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  DropdownButtonFormField<CountryResponseData>(
                    value: selectedCountry,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(8.0)),
                      // hintText: 'India (IN)',
                      // hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      // focusedBorder: OutlineInputBorder(
                      //     borderSide: const BorderSide(color: Colors.grey),
                      //     borderRadius: BorderRadius.circular(8.0)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    items: countryList
                        ?.map<DropdownMenuItem<CountryResponseData>>((c) {
                      return DropdownMenuItem(value: c, child: Text(c.name!));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenSize.width * 0.4,
                        top: screenSize.height * 0.01),
                    child: const Text(
                      'What your business do?',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  InkWell(
                    onTap: () => (sendUpdateBusinessType != null)
                        ? _navigateAndGetResultBusinessTypeUpdate(context)
                        : _navigateAndGetResultBusinessType(context),
                    child: TextFormField(
                      controller: businessTypeController,
                      enableInteractiveSelection: false,
                      enabled: false,
                      // onTap: () {
                      //   showGroupsPopup(context);
                      // },
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Education and Training',
                        hintStyle: const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0)),
                        // focusedBorder: OutlineInputBorder(
                        //     borderSide: const BorderSide(color: Colors.grey),
                        //     borderRadius: BorderRadius.circular(8.0)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenSize.width * 0.5,
                        top: screenSize.height * 0.01),
                    child: const Text(
                      'Business Address',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  InkWell(
                    onTap: () => (sendUpdateAddress != null)
                        ? _navigateAndGetResultAddressUpdate(context)
                        : _navigateAndGetResultAddress(context),
                    child: TextFormField(
                      controller: businessAddressController,
                      enableInteractiveSelection: false,
                      enabled: false,
                      // onTap: () {
                      //   showGroupsPopup(context);
                      // },
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0)),
                        // focusedBorder: OutlineInputBorder(
                        //     borderSide: const BorderSide(color: Colors.grey),
                        //     borderRadius: BorderRadius.circular(8.0)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: screenSize.width * 0.4,
                      top: screenSize.height * 0.01,
                    ),
                    child: const Text(
                      'Business Email Address',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  TextFormField(
                    controller: businessEmailController,
                    // controller: emailController,
                    // key: _formKey,
                    // onChanged: (value) {
                    //   if (_formKey.currentState!.validate()) {
                    //     print("Validated");
                    //   } else {
                    //     print("Not Validated");
                    //   }
                    // },
                    // onTap: () {
                    //   _formKey.currentState!.validate();
                    // },
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'you will get monthly report on this mail ID';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    // onTap: () {
                    // if (_formKey.currentState!.validate()) {
                    //   return print('validated');
                    // } else {
                    //   return print('Not Validated');
                    // }
                    // },
                    // enableInteractiveSelection: true,
                    enabled: true,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      // hintText: 'sample@gmail.com',
                      // hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 31, 1, 102),
                          ),
                          borderRadius: BorderRadius.circular(8.0)),
                      errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: screenSize.width * 0.47,
                    ),
                    child: const Text(
                      'you will get monthly report on this mail ID',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 8),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: screenSize.width * 0.68,
                      top: screenSize.height * 0.01,
                    ),
                    child: const Text(
                      'Website',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 18),
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
                    decoration: InputDecoration(
                      // hintText: 'Eg.www.sample.com',
                      // hintStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 31, 1, 102),
                          ),
                          borderRadius: BorderRadius.circular(8.0)),
                      errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: screenSize.width * 0.41,
                      top: screenSize.height * 0.01,
                    ),
                    child: const Text(
                      'Business Tax Number',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 18),
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
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 31, 1, 102),
                          ),
                          borderRadius: BorderRadius.circular(8.0)),
                      errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.06,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (kDebugMode) {
                          print("Validated");
                        }
                      } else {
                        if (kDebugMode) {
                          print("Not Validated");
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.35,
                          vertical: screenSize.height * 0.016),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 31, 1, 102),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.04,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _navigateAndGetResultAddress(BuildContext context) async {
    final Map<String, dynamic>? res = await Navigator.pushNamed(
      context,
      '/add-business-address',
    ) as Map<String, dynamic>?;

    print("Selected address:- ${res!['completeAddress'].toString()}");
    Iterator<MapEntry<String, dynamic>> i =
        res['completeAddress'].entries.iterator;
    while (i.moveNext()) {
      businessAddressController.text += "${i.current.value},";
    }

    if (res != null) {
      setState(() {
        sendUpdateAddress = res;
      });
    }
  }

  _navigateAndGetResultAddressUpdate(BuildContext context) async {
    final Map<String, dynamic>? res =
        await Navigator.pushNamed(context, '/add-business-address', arguments: {
      "address": sendUpdateAddress!['completeAddress'],
      "currentPostion": sendUpdateAddress!['currentPostion']
    }) as Map<String, dynamic>?;

    // Sending result back to FirstScreen
    print("Selected address:- ${res!['completeAddress'].toString()}");
    Iterator<MapEntry<String, dynamic>> i =
        res['completeAddress'].entries.iterator;
    businessAddressController.clear();
    while (i.moveNext()) {
      businessAddressController.text += "${i.current.value},";
    }

    if (res != null) {
      setState(() {
        sendUpdateAddress = res;
      });
    }
  }

  _navigateAndGetResultBusinessType(BuildContext context) async {
    String outputResultBusinessType = "";

    final Map<String, dynamic>? rese =
        await Navigator.pushNamed(context, '/business-type', arguments: {
      "choicesAndType": ((widget.argus['businessProfileData']
                      as BusinessListResponseData)
                  .businessType !=
              null)
          ? (widget.argus['businessProfileData'] as BusinessListResponseData)
              .businessType!
          : ''
    }) as Map<String, dynamic>;

    // Sending result back to FirstScreen
    print(
        "Selected Business Types:- ${(rese!['selectedData'] as List<BusinessTypeListResponseData>).map((c) => c.toJson().toString())}");
    print("Selected Choices:- ${rese['choices'].toString()}");

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
  }

  _navigateAndGetResultBusinessTypeUpdate(BuildContext context) async {
    String outputResultBusinessTypeUpdate = "";
    final Map<String, dynamic>? resa =
        await Navigator.pushNamed(context, '/business-type', arguments: {
      "selectedData": sendUpdateBusinessType!['selectedData'],
      "choices": sendUpdateBusinessType!['choices'],
      "choicesAndType": ((widget.argus['businessProfileData']
                      as BusinessListResponseData)
                  .businessType !=
              null)
          ? (widget.argus['businessProfileData'] as BusinessListResponseData)
              .businessType!
          : ''
    }) as Map<String, dynamic>?;

    // Sending result back to FirstScreen
    (resa!["selectedData"] as List<BusinessTypeListResponseData>).map((c) {
      print("Selected Business Types Update:- ${c.name}");
    });

    print(
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
  }
}
