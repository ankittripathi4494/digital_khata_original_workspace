// ignore_for_file: must_be_immutable, unnecessary_null_comparison, avoid_Talker().info

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/utils/location_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:talker/talker.dart';

class AddBusinessAddressScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  AddBusinessAddressScreen({super.key, required this.argus});

  @override
  State<AddBusinessAddressScreen> createState() =>
      _AddBusinessAddressScreenState();
}

class _AddBusinessAddressScreenState extends State<AddBusinessAddressScreen> {
  Position? currentPostion;
  String currentAddress = '';
  bool showLocation = false;
  TextEditingController businessAddress1Controller = TextEditingController();
  TextEditingController businessAddress2Controller = TextEditingController();
  TextEditingController businessAddress3Controller = TextEditingController();
  TextEditingController businessCityController = TextEditingController();
  TextEditingController businessStateController = TextEditingController();
  TextEditingController businessPostalCodeController = TextEditingController();
  TextEditingController businessCountryController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  fetchLocation() async {
    if (widget.argus.containsKey('address')) {
      Talker().info(Map<String, dynamic>.from(widget.argus['address']).toString());
      setState(() {
        businessAddress1Controller.text =
            Map<String, dynamic>.from(widget.argus['address'])['address1'] ??=
                '';
        businessAddress2Controller.text =
            Map<String, dynamic>.from(widget.argus['address'])['address2'] ??=
                '';
        businessAddress3Controller.text =
            Map<String, dynamic>.from(widget.argus['address'])['address3'] ??=
                '';
        businessCityController.text =
            Map<String, dynamic>.from(widget.argus['address'])['city'] ??= '';
        businessStateController.text =
            Map<String, dynamic>.from(widget.argus['address'])['state'] ??= '';
        businessPostalCodeController.text =
            Map<String, dynamic>.from(widget.argus['address'])['country'] ??=
                '';
        businessCountryController.text =
            Map<String, dynamic>.from(widget.argus['address'])['postalcode'] ??=
                '';
        currentPostion = widget.argus['currentPostion'] as Position;

        showLocation = true;
      });
    } else {
      LocationHandler.getCurrentPosition().then(
        (value) {
          LocationHandler.getAddressFromLatLng(value!).then((vw) {
            setState(() {
              businessAddress1Controller.text = vw!;
            });
          });
          LocationHandler.getCityFromLatLng(value).then((vw) {
            setState(() {
              businessCityController.text = vw!;
            });
          });
          LocationHandler.getStateFromLatLng(value).then((vw) {
            setState(() {
              businessStateController.text = vw!;
            });
          });
          LocationHandler.getCountryFromLatLng(value).then((vw) {
            setState(() {
              businessCountryController.text = vw!;
            });
          });
          LocationHandler.getPostalCodeFromLatLng(value).then((vw) {
            setState(() {
              businessPostalCodeController.text = vw!;
            });
          });
          setState(() {
            currentPostion = value;
            showLocation = true;
          });
        },
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add Business Address',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: (showLocation == false)
          ? Container(
             decoration: BoxDecoration(color: Colors.grey[100]),
            child: const Center(
                child: AnimatedImageLoader(),
              ),
          )
          : Container(
             decoration: BoxDecoration(color: Colors.grey[100]),
            child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: screenSize.height * 0.3,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(currentPostion!.latitude,
                                  currentPostion!.longitude),
                              initialZoom: 17,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                subdomains: const ['a', 'b', 'c'],
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: LatLng(currentPostion!.latitude,
                                        currentPostion!.longitude),
                                    child: const Icon(
                                      Icons.location_pin,
                                      color: Colors.red,
                                      size: 40.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                style: IconButton.styleFrom(
                                    elevation: 20,
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  LocationHandler.getCurrentPosition().then(
                                    (value) {
                                      LocationHandler.getAddressFromLatLng(value!)
                                          .then((vw) {
                                        setState(() {
                                          businessAddress1Controller.text = vw!;
                                        });
                                      });
                                      LocationHandler.getCityFromLatLng(value)
                                          .then((vw) {
                                        setState(() {
                                          businessCityController.text = vw!;
                                        });
                                      });
                                      LocationHandler.getStateFromLatLng(value)
                                          .then((vw) {
                                        setState(() {
                                          businessStateController.text = vw!;
                                        });
                                      });
                                      LocationHandler.getCountryFromLatLng(value)
                                          .then((vw) {
                                        setState(() {
                                          businessCountryController.text = vw!;
                                        });
                                      });
                                      LocationHandler.getPostalCodeFromLatLng(
                                              value)
                                          .then((vw) {
                                        setState(() {
                                          businessPostalCodeController.text = vw!;
                                        });
                                      });
                                      setState(() {
                                        currentPostion = value;
                                      });
                                    },
                                  );
                                },
                                icon: const Icon(
                                    Icons.location_searching_outlined)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: businessAddress1Controller,
                                    textCapitalization: TextCapitalization.words,
                                    style: const TextStyle(color: Colors.black),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Business Address Line 1 can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.name,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelText: 'Address Line 1',
            
                                      labelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              18), // hintText: 'Eg.Abc Kirana',
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
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: businessAddress2Controller,
                                    textCapitalization: TextCapitalization.words,
                                    style: const TextStyle(color: Colors.black),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Business Address Line 2 can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.name,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelText: 'Address Line 2',
            
                                      labelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              18), // hintText: 'Eg.Abc Kirana',
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
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: businessAddress3Controller,
                                    textCapitalization: TextCapitalization.words,
                                    style: const TextStyle(color: Colors.black),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Business Address Line 3 can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.name,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelText: 'Address Line 3',
            
                                      labelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              18), // hintText: 'Eg.Abc Kirana',
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
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: businessCityController,
                                    textCapitalization: TextCapitalization.words,
                                    style: const TextStyle(color: Colors.black),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'City can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.name,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelText: 'City',
            
                                      labelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              18), // hintText: 'Eg.Abc Kirana',
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
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: businessStateController,
                                    textCapitalization: TextCapitalization.words,
                                    style: const TextStyle(color: Colors.black),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'State can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.name,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelText: 'State',
            
                                      labelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              18), // hintText: 'Eg.Abc Kirana',
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
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: businessPostalCodeController,
                                    textCapitalization: TextCapitalization.words,
                                    style: const TextStyle(color: Colors.black),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Postal Code can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.name,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelText: 'Postal Code',
            
