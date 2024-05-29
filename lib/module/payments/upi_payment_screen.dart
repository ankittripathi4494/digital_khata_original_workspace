// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpiPaymentScreen extends StatefulWidget {
    late Map<String, dynamic> argus;
  UpiPaymentScreen({super.key, required this.argus});

  @override
  State<UpiPaymentScreen> createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            'Payment Providers',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  var meekahataUrl = "https://www.digitalkhata.in/";

                  var url = Uri.parse(meekahataUrl);

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                icon: const Icon(
                  Icons.help_outline_sharp,
                  color: Colors.blue,
                ))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
              child: const Text(
                'Enter UPI',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.height * 0.01),
              child: TextFormField(
                cursorColor: const Color.fromARGB(255, 31, 1, 102),
                style: const TextStyle(
                  color: Color.fromARGB(255, 31, 1, 102),
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 31, 1, 102),
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 31, 1, 102),
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 31, 1, 102),
                        ))),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.6,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
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
            )
          ],
        ),
      ),
    );
  }
}
