// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPurchasesScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  MyPurchasesScreen({super.key, required this.argus});

  @override
  State<MyPurchasesScreen> createState() => _MyPurchasesScreenState();
}

class _MyPurchasesScreenState extends State<MyPurchasesScreen> {
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
            'My Purchases',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenSize.height * 0.2,
            ),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 230, 223, 246),
                child: Icon(
                  CupertinoIcons.search_circle_fill,
                  size: 60,
                  color: Colors.brown,
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.06,
            ),
            const Text(
              'No Data',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: screenSize.height * 0.06,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/subscription');
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.08,
                    vertical: screenSize.height * 0.015),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 31, 1, 102),
                    borderRadius: BorderRadius.circular(30.0)),
                child: const Text(
                  'View plans',
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
