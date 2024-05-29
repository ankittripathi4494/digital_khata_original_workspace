// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_launcher/map_launcher.dart';

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
  String? signatureImageFile;
  final ImagePicker _picker = ImagePicker();
  XFile? retailerImage;
  String? retailerImageFile;
  Future<bool> showGroupsPopup(context) async {
    // exit from app
    return await showDialog(
        // barrierColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.only(
                right: 150.0, left: 40.0, top: 10.0), // Adjust width here
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            title: const Text('Select Business'),
            content: ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              minLeadingWidth: 0.0,
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: const Color.fromARGB(255, 246, 242, 201),
                child: Image.asset(
                  'resources/images/house-icon-removebg-preview.png',
                  height: 30,
                  width: 30,
                ),
                // Icon(
                //   Icons.home,
                //   color: Colors.red[300],
                // ),
              ),
              title: const Text(
                'Priyanka',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                '+919867543243\nabc42@gmail.com',
                style: TextStyle(fontSize: 15),
              ),
              // trailing: Icon(
              //   Icons.check_circle,
              //   size: 20,
              //   color: Colors.green,
              // ),
            ),
            actions: [
              const Divider(),
              InkWell(
                onTap: () {
                   Navigator.pushNamed(
                            context,
                            '/update-business-profile');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Image.asset(
                    //   'resources/images/house-icon-removebg-preview.png',
                    //   height: 50,
                    //   width: 50,
                    // ),
                    Icon(
                      Icons.person_add,
                      color: Colors.green,
                    ),
                    Text(
                      'Add New Business',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
                // icon: Icon(
                //   Icons.person_add,
                //   color: Colors.green,
                // ),
                // label: Text(
                //   'Add New Business',
                //   style: TextStyle(color: Colors.black, fontSize: 15),
                // ),
                // onPressed: () {
                //   Navigator.pop(context);
                // },
              )
            ],
          );
          // });
        });
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

  Future<bool> showDeletePopup(context) async {
    // exit from app
    return await showDialog(
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
                  onPressed: () {},
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.black),
                  )),
              TextButton(
                  onPressed: () {},
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/business');
            },
          ),
          title: const Text(
            'Update Business Profile',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDeletePopup(context);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Stack(
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
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: '+919867544367',
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
                      onTap: () async {},
                      child: TextFormField(
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
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'resources/images/flag-removebg-preview.png',
                              height: screenSize.height * 0.001,
                              width: screenSize.width * 0.001,
                            ),
                          ),
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromARGB(255, 31, 1, 102),
                          ),
                          hintText: 'India (IN)',
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
                      onTap: () {
                        Navigator.pushNamed(
                            context,
                            '/business-type');
                      },
                      child: TextFormField(
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
                      onTap: () async {
                        try {
                          final coords = Coords(37.759392, -122.5107336);
                          const title = "Ocean Beach";
                          final availableMaps = await MapLauncher.installedMaps;
                          for (var map in availableMaps) {
                            map.showMarker(coords: coords, title: title);
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        }
                      },
                      child: TextFormField(
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
                        hintText: 'sample@gmail.com',
                        hintStyle: const TextStyle(color: Colors.black),
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
                      enableInteractiveSelection: true,
                      enabled: true,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Eg.www.sample.com',
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
      ),
    );
  }
}
