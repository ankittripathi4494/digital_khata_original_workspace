// ignore_for_file: must_be_immutable, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/account/model/account_response_model.dart';
import 'package:dkapp/module/edit_profile/model/country_response_model.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/image_list.dart';
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
        ((widget.argus['userProfileDetails'] as AccountResponseData).phone !=
                null)
            ? (widget.argus['userProfileDetails'] as AccountResponseData).phone!
            : '';
    emailController.text =
        ((widget.argus['userProfileDetails'] as AccountResponseData).email !=
                null)
            ? (widget.argus['userProfileDetails'] as AccountResponseData).email!
            : '';
    dobController.text = ((widget.argus['userProfileDetails']
                    as AccountResponseData)
                .dob !=
            null)
        ? DateFormat('y-M-d').format(DateTime.parse(
            (widget.argus['userProfileDetails'] as AccountResponseData).dob!))
        : '';

    for (CountryResponseData ex in countryList!) {
      if (ex.id ==
          (widget.argus['userProfileDetails'] as AccountResponseData)
              .countryId) {
        setState(() {
          selectedCountry = ex;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
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
                            backgroundColor: Colors.transparent,
                            radius: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
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
                                backgroundColor:
                                    const Color.fromARGB(255, 31, 1, 102),
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
                      )
                    : Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                "${NetworkImagePathList.imagePath}${(widget.argus['userProfileDetails'] as AccountResponseData).profileImage!}",
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 80,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider)),
                              ),
                            ),
                            placeholder: (context, url) => CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              radius: 80,
                              child: const AnimatedImageLoader(),
                            ),
                            errorWidget: (context, url, error) => CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              radius: 80,
                              child: Image.asset(
                                'resources/images/house-icon-removebg-preview.png',
                                height: 80,
                                width: 80,
                              ),
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
                      )
                : ((retailerImage != null)
                    ? Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
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
                                backgroundColor:
                                    const Color.fromARGB(255, 31, 1, 102),
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
                                backgroundColor:
                                    const Color.fromARGB(255, 31, 1, 102),
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
                      )),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          // right: screenSize.width * 0.56,
                          top: screenSize.height * 0.01),
                      child: const Text(
                        'Your Name',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
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
                  Align(
                     alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          // right: screenSize.width * 0.56,
                          top: screenSize.height * 0.01),
                      child: const Text(
                        'Mobile Number',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
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
                  Align(
                     alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          // right: screenSize.width * 0.7,
                          top: screenSize.height * 0.01),
                      child: const Text(
                        'Country',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  DropdownButtonFormField<CountryResponseData>(
                    isExpanded: true,
                    value: selectedCountry,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 5.0),
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
                      return DropdownMenuItem(value: c, child: Text(c.name!, 
                      
                      overflow: TextOverflow.ellipsis,));
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
                  Align(
                     alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        // right: screenSize.width * 0.57,
                        top: screenSize.height * 0.01,
                      ),
                      child: const Text(
                        'Email Address',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
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
                  Align(
                     alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        // right: screenSize.width * 0.59,
                        top: screenSize.height * 0.01,
                      ),
                      child: const Text(
                        'Date of Birth',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
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
                          dobController.text = DateFormat('y-M-d')
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
                      if (retailerImage != null) {
                        print("Update Data:- ${retailerImage!.path}");
                        updatePersonalProfileImage();
                      } else {
                        updatePersonalProfile();
                      }

                      // updatePersonalProfileImage();
                    },
                    child: Container(
                     
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.35,
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
    );
  }

  Future<dynamic> updatePersonalProfileImage() async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.http(APIPathList.mainDomain, APIPathList.updateProfileImage));
      request.fields["token"] = 'bnbuujn';
      request.fields['user_id'] =
          (widget.argus['userProfileDetails'] as AccountResponseData).id!;
      request.headers["HTTP_AUTHORIZATION"] =
          '${DateTime.now().millisecondsSinceEpoch}';
      request.files.add(await http.MultipartFile.fromPath(
          "profile_image", File(retailerImageFile!).path));

      print(request.files.first.filename);

      var response = await request.send();
      if (response.statusCode == 200) {
        updatePersonalProfile();
        // Navigator.pop(context);
      } else {
        EssentialWidgetsCollection.showErrorSnackbar(
            context, 'Request failed with status: ${response.statusCode}.');
      }
    } on PlatformException {
      EssentialWidgetsCollection.showErrorSnackbar(
          context, 'Failed to get platform version.');
    }
  }

  updatePersonalProfile() async {
    var map = {};

    try {
      map['token'] = 'bnbuujn';
      map['user_id'] =
          (widget.argus['userProfileDetails'] as AccountResponseData).id!;
      map['phone'] = contactController.text;
      map['fullname'] = nameController.text;
      map['email'] = emailController.text;
      map['country_id'] = selectedCountry?.id;
      map['dob'] = dobController.text;
      print("Input Map :- $map");
      http.Response response = await http.post(
          Uri.http(APIPathList.mainDomain, APIPathList.updateUserProfile),
          body: map,
          headers: {
            "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
          });
      print(response.body);
      if (response.statusCode == 200) {
        AccountResponseModel jsonResponse =
            AccountResponseModel.fromJson(convert.jsonDecode(response.body));

        if (jsonResponse.response != "failure") {
          if (kDebugMode) {
            print(jsonResponse.response.toString());
          }

          Navigator.pushReplacementNamed(context, '/accounts');
          EssentialWidgetsCollection.showSuccessSnackbar(
              context, jsonResponse.message!);
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
  }

}
