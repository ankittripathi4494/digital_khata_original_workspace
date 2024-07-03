// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_bloc.dart';
import 'package:dkapp/module/customers/customer_bloc/customer_event.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileDetailScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ProfileDetailScreen({super.key, required this.argus});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  ScrollController? _scrollController;
  bool lastStatus = true;
  final ImagePicker _picker = ImagePicker();
  XFile? retailerImage;
  String? retailerImageFile;
  double height = 200;

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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: NestedScrollView(
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
                                              debugPrint(
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
                                              debugPrint(
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
                      const Text(
                        '\u{20B9} ${0}',
                        style: TextStyle(
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
        body: Column(
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
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.blue),
                        onPressed: () {},
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
                  visualDensity:
                      VisualDensity(horizontal: 0, vertical: -4),
                  title: Text("Add Label..",style: TextStyle(fontStyle: FontStyle.italic),),
                )),
          
          ],
        ),
      ),
    );
  }
}
