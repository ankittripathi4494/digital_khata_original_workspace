// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:numpad/numpad.dart';
import 'package:pinput/pinput.dart';
import 'package:talker/talker.dart';

class PinLockScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  PinLockScreen({super.key, required this.argus});

  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  final FocusNode _focus = FocusNode(); // 1) init _focus
  TextEditingController textController = TextEditingController();
  String? devicePin;

  @override
  void initState() {
    _focus.requestFocus();
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const defaultPinTheme = PinTheme(
      height: 15.0,
      width: 15.0,
      padding: EdgeInsets.all(10.0),
      textStyle: TextStyle(fontSize: 22, color: Colors.white),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
    );
    const submitPinTheme = PinTheme(
      height: 15.0,
      width: 15.0,
      padding: EdgeInsets.all(10.0),
      textStyle: TextStyle(fontSize: 22, color: Colors.white),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          color: Colors.green),
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 1, 102),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 31, 1, 102),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Create Pin',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
            SizedBox(
              height: screenSize.height * 0.05,
            ),

            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                enabled: true,
                length: 4,
                closeKeyboardWhenCompleted: true,
                controller: textController,
                focusNode: _focus,
                keyboardType: TextInputType.none,
                hapticFeedbackType: HapticFeedbackType.vibrate,
                onCompleted: (pin) {
                  devicePin = pin;
                  Talker().info('onCompleted: ');
                  Navigator.pushNamed(context, '/app-lock/confirm-pin-lock',
                      arguments: {devicePin: devicePin.toString()});
                },
                onChanged: (value) {
                  Talker().info('onChanged: $value');
                },
                cursor: Container(),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: const Border(
                        left: BorderSide.none,
                        right: BorderSide.none,
                        top: BorderSide.none,
                        bottom: BorderSide()),
                  ),
                ),
                submittedPinTheme: submitPinTheme,
                followingPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: const Border(
                        left: BorderSide.none,
                        right: BorderSide.none,
                        top: BorderSide.none,
                        bottom: BorderSide()),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: const Border(
                      left: BorderSide.none,
                      right: BorderSide.none,
                      top: BorderSide.none,
                      bottom: BorderSide()),
                ),
              ),
            ),

            // SizedBox(
            //   height: screenSize.height * 0.28,
            // ),
            NumPad(
              mainAxisSpacing: 30.0,
              backgroundColor: const Color.fromARGB(255, 31, 1, 102),
              crossAxisSpacing: 80.0,
              textStyle: defaultPinTheme.textStyle,
              clearIcon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onTap: (val) {
                _onNumpadTap(val);

                // _onNumpadTap(val);
                // if (val == 99) {
                //   if (code.isNotEmpty) {
                //     setState(() {
                //       code = code.substring(0, code.length - 1);
                //     });
                //   }
                // } else {
                //   setState(() {
                //     code += "$val";
                //   });
                // }
                // Talker().info(code);
              },
            ),
            // NumericKeyboard(
            //   onKeyboardTap: (value) => textController.text += value,
            //   textColor: Colors.red,

            //   rightButtonFn: () => textController.text = textController.text
            //       .substring(0, textController.text.length - 1),

            //   rightIcon: Icon(Icons.backspace, color: Colors.red),

            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // ),
          ],
        ),
      ),
    );
  }

  void _onNumpadTap(int val) {
    if (val == 99) {
      if (textController.text.isNotEmpty) {
        setState(() {
          textController.text =
              textController.text.substring(0, textController.text.length - 1);
        });
      }
    } else {
      if (textController.text.length < 4) {
        setState(() {
          textController.text += "$val";
        });
      }
    }

    if (textController.text.length == 4) {
      Navigator.pushNamed(context, '/app-lock/confirm-pin-lock',
          arguments: {devicePin: devicePin.toString()});
    }

    if (kDebugMode) {
      Talker().info(textController.text);
    }
  }
}
