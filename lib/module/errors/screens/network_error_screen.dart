// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class NetworkErrorScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  NetworkErrorScreen({super.key, required this.argus});

  @override
  State<NetworkErrorScreen> createState() => _NetworkErrorScreenState();
}

class _NetworkErrorScreenState extends State<NetworkErrorScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
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
              'No Internet Connection',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            const Text(
              'Please check your internet connection and ',
              style: TextStyle(
                color: Colors.black,
                // fontSize: 25,
              ),
            ),
            const Text(
              'try again.',
              style: TextStyle(
                color: Colors.black,
                // fontSize: 25,
              ),
            ),
            Container(
              width: screenSize.width,
              margin: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.15,
                  vertical: screenSize.height * 0.1),
              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
              decoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(30.0)),
              child: const Center(
                child: Text(
                  'Retry',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
