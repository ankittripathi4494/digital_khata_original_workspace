// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NetBankingScreen extends StatefulWidget {
  late String? isNetbanking;
  NetBankingScreen({super.key, required this.isNetbanking});

  @override
  State<NetBankingScreen> createState() => _NetBankingScreenState();
}

class _NetBankingScreenState extends State<NetBankingScreen> {
  String isNetbanking = 'true';
  Future<bool> showDeletePopup(context) async {
    // exit from app
    return await showDialog(
        // barrierColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: const Text(
                'Are you sure want to delete this information?',
                style: TextStyle(fontSize: 17),
              ),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 31, 103),
                          fontWeight: FontWeight.w400),
                    )),
                TextButton(
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/payment-configuration',
                          arguments: {
                            "isNetbanking": '',
                            "isDeleted": 'true',
                          });
                    },
                    child: const Text(
                      'DELETE',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 31, 103),
                          fontWeight: FontWeight.w400),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
               Navigator.pushNamed(context, '/payment-configuration',
                          arguments: {
                            "isNetbanking": '',
                            "isDeleted": '',
                          });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 28,
            )),
        title: const Text(
          'Payment Providers',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        actions: [
          (widget.isNetbanking == 'true')
              ? IconButton(
                  onPressed: () {
                    showDeletePopup(context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 28,
                  ))
              : IconButton(
                  onPressed: () async {
                    var meekahataUrl = "https://www.meekhata.in/";

                    var url = Uri.parse(meekahataUrl);

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: const Icon(
                    Icons.help_outline_sharp,
                    color: Colors.white,
                  ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              const Text(
                'Account Name',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 31, 103),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                cursorColor: const Color.fromARGB(255, 0, 31, 103),
                style: const TextStyle(color: Color.fromARGB(255, 0, 31, 103)),
                decoration: InputDecoration(
                    hintText: 'Account Name',
                    hintStyle: const TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              const Text(
                'IFSC Code',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 31, 103),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                cursorColor: const Color.fromARGB(255, 0, 31, 103),
                style: const TextStyle(color: Color.fromARGB(255, 0, 31, 103)),
                decoration: InputDecoration(
                    hintText: 'IFSC Code',
                    hintStyle: const TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              const Text(
                'Account Number',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 31, 103),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                cursorColor: const Color.fromARGB(255, 0, 31, 103),
                style: const TextStyle(color: Color.fromARGB(255, 0, 31, 103)),
                decoration: InputDecoration(
                    hintText: 'Account Number',
                    hintStyle: const TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              const Text(
                'Branch',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 31, 103),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                cursorColor: const Color.fromARGB(255, 0, 31, 103),
                style: const TextStyle(color: Color.fromARGB(255, 0, 31, 103)),
                decoration: InputDecoration(
                    hintText: 'Branch',
                    hintStyle: const TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 31, 103)),
                        borderRadius: BorderRadius.circular(10.0))),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/payment-configuration',
                          arguments: {
                            "isNetbanking": 'true',
                            "isDeleted": '',
                          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.06,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.4,
              vertical: screenSize.height * 0.02),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 31, 1, 102),
              borderRadius: BorderRadius.circular(10.0)),
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
