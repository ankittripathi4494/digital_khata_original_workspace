// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class HowItWorksScreen extends StatefulWidget {
    late Map<String, dynamic> argus;
  HowItWorksScreen({super.key, required this.argus});

  @override
  State<HowItWorksScreen> createState() => _HowItWorksScreenState();
}

class _HowItWorksScreenState extends State<HowItWorksScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
                color: Colors.white,
              )),
          title: const Text(
            'How It Works?',
            style: TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
