// ignore_for_file: must_be_immutable
import 'package:dkapp/global_widget/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreeen extends StatefulWidget {
  late Map<String, dynamic> argus;
  AccountScreeen({super.key, required this.argus});

  @override
  State<AccountScreeen> createState() => _AccountScreeenState();
}

class _AccountScreeenState extends State<AccountScreeen> {
  // int currentIndex = 0;
  late int currentPageIndexValue = 3;
  Future<bool> showAboutPopup(context) async {
    // exit from app
    return await showDialog(
        // barrierColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white, surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.zero,
            icon: const CircleAvatar(
              radius: 50,
              backgroundColor: Color.fromARGB(255, 203, 229, 251),
              child:
                  Icon(Icons.edit_note_sharp, color: Colors.orange, size: 50),
            ),
            titlePadding: const EdgeInsets.only(
                right: 110.0, left: 110.0, top: 10.0), // Adjust width here
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            title: const Text(
              'Digital Khata',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            contentPadding: const EdgeInsets.only(
              bottom: 10.0,
              left: 160.0,
            ),
            content: const Text(
              'Version 1.67.0',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 50, left: 50),
                    child: Text(
                        'Easily Send Payment Due Reminders. Collect Online Payments & Track Dues At One Place.'),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/how-It-works');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 31, 1, 102),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: const Text(
                        'HOW IT WORKS?',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
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
                  ),
                ],
              )
            ],
          );
          // });
        });
  }

  Future<bool> showLogoutPopup(context) async {
    // exit from app
    return await showDialog(
        // barrierColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: const Text('Are you sure you want logout?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'YES',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            ),
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
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Container(),
          leadingWidth: 0.0,
          title: const Text(
            'My Account',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/edit-personal-profile');
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
                    decoration: const BoxDecoration(color: Colors.white),
                    width: screenSize.width,
                    child: ListTile(
                      minLeadingWidth: 10.0,
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue[100],
                          child: const Icon(
                            Icons.person,
                            size: 40,
                          )),
                      horizontalTitleGap: screenSize.width * 0.07,
                      title: const Text(
                        'Priyanka',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        '+919856784567',
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
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/reward-point');
                  },
                  child: Container(
                    width: screenSize.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 203, 202, 202),
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                        gradient: const LinearGradient(
                            colors: [
                              Colors.blue,
                              Color.fromARGB(255, 243, 241, 241),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Invite friends to get free SMS',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        const Text(
                          'Get upto 10,000 credits!',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: const Size(80, 5),
                              backgroundColor:
                                  const Color.fromARGB(255, 31, 1, 102),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Invite Now',
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ))
                      ],
                    ),
                  ),
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
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 203, 202, 202),
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      minLeadingWidth: screenSize.width * 0.1,
                      horizontalTitleGap: 0.0,
                      leading: const Icon(
                        Icons.new_releases,
                        size: 25,
                        color: Color.fromARGB(255, 31, 1, 102),
                      ),
                      title: const Text(
                        'Whats new in 1.67.0',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
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
                          'SETTINGS',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/app-lock');
                        },
                        child: ListTile(
                          minLeadingWidth: screenSize.width * 0.1,
                          horizontalTitleGap: 0.0,
                          leading: const Icon(
                            Icons.lock,
                            size: 23,
                            color: Colors.orange,
                          ),
                          title: const Text(
                            'App Security/Lock',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/choose-language');
                        },
                        child: ListTile(
                          minLeadingWidth: screenSize.width * 0.1,
                          horizontalTitleGap: 0.0,
                          leading: const Icon(
                            Icons.language,
                            size: 25,
                            color: Colors.blue,
                          ),
                          title: const Text(
                            'Choose Language',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/enable-notification');
                        },
                        child: ListTile(
                          minLeadingWidth: screenSize.width * 0.1,
                          horizontalTitleGap: 0.0,
                          leading: const Icon(
                            Icons.notifications_none,
                            size: 25,
                            color: Color.fromARGB(255, 31, 1, 102),
                          ),
                          title: const Text(
                            'Enable Notification',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey,
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
                      vertical: screenSize.height * 0.001),
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
                          'ABOUT',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showAboutPopup(context);
                        },
                        child: ListTile(
                          minLeadingWidth: screenSize.width * 0.1,
                          horizontalTitleGap: 0.0,
                          leading: const Icon(
                            CupertinoIcons.person_3_fill,
                            size: 27,
                            color: Colors.orange,
                          ),
                          title: const Text(
                            'Digital Khata',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          minLeadingWidth: screenSize.width * 0.1,
                          horizontalTitleGap: 0.0,
                          leading: const Icon(
                            Icons.star,
                            size: 30,
                            color: Color.fromARGB(255, 187, 237, 50),
                          ),
                          title: const Text(
                            'Rate Us',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey,
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
                      vertical: screenSize.height * 0.001),
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
                          'SUPPORT',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      ListTile(
                        minLeadingWidth: screenSize.width * 0.1,
                        horizontalTitleGap: 0.0,
                        leading: const Icon(
                          CupertinoIcons.chat_bubble_2_fill,
                          size: 27,
                          color: Colors.blue,
                        ),
                        title: const Text(
                          'Chat with helpdesk',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () async {
                          var callUrl = "tel:+91 7054344815";
      
                          var url = Uri.parse(callUrl);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: ListTile(
                          minLeadingWidth: screenSize.width * 0.1,
                          horizontalTitleGap: 0.0,
                          leading: const Icon(
                            CupertinoIcons.phone_fill,
                            size: 27,
                            color: Colors.red,
                          ),
                          title: const Text(
                            'Call helpdesk',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/privacy-policy');
                        },
                        child: ListTile(
                          minLeadingWidth: screenSize.width * 0.1,
                          horizontalTitleGap: 0.0,
                          leading: const Icon(
                            Icons.privacy_tip,
                            size: 27,
                            color: Colors.green,
                          ),
                          title: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/terms-and-condition');
                        },
                        child: ListTile(
                          minLeadingWidth: screenSize.width * 0.1,
                          horizontalTitleGap: 0.0,
                          leading: const Icon(
                            Icons.list_alt_sharp,
                            size: 27,
                            color: Colors.brown,
                          ),
                          title: const Text(
                            'Terms & Conditions',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30.0),
                  child: TextButton(
                      onPressed: () {
                        showLogoutPopup(context);
                      },
                      child: const Text(
                        'Log out',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      )),
                ),
                const Text(
                  'App Version - 1.6.7',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      bottomNavigationBar: BottomNavBarWidget.bottomNavBar(
              screenSize, context, currentPageIndexValue,(index) {
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
