// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:pattern_lock/pattern_lock.dart';

class SetPatternScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  SetPatternScreen({super.key, required this.argus});

  @override
  State<SetPatternScreen> createState() => _SetPatternScreenState();
}

class _SetPatternScreenState extends State<SetPatternScreen> {
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isConfirm = false;
  List<int>? pattern;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 31, 1, 102),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Flexible(
            child: Text(
              "Draw Your pattern",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          // Flexible(
          //   child: PatternLock(
          //     selectedColor: Colors.amber,
          //     pointRadius: 12,
          //     onInputComplete: (List<int> input) {
          //       if (input.length < 3) {
          //         // context.replaceSnackbar(
          //         //   content: Text("At least 3 points required", textAlign: TextAlign.center,
          //         //     style: TextStyle(color: Colors.white,fontSize: 12),
          //         //   ), color: Colors.red,
          //         // );
          //         return;
          //       }
          //       if (isConfirm) {
          //         if (listEquals<int>(input, pattern)) {
          //           // Navigator.of(context).pop(pattern);
          //           Navigator.push(context, route)
          //         } else {
          //           // context.replaceSnackbar(
          //           //   content: Text("Patterns do not match", textAlign: TextAlign.center,
          //           //     style: TextStyle(color: Colors.white,fontSize: 12),
          //           //   ), color: Colors.red,
          //           // );
          //           setState(() {
          //             pattern = null;
          //             isConfirm = false;
          //           });
          //         }
          //       } else {
          //         setState(() {
          //           pattern = input;
          //           isConfirm = true;
          //         });
          //       }
          //     },
          //   ),
          // ),
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
              // key: scaffoldKey,
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
                  Navigator.pushNamed(context, '/app-lock/confirm-set-pattern');
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
