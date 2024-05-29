// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';

class ConfirmPatternScreen extends StatefulWidget {
     late Map<String, dynamic> argus;
  ConfirmPatternScreen({super.key, required this.argus});
  @override
  State<ConfirmPatternScreen> createState() => _ConfirmPatternScreenState();
}

class _ConfirmPatternScreenState extends State<ConfirmPatternScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isConfirm = false;
  List<int>? pattern;

  @override
  Widget build(BuildContext context) {
    List<int>? pattern =
        ModalRoute.of(context)!.settings.arguments as List<int>?;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 31, 1, 102),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Flexible(
            child: Text(
              "Confirm pattern",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          Flexible(
            child: PatternLock(
              notSelectedColor: Colors.white,
              selectedColor: Colors.red,
              pointRadius: 5,
              showInput: true,
              dimension: 3,
              relativePadding: 0.7,
              selectThreshold: 25,
              fillPoints: true,
              onInputComplete: (List<int> input) {
                if (input.length < 3) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "At least 3 points required",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                setState(() {
                  if (isConfirm) {
                    if (listEquals<int>(input, pattern)) {
                      Navigator.pushNamed(context, '/dashboard');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Pattern does not match",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    pattern = input;
                    isConfirm = true;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Pattern saved. Please confirm.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushNamed(context, '/dashboard');
                  }
                });
              },
            ),
          ),
          // Flexible(
          //   child: PatternLock(
          //     notSelectedColor: Colors.white,
          //     selectedColor: Colors.red,
          //     pointRadius: 5,
          //     showInput: true,
          //     dimension: 3,
          //     relativePadding: 0.7,
          //     selectThreshold: 25,
          //     fillPoints: true,
          //     onInputComplete: (List<int> input) {
          //       if (listEquals<int>(input, pattern)) {
          //         Navigator.of(context).pop(true);
          //       } else {
          //         // context.replaceSnackbar(
          //         //   content: Text("wrong", textAlign: TextAlign.center,
          //         //     style: TextStyle(color: Colors.white,fontSize: 12),
          //         //   ), color: Colors.red,
          //         // );
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
