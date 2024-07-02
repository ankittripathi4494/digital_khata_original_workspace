// ignore_for_file: must_be_immutable

import 'package:appbar_animated/appbar_animated.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class RewardScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  RewardScreen({super.key, required this.argus});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final key = GlobalKey<ScaffoldState>();
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: key,
        body: ScaffoldLayoutBuilder(
          backgroundColorAppBar:
              const ColorBuilder(Colors.transparent, Colors.blue),
          textColorAppBar: const ColorBuilder(Colors.white),
          appBarBuilder: _appBar,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  // width: screenSize.width,
                  // height: screenSize.height,

                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width,
                      vertical: screenSize.height * 0.2),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 19, 140, 240),
                    Color.fromARGB(255, 243, 241, 241),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  // child: Positioned(
                  //   top: 20.0,
                  //   left: 40.0,
                  // child: Text(
                  //   'SMS Credits Rewarded',
                  //   style: TextStyle(color: Colors.black),
                  // ),
                  // ),
                ),
                Positioned(
                  top: 120.0,
                  left: 40.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'SMS Credits Rewarded',
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 1, 102),
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: screenSize.width * 0.35,
                            top: screenSize.height * 0.01),
                        child: const Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 31, 1, 102),
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),

                // Image.network(
                //   "https://www.gotravelly.com/blog/wp-content/uploads/2019/10/Gunung-Fuji-Jepang.jpg",
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height * 0.4,
                //   fit: BoxFit.cover,
                // ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                  ),
                  // padding:
                  //     EdgeInsets.symmetric(vertical: screenSize.height * 0.0),
                  height: screenSize.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(0),
                    ),
                    color: Colors.white,
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        ButtonsTabBar(
                          labelSpacing: 8.0,
                          // buttonMargin: const EdgeInsets.symmetric(
                          //     horizontal: 0.0, vertical: 5.0),
                          radius: 0,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 65, vertical: 10.0),
                          // Customize the appearance and behavior of the tab bar
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 31, 1, 102),
                              borderRadius: BorderRadius.zero),

                          // borderWidth: 2,
                          // borderColor: Colors.black,
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          // Add your tabs here
                          tabs: const [
                            Tab(
                              text: 'Refer & Earn',
                            ),
                            Tab(
                              text: 'Rewards',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              //tab 1: Refer & earn
                              Container(
                                color: Colors.grey[100],
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: screenSize.height * 0.1),
                                    const Icon(
                                      CupertinoIcons.conversation_bubble,
                                      size: 50,
                                      color: Color.fromARGB(255, 31, 1, 102),
                                    ),
                                    SizedBox(height: screenSize.height * 0.05),
                                    const ListTile(
                                      title: Padding(
                                        padding: EdgeInsets.all(11.0),
                                        child: Text(
                                          'Invite and earn upto 10,000 SMS Credit',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 31, 1, 102),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 10.0),
                                        child: Text(
                                          'Invite your freinds to Digital Khata!, If they join you  will get 100 SMS credits and they will get 100 SMS credits.extra! ',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),

                                      // const Text(
                                      //   'Invite and earn upto 10,000 SMS Credit',
                                      //   style: TextStyle(
                                      //       color: Color.fromARGB(255, 31, 1, 102),
                                      //       fontSize: 20,
                                      //       fontWeight: FontWeight.w500),
                                      // ),
                                      // SizedBox(
                                      //   height: screenSize.height * 0.01,
                                      // ),
                                      // const Text(
                                      //   'Invite your freinds to Digital Khata!, If they join\n you will get 100 SMS credits and they will get 100\n SMS credits.extra! ',
                                      //   style: TextStyle(
                                      //     color: Color.fromARGB(255, 31, 1, 102),
                                      //     fontSize: 12,
                                      //   ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: screenSize.height * 0.1),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * 0.07,
                                          vertical: screenSize.height * 0.02),
                                      decoration: BoxDecoration(
                                          color: Colors.blue[50],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 31, 1, 102),
                                          )),
                                      child: GestureDetector(
                                        onLongPress: () {
                                          Clipboard.setData(const ClipboardData(
                                                  text: '0B4ZF67'))
                                              .then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        ' Copied to clipboard !')));
                                          });
                                        },
                                        child: const Text(
                                          '0B4ZF67',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //tab 2: Today
                              Container(
                                color: Colors.grey[100],
                                // height: 200,
                                // width: 100,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: screenSize.height * 0.1,
                                    ),
                                    const CircleAvatar(
                                      radius: 50,
                                      backgroundColor:
                                          Color.fromARGB(255, 230, 223, 246),
                                      child: Icon(
                                        CupertinoIcons.search_circle_fill,
                                        size: 60,
                                        color: Colors.brown,
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.1,
                                    ),
                                    const Text(
                                      'No Referral Rewards',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 1, 102),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // SizedBox(
                                    //   height: screenSize.height * 0.001,
                                    // ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                        'You have not invited anyone yet',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 1, 102),
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.1,
                              vertical: screenSize.height * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton.icon(
                                  style: TextButton.styleFrom(
                                      side:
                                          const BorderSide(color: Colors.green),
                                      minimumSize: const Size(160, 45)),
                                  onPressed: () async {
                                    var whatsappUrl =
                                        "https://wa.me/?text=YourTextHere";
                                    var url = Uri.parse(whatsappUrl);

                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.arrow_branch,
                                    color: Colors.green,
                                  ),
                                  label: const Text(
                                    'Share',
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 16),
                                  )),
                              TextButton.icon(
                                  style: TextButton.styleFrom(
                                      minimumSize: const Size(160, 45),
                                      backgroundColor: Colors.green),
                                  onPressed: () async {
                                    var callUrl = "tel:+91 7054344815";

                                    var url = Uri.parse(callUrl);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.person_2_square_stack_fill,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Invite Contacts',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // appBar:
        // AppBar(
        //   backgroundColor: Colors.blue,
        //   leading: IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.arrow_back,
        //         color: Colors.white,
        //         size: 25,
        //       )),
        //   leadingWidth: screenSize.width * 0.1,
        //   title: const Text(
        //     'Rewards',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
      ),
    );
  }

  Widget _appBar(BuildContext context, colorAnimated) {
    return AppBar(
      backgroundColor: colorAnimated.background,
      elevation: 0,
      title: Text(
        "Rewards",
        style: TextStyle(
          color: colorAnimated.color,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/accounts');
        },
        icon: Icon(
          Icons.arrow_back,
          color: colorAnimated.color,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            var whatsappUrl =
                "https://whatsapp://send?phone=+917054344815&text=${Uri.encodeComponent("Hi")}";

            var url = Uri.parse(whatsappUrl);

            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          icon: Icon(
            Icons.live_help_outlined,
            color: colorAnimated.color,
            size: 25,
          ),
        ),
      ],
    );
  }
}
