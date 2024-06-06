// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/account/model/account_response_model.dart';
import 'package:dkapp/module/edit_profile/model/country_response_model.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EditPersonalProfileScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  EditPersonalProfileScreen({super.key, required this.argus});

  @override
  State<EditPersonalProfileScreen> createState() =>
      _EditPersonalProfileScreenState();
}

class _EditPersonalProfileScreenState extends State<EditPersonalProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? retailerImage;
  String? retailerImageFile;
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  List<CountryResponseData>? countryList;
  CountryResponseData? selectedCountry;

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
    nameController.text =
        ((widget.argus['userProfileDetails'] as AccountResponseData).fullname !=
                null)
            ? (widget.argus['userProfileDetails'] as AccountResponseData)
                .fullname!
            : '';
    contactController.text =
        ((widget.argus['userProfileDetails'] as AccountResponseData).fullname !=
                null)
            ? (widget.argus['userProfileDetails'] as AccountResponseData).phone!
            : '';
    emailController.text =
        ((widget.argus['userProfileDetails'] as AccountResponseData).fullname !=
                null)
            ? (widget.argus['userProfileDetails'] as AccountResponseData).email!
            : '';
    dobController.text =
        ((widget.argus['userProfileDetails'] as AccountResponseData).fullname !=
                null)
            ? (widget.argus['userProfileDetails'] as AccountResponseData).dob!
            : '';

    for (CountryResponseData ex in countryList!) {
      if (ex.id ==
          (widget.argus['userProfileDetails'] as AccountResponseData).id) {
        setState(() {
          selectedCountry = ex;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/accounts');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/accounts');
            },
          ),
          title: const Text(
            'Edit Personal Profile',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ((widget.argus['userProfileDetails'] as AccountResponseData)
                          .profileImage !=
                      null)
                  ? (retailerImage != null)
                      ? Stack(
                          children: [
                            CircleAvatar(
                              foregroundImage:
                                  FileImage(File(retailerImage!.path)),
                              radius: 100,
                            ),
                            Positioned(
                              top: 100,
                              left: 150,
                              child: InkWell(
                                onTap: () async {
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
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 31, 1, 102),
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Colors.white),
                                  // radius: 15,
                                  // backgroundColor: Colors.white,
                                  child: const Icon(
                                    Icons.edit,
                                    size: 12,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Stack(
                          children: [
                            CircleAvatar(
                              foregroundImage: NetworkImage(
                                  "http://64.227.150.208/khatabook/upload/${(widget.argus['userProfileDetails'] as AccountResponseData).profileImage}.png"),
                              radius: 100,
                            ),
                            Positioned(
                              top: 100,
                               left: 150,
                              child: InkWell(
                                onTap: () async {
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
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 31, 1, 102),
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Colors.white),
                                  // radius: 15,
                                  // backgroundColor: Colors.white,
                                  child: const Icon(
                                    Icons.edit,
                                    size: 12,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                  : ((retailerImage != null)
                      ? Stack(
                          children: [
                            CircleAvatar(
                              foregroundImage:
                                  FileImage(File(retailerImage!.path)),
                              radius: 100,
                            ),
                            Positioned(
                              top: 100,
                              left: 150,
                              child: InkWell(
                                onTap: () async {
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
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 31, 1, 102),
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Colors.white),
                                  // radius: 15,
                                  // backgroundColor: Colors.white,
                                  child: const Icon(
                                    Icons.edit,
                                    size: 12,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Stack(
                          children: [
                            Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 30.0),
                                padding: const EdgeInsets.all(30.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(
                                      color:
                                          const Color.fromARGB(255, 31, 1, 102),
                                    ),
                                    borderRadius: BorderRadius.circular(100)),
                                child: const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: screenSize.width * 0.56,
                              child: InkWell(
                                onTap: () async {
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
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 31, 1, 102),
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Colors.white),
                                  // radius: 15,
                                  // backgroundColor: Colors.white,
                                  child: const Icon(
                                    Icons.edit,
                                    size: 12,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: screenSize.width * 0.63,
                          top: screenSize.height * 0.01),
                      child: const Text(
                        'Your Name',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    TextFormField(
                      // key: _formKey,
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name can\'t be empty';
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
                        // hintText: ' Kiran',
                        // hintStyle: const TextStyle(color: Colors.grey),
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
                          right: screenSize.width * 0.56,
                          top: screenSize.height * 0.01),
                      child: const Text(
                        'Mobile Number',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    TextFormField(
                      // key: _formKey,
                      controller: contactController,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Contact can\'t be empty';
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
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,

                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit_square,
                              color: Color.fromARGB(255, 31, 1, 102),
                            )),
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
                          right: screenSize.width * 0.7,
                          top: screenSize.height * 0.01),
                      child: const Text(
                        'Country',
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
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 5.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 31, 1, 102),
                            ),
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      items: countryList
                          ?.map<DropdownMenuItem<CountryResponseData>>((c) {
                        return DropdownMenuItem(value: c, child: Text(c.name!));
                      }).toList(),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: screenSize.width * 0.57,
                        top: screenSize.height * 0.01,
                      ),
                      child: const Text(
                        'Email Address',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    TextFormField(
                      controller: emailController,
                      enabled: true,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
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
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //     right: screenSize.width * 0.47,
                    //   ),
                    //   child: const Text(
                    //     'you will get monthly report on this mail ID',
                    //     textAlign: TextAlign.start,
                    //     style: TextStyle(color: Colors.grey, fontSize: 8),
                    //   ),
                    // ),
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: screenSize.width * 0.59,
                        top: screenSize.height * 0.01,
                      ),
                      child: const Text(
                        'Date of Birth',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    InkWell(
                      onTap: () async {
                        showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100))
                            .then((v) {
                          setState(() {
                            dobController.text = DateFormat('d-M-y')
                                .format(DateTime.parse(v.toString()));
                          });
                        });
                      },
                      child: TextFormField(
                        controller: dobController,
                        enableInteractiveSelection: false,
                        enabled: false,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.calendar_month)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                              borderRadius: BorderRadius.circular(8.0)),
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                          errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.06,
                    ),
                    InkWell(
                      onTap: () {
                        updatePersonalProfileImage();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.38,
                            vertical: screenSize.height * 0.016),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 31, 1, 102),
                            borderRadius: BorderRadius.circular(5.0)),
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
      ),
    );
  }

  updatePersonalProfileImage() async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.http(APIPathList.mainDomain, APIPathList.updateProfileImage));
      request.fields["token"] = 'bnbuujn';
      request.fields['user_id'] =
          (widget.argus['userProfileDetails'] as AccountResponseData).id!;
      request.headers["HTTP_AUTHORIZATION"] =
          '${DateTime.now().millisecondsSinceEpoch}';
      request.files.add(await http.MultipartFile.fromPath(
          "profile_image", retailerImage!.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        // Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/accounts');
        EssentialWidgetsCollection.showSuccessSnackbar(
            context, response.reasonPhrase!);
      } else {
        EssentialWidgetsCollection.showErrorSnackbar(
            context, 'Request failed with status: ${response.statusCode}.');
      }
    } on PlatformException {
      EssentialWidgetsCollection.showErrorSnackbar(
          context, 'Failed to get platform version.');
    }
  }
}
