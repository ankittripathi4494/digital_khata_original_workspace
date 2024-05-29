// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PageErrorScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  PageErrorScreen({super.key, required this.argus});

  @override
  State<PageErrorScreen> createState() => _PageErrorScreenState();
}

class _PageErrorScreenState extends State<PageErrorScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          
          children: [
            SizedBox(
              height: screenSize.height * 0.2,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 252, 228, 230),
                ),
                padding: const EdgeInsets.all(50.0),
                child: const Icon(
                  Icons.wifi_off_outlined,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            const Text(
              'Page Not Found',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            
          ],
        ),
      ),
    );
  }
}
