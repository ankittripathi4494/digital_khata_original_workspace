// ignore_for_file: must_be_immutable

import 'package:dkapp/global_widget/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  BusinessScreen({super.key, required this.argus});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  // int currentIndex = 0;
  late int currentPageIndexValue = 2;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                ))
          ],
        ),
        body: Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: BoxDecoration(color: Colors.grey[100]),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/update-business-profile');
                      },
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        width: screenSize.width,
                        child: ListTile(
                          minLeadingWidth: 10.0,
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue[100],
                            child: Image.asset(
                              "resources/images/house-icon-removebg-preview.png",
                              height: screenSize.height * 0.09,
                              width: screenSize.width * 0.09,
                            ),
                          ),
                          horizontalTitleGap: screenSize.width * 0.07,
                          title: const Row(
                            children: [
                              Text(
                                'Priyanka',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          subtitle: const Text(
                            '+919856784567\nabc@gmail.com',
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenSize.width * 0.14,
                      top: screenSize.height * 0.044,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 12,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera_alt,
                              size: 10,
                              color: Colors.white,
                            )),
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () async {
                    var callUrl = "https://financepe.in/";

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
                    child: const Column(
                      children: [
                        Text(
                          'Digital Khata is introducing new changes to its ',
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'subscription. Tap to learn more',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/subscription');
                  },
                  child: Container(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.lock,
                              size: 15,
                              color: Color.fromARGB(255, 31, 1, 102),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Unlock Premium Features',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.06,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 106, 0)),
                                onPressed: () {},
                                child: const Text(
                                  'Buy Premium',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Tap up your whatsapp status',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.06,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 106, 0)),
                                onPressed: () {},
                                child: const Text(
                                  'Buy (50 Left)',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Tap up your whatsapp status',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 31, 1, 102),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.06,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 106, 0)),
                                onPressed: () {},
                                child: const Text(
                                  'Buy (0 Left)',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
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
                            color: Colors.black, fontWeight: FontWeight.w500),
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
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.045,
                      vertical: screenSize.height * 0.02),
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
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
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/my-payments');
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
                          Navigator.pushNamed(context, '/payment-configuration',
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
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.045,
                      vertical: screenSize.height * 0.006),
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
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
                          style: TextStyle(color: Colors.grey, fontSize: 15),
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
                              color: Colors.black, fontWeight: FontWeight.w500),
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
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text(
                          'SMS are now enabled for your business.',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        trailing: SwitcherButton(
                          size: screenSize.width * 0.09,
                          onColor: const Color.fromARGB(255, 31, 1, 102),
                          offColor: const Color.fromARGB(255, 203, 203, 203),
                          value: true,
                          onChange: (value) {
                            if (kDebugMode) {
                              print(value);
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
                            style: TextStyle(color: Colors.black, fontSize: 13),
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
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text(
                          'SMS are now enabled for your business.',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        trailing: SwitcherButton(
                          size: screenSize.width * 0.09,
                          onColor: const Color.fromARGB(255, 31, 1, 102),
                          offColor: const Color.fromARGB(255, 203, 203, 203),
                          value: true,
                          onChange: (value) {
                            if (kDebugMode) {
                              print(value);
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
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text(
                          'Email reminders are now disabled for your business.',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        trailing: SwitcherButton(
                          size: screenSize.width * 0.09,
                          onColor: const Color.fromARGB(255, 31, 1, 102),
                          offColor: const Color.fromARGB(255, 203, 203, 203),
                          value: true,
                          onChange: (value) {
                            if (kDebugMode) {
                              print(value);
                            }
                          },
                        ),
                      ),
                      const Divider(),
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
                            style: TextStyle(color: Colors.black, fontSize: 11),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
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
                          style: TextStyle(color: Colors.grey, fontSize: 15),
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
                              color: Colors.black, fontWeight: FontWeight.w500),
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
                              color: Colors.black, fontWeight: FontWeight.w500),
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
                          CupertinoIcons.person_3_fill,
                          size: 25,
                          color: Color.fromARGB(255, 31, 1, 102),
                        ),
                        title: const Text(
                          'Manage User Groups',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
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
                              color: Colors.black, fontWeight: FontWeight.w500),
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
                          color: Colors.black, fontWeight: FontWeight.w500),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
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
                          style: TextStyle(color: Colors.grey, fontSize: 15),
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
                              color: Colors.black, fontWeight: FontWeight.w500),
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
                              color: Colors.black, fontWeight: FontWeight.w500),
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
        ),
        bottomNavigationBar: BottomNavBarWidget.bottomNavBar(
            screenSize, context, currentPageIndexValue, (index) {
          setState(() {
            currentPageIndexValue = index;
          });
          if (currentPageIndexValue == 0) {
            Navigator.pushNamed(context, '/dashboard');
          } else if (currentPageIndexValue == 1) {
            Navigator.pushNamed(context, '/invoice');
          } else if (currentPageIndexValue == 2) {
            Navigator.pushNamed(context, '/business');
          } else if (currentPageIndexValue == 3) {
            Navigator.pushNamed(context, '/accounts');
          }
        }),
      ),
    );
  }
}
