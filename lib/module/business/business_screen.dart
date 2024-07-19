// ignore_for_file: must_be_immutable, avoid_print

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dkapp/global_blocs/internet/internet_cubit.dart';
import 'package:dkapp/global_blocs/internet/internet_state.dart';
import 'package:dkapp/global_widget/animated_loading_placeholder_widget.dart';
import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/bottom_nav_bar.dart';
import 'package:dkapp/module/business/business_bloc/business_bloc.dart';
import 'package:dkapp/module/business/business_bloc/business_event.dart';
import 'package:dkapp/module/business/business_bloc/business_state.dart';
import 'package:dkapp/utils/image_list.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:talker/talker.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  BusinessScreen({super.key, required this.argus});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  // int currentIndex = 0;
  late int currentPageIndexValue = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Container(),
          leadingWidth: 0,
          title: const Text(
            'My Business',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  'My Khatas',
                  style: TextStyle(fontSize: 21, color: Colors.white),
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 25,
                )),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: BlocBuilder<BusinessBloc, BusinessState>(
            bloc: BusinessBloc()
              ..add(
                  FetchSelectedBusinessEvent(userId: sph.getString("userid")!)),
            builder: (context, state) {
              if (state is FetchSelectedBusinessSuccessState) {
                return Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 0.0),
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -4),
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/update-business-profile',
                                arguments: {
                                  "businessProfileData":
                                      state.selectedBusinessData
                                });
                          },
                          leading: (state.selectedBusinessData!.profile == null)
                              ? Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        "resources/images/house-icon-removebg-preview.png",
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -1,
                                      right: -1.5,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 12,
                                        child: Center(
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                size: 8,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      "${NetworkImagePathList.imagePath}${state.selectedBusinessData!.profile!}",
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 45,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(80),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: imageProvider)),
                                    ),
                                  ),
                                  placeholder: (context, url) => CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    radius: 45,
                                    child:
                                        const AnimatedImagePlaceholderLoader(),
                                  ),
                                  errorWidget: (context, url, error) => Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color: Colors.blue[100],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          "resources/images/house-icon-removebg-preview.png",
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -1,
                                        right: -1.5,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          radius: 12,
                                          child: Center(
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.camera_alt,
                                                  size: 8,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          title: Row(
                            children: [
                              Text(
                                state.selectedBusinessData!.bName ?? '',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          subtitle: ((state.selectedBusinessData!.mobile !=
                                      '') &&
                                  (state.selectedBusinessData!.email != ''))
                              ? Text(
                                  '${state.selectedBusinessData!.mobile ?? ''}\n${state.selectedBusinessData!.email ?? ''}',
                                  style: const TextStyle(color: Colors.grey),
                                )
                              : (((state.selectedBusinessData!.mobile != '') &&
                                      (state.selectedBusinessData!.email == ''))
                                  ? Text(
                                      state.selectedBusinessData!.mobile!,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    )
                                  : (((state.selectedBusinessData!.mobile ==
                                              '') &&
                                          (state.selectedBusinessData!.email !=
                                              ''))
                                      ? Text(
                                          state.selectedBusinessData!.email!,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        )
                                      : Container())),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/update-business-profile',
                                  arguments: {
                                    "businessProfileData":
                                        state.selectedBusinessData
                                  });
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var callUrl = "http://vardanindia.in/";

                            var url = Uri.parse(callUrl);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Container(
                            // color: Colors.white, surfaceTintColor: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.02,
                                horizontal: screenSize.width * 0.03),
                            padding: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.02,
                                horizontal: screenSize.width * 0.1),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 203, 202, 202),
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: const Text(
                              'Digital Khata is introducing new changes to its subscription. Tap to learn more',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          // color: Colors.white, surfaceTintColor: Colors.white,
                          margin: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.003,
                              horizontal: screenSize.width * 0.045),
                          padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.02,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 203, 202, 202),
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.05),
                                child: const Text(
                                  'Premium',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.lock,
                                  size: 15,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Flexible(
                                      child: Text(
                                        'Unlock Premium Features',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 31, 1, 102),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 106, 0)),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/subscription');
                                        },
                                        child: const Text(
                                          'Buy Premium',
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.05,
                                    vertical: screenSize.height * 0.006),
                                child: const Text(
                                  'You can add upto 10 customers in your curent plan ',
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/sms-credit');
                          },
                          child: Container(
                            // color: Colors.white, surfaceTintColor: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.02,
                                horizontal: screenSize.width * 0.045),
                            padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 203, 202, 202),
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.05),
                                  child: const Text(
                                    'SMS Credits',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                        child: Text(
                                          'Tap up your whatsapp status',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 106, 0)),
                                          onPressed: () {},
                                          child: const Text(
                                            'Buy (50 Left)',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/whatsapp-credit');
                          },
                          child: Container(
                            // color: Colors.white, surfaceTintColor: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.004,
                                horizontal: screenSize.width * 0.045),
                            padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 203, 202, 202),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.05),
                                  child: const Text(
                                    'WhatsApp Credits',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 31, 1, 102),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                        child: Text(
                                          'Tap up your whatsapp status',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 106, 0)),
                                          onPressed: () {},
                                          child: const Text(
                                            'Buy (0 Left)',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/my-purchase');
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.045,
                                vertical: screenSize.height * 0.02),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 203, 202, 202),
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10.0)),
                            child: const ListTile(
                              title: Text(
                                'My Purchases',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/help-and-support');
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.045,
                                vertical: screenSize.height * 0.005),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 203, 202, 202),
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10.0)),
                            child: const ListTile(
                              leading: Icon(
                                Icons.help_sharp,
                                size: 30,
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                              title: Text(
                                'Help and Support',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        /*
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.045,
                              vertical: screenSize.height * 0.02),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.04),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 203, 202, 202),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.03,
                                    vertical: screenSize.height * 0.01),
                                child: const Text(
                                  'PAYMENTS',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/my-payments');
                                },
                                child: ListTile(
                                  minLeadingWidth: screenSize.width * 0.1,
                                  horizontalTitleGap: 0.0,
                                  leading: const Icon(
                                    Icons.email,
                                    size: 25,
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  title: const Text(
                                    'My Payments',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const Divider(),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/payment-configuration',
                                      arguments: {
                                        "isDeleted": '',
                                        "isNetbanking": '',
                                      });
                                },
                                child: ListTile(
                                  minLeadingWidth: screenSize.width * 0.1,
                                  horizontalTitleGap: 0.0,
                                  leading: const Icon(
                                    Icons.email,
                                    size: 25,
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  title: const Text(
                                    'Payment Configuration',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                       */
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.045,
                              vertical: screenSize.height * 0.006),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.04),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 203, 202, 202),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.03,
                                    vertical: screenSize.height * 0.01),
                                child: const Text(
                                  'REMINDERS',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/remainder');
                                },
                                child: ListTile(
                                  minLeadingWidth: screenSize.width * 0.1,
                                  horizontalTitleGap: 0.0,
                                  leading: const Icon(
                                    Icons.list_alt_outlined,
                                    size: 25,
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  title: const Text(
                                    'Reminder Sent (History)',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const Divider(),
                              ListTile(
                                minLeadingWidth: screenSize.width * 0.1,
                                horizontalTitleGap: 0.0,
                                leading: const Icon(
                                  Icons.settings,
                                  size: 25,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                title: const Text(
                                  'Reminder Settings',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              const Divider(),
                              ListTile(
                                minLeadingWidth: screenSize.width * 0.1,
                                horizontalTitleGap: 0.0,
                                leading: const Icon(
                                  Icons.message,
                                  size: 25,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                title: const Text(
                                  'Send SMS Reminders',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: const Text(
                                  'SMS are now enabled for your business.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                ),
                                trailing: SwitcherButton(
                                  size: screenSize.width * 0.09,
                                  onColor:
                                      const Color.fromARGB(255, 31, 1, 102),
                                  offColor:
                                      const Color.fromARGB(255, 203, 203, 203),
                                  value: true,
                                  onChange: (value) {
                                    if (kDebugMode) {
                                      Talker().info(value);
                                    }
                                  },
                                ),
                              ),
                              const Divider(),
                              ListTile(
                                  minLeadingWidth: screenSize.width * 0.1,
                                  horizontalTitleGap: 0.0,
                                  leading: const Icon(
                                    Icons.mark_email_unread_outlined,
                                    size: 25,
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  title: const Text(
                                    'SMS Reminder Templates',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: const Text(
                                    'Connect with our support team for SMS customization and more details..',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                  trailing: const Text(
                                    'English',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  )),
                              const Divider(),
                              ListTile(
                                minLeadingWidth: screenSize.width * 0.1,
                                horizontalTitleGap: 0.0,
                                leading: const Icon(
                                  CupertinoIcons.phone_circle_fill,
                                  size: 25,
                                  color: Colors.green,
                                ),
                                title: const Text(
                                  'Whatsapp Reminders',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: const Text(
                                  'SMS are now enabled for your business.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                ),
                                trailing: SwitcherButton(
                                  size: screenSize.width * 0.09,
                                  onColor:
                                      const Color.fromARGB(255, 31, 1, 102),
                                  offColor:
                                      const Color.fromARGB(255, 203, 203, 203),
                                  value: true,
                                  onChange: (value) {
                                    if (kDebugMode) {
                                      Talker().info(value);
                                    }
                                  },
                                ),
                              ),
                              const Divider(),
                              ListTile(
                                  minLeadingWidth: screenSize.width * 0.1,
                                  horizontalTitleGap: 0.0,
                                  leading: const Icon(
                                    CupertinoIcons.square_list_fill,
                                    size: 25,
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  title: const Text(
                                    'Whatsapp Templates',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // subtitle: const Text(
                                  //   'SMS are now enabled for your business.',
                                  //   style: TextStyle(color: Colors.black, fontSize: 13),
                                  // ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20,
                                    color: Colors.black,
                                  )),
                              const Divider(),
                              /*
                              ListTile(
                                minLeadingWidth: screenSize.width * 0.1,
                                horizontalTitleGap: 0.0,
                                leading: const Icon(
                                  CupertinoIcons.mail,
                                  size: 25,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                title: const Text(
                                  'Email Reminders',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: const Text(
                                  'Email reminders are now disabled for your business.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                ),
                                trailing: SwitcherButton(
                                  size: screenSize.width * 0.09,
                                  onColor:
                                      const Color.fromARGB(255, 31, 1, 102),
                                  offColor: const Color.fromARGB(
                                      255, 203, 203, 203),
                                  value: true,
                                  onChange: (value) {
                                    if (kDebugMode) {
                                      Talker().info(value);
                                    }
                                  },
                                ),
                              ),
                              const Divider(),
                              */
                              ListTile(
                                  minLeadingWidth: screenSize.width * 0.1,
                                  horizontalTitleGap: 0.0,
                                  leading: const Icon(
                                    CupertinoIcons.calendar,
                                    size: 25,
                                    color: Color.fromARGB(255, 31, 1, 102),
                                  ),
                                  title: const Text(
                                    'Overdue Reminders',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: const Text(
                                    'Next reminder on: 19-05-2024 09:00 AM',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11),
                                  ),
                                  trailing: const Text(
                                    'Weekly, Sunday',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.045,
                              vertical: screenSize.height * 0.02),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.04),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 203, 202, 202),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.03,
                                    vertical: screenSize.height * 0.01),
                                child: const Text(
                                  'Team Management',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                              ListTile(
                                minLeadingWidth: screenSize.width * 0.1,
                                horizontalTitleGap: 0.0,
                                leading: const Icon(
                                  Icons.person_add,
                                  size: 25,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                title: const Text(
                                  'Add or Edit Users',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              const Divider(),
                              ListTile(
                                minLeadingWidth: screenSize.width * 0.1,
                                horizontalTitleGap: 0.0,
                                leading: const Icon(
                                  Icons.settings,
                                  size: 25,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                title: const Text(
                                  'Manage User Permissions',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              const Divider(),
                              ListTile(
                                minLeadingWidth: screenSize.width * 0.1,
                                horizontalTitleGap: 0.0,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/manage-user-group',
                                      arguments: {
                                        "businessData":
                                            state.selectedBusinessData
                                      });
                                },
                                leading: const Icon(
                                  CupertinoIcons.person_3_fill,
                                  size: 25,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                title: const Text(
                                  'Manage User Groups',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              const Divider(),
                              ListTile(
                                minLeadingWidth: screenSize.width * 0.1,
                                horizontalTitleGap: 0.0,
                                leading: const Icon(
                                  CupertinoIcons.square_list_fill,
                                  size: 25,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                title: const Text(
                                  'My Team Activity',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.045,
                              vertical: screenSize.height * 0.007),
                          // padding:
                          //     EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 203, 202, 202),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/other-features',
                              );
                            },
                            minLeadingWidth: screenSize.width * 0.1,
                            horizontalTitleGap: 0.0,
                            leading: const Icon(
                              Icons.new_releases,
                              size: 25,
                              color: Color.fromARGB(255, 31, 1, 102),
                            ),
                            title: const Text(
                              'More features',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.045,
                              vertical: screenSize.height * 0.02),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.04),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 203, 202, 202),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.03,
                                    vertical: screenSize.height * 0.01),
                                child: const Text(
                                  'Reports',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                              ListTile(
                                minLeadingWidth: screenSize.width * 0.1,
                                horizontalTitleGap: 0.0,
                                leading: const Icon(
                                  Icons.list_alt_outlined,
                                  size: 25,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                title: const Text(
                                  'All Transactions Report',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              const Divider(),
                              ListTile(
                                minLeadingWidth: screenSize.width * 0.1,
                                horizontalTitleGap: 0.0,
                                leading: const Icon(
                                  Icons.list_alt_outlined,
                                  size: 25,
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                title: const Text(
                                  'Cash Projection Report',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is FetchSelectedBusinessLoadingState) {
                return const Center(
                  child: AnimatedImageLoader(),
                );
              }
              return Container();
            },
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget.bottomNavBar(
            screenSize, context, currentPageIndexValue, (index) {
          print("Current Index :- $index");
          setState(() {
            currentPageIndexValue = index;
          });
          if (currentPageIndexValue == 0) {
            Navigator.pushNamed(
              context,
              '/dashboard',
            );
          }
          // else if (currentPageIndexValue == 1) {
          //   Navigator.pushNamed(
          //     context,
          //     '/invoice',
          //   );
          // }
          else if (currentPageIndexValue == 1) {
            Navigator.pushNamed(
              context,
              '/business',
            );
          } else if (currentPageIndexValue == 2) {
            Navigator.pushNamed(
              context,
              '/accounts',
            );
          }
        }),
      ),
    );
  }
}
