// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  HelpSupportScreen({super.key, required this.argus});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/business');
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            'Help and Support',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
        body: InkWell(
          onTap: () async {
            var whatsappUrl = "https://www.digitalkhata.in/";

            var url = Uri.parse(whatsappUrl);

            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
            margin: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.02,
                horizontal: screenSize.width * 0.04),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 203, 202, 202),
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: const ListTile(
              title: Text(
                'Digital Khata Basics',
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 23,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
