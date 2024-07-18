// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AppLockScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  AppLockScreen({super.key, required this.argus});

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'App Security/Lock',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 233, 233, 233),
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: const Text(
                'PRIVACY',
                style: TextStyle(
                    color: Color.fromARGB(255, 100, 99, 99), fontSize: 15.0),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/lock-type');
              },
              child: Container(
                  width: screenSize.width,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: const ListTile(
                    leading: Icon(
                      Icons.lock,
                      size: 25,
                    ),
                    title: Text('Set App Lock'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