                                      labelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              18), // hintText: 'Eg.Abc Kirana',
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
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: businessCountryController,
                                    textCapitalization: TextCapitalization.words,
                                    style: const TextStyle(color: Colors.black),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Country can\'t be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.name,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelText: 'Country',
            
                                      labelStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              18), // hintText: 'Eg.Abc Kirana',
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
                                ),
                                InkWell(
                                  onTap: () {
                                    Map<String, dynamic> completeAddress = {};
                                    Map<String, dynamic> sendableData = {};
                                    completeAddress['address1'] =
                                        businessAddress1Controller.text;
                                    completeAddress['address2'] =
                                        businessAddress2Controller.text;
                                    completeAddress['address3'] =
                                        businessAddress3Controller.text;
                                    completeAddress['city'] =
                                        businessCityController.text;
                                    completeAddress['state'] =
                                        businessStateController.text;
                                    completeAddress['country'] =
                                        businessCountryController.text;
                                    completeAddress['postalcode'] =
                                        businessPostalCodeController.text;
            
                                    sendableData = {
                                      'completeAddress': completeAddress,
                                      'currentPostion': currentPostion
                                    };
            
                                    Navigator.pop(context, sendableData);
                                  },
                                  child: Container(
                                    height: 50,
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Colors.green,
                                              Colors.green.shade400
                                            ])),
                                    child: const Center(
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: 1, // Replace this with your form items count
                    ),
                  ),
                ],
              ),
          ),
    );
  }
}
