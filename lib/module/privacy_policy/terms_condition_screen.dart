// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TermsConditionScreen extends StatefulWidget {
    late Map<String, dynamic> argus;
  TermsConditionScreen({super.key, required this.argus});

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            )),
        title: const Text(
          'Terms & COnditions',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
