// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LockTypeScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  LockTypeScreen({super.key, required this.argus});

  @override
  State<LockTypeScreen> createState() => _LockTypeScreenState();
}

class _LockTypeScreenState extends State<LockTypeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Select Lock Type',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/app-lock/pin-lock');
            },
            child: Container(
              width: screenSize.width,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              decoration: const BoxDecoration(color: Colors.white),
              child: const Text(
                'Pin',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/app-lock/set-pattern');
            },
            child: Container(
              width: screenSize.width,
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              decoration: const BoxDecoration(color: Colors.white),
              child: const Text(
                'Pattern',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
