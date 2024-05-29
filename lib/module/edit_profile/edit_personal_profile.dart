// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
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
              Stack(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30.0),
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(
                            color: const Color.fromARGB(255, 31, 1, 102),
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
                              color: const Color.fromARGB(255, 31, 1, 102),
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
              ),
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
                      // controller: businessNameController,
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
                        hintText: ' Kiran',
                        hintStyle: const TextStyle(color: Colors.grey),
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
                      // controller: businessNameController,
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
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,

                      decoration: InputDecoration(
                        hintText: '+919686567845',
                        hintStyle: const TextStyle(color: Colors.grey),
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
                    TextFormField(
                      // key: _formKey,
                      // controller: businessNameController,
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
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,

                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 5.0),
                        hintText: 'India (IN)',
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'resources/images/flag-removebg-preview.png',
                            height: screenSize.height * 0.04,
                            width: screenSize.width * 0.06,
                          ),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_drop_down,
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
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Eg.sample@domain.com',
                        hintStyle: const TextStyle(color: Colors.grey),
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
                      onTap: () async {},
                      child: TextFormField(
                        enableInteractiveSelection: false,
                        enabled: false,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.calendar_month)),
                          hintText: '12-07-1998',
                          hintStyle: const TextStyle(color: Colors.black),
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
                        Navigator.pushNamed(context, '/accounts');
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
}
