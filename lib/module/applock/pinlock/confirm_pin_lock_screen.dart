// ignore_for_file: must_be_immutable

import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:numpad/numpad.dart';
import 'package:pinput/pinput.dart';
import 'package:talker/talker.dart';

class ConfirmPinLockScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ConfirmPinLockScreen({super.key, required this.argus});

  @override
  State<ConfirmPinLockScreen> createState() => _ConfirmPinLockScreenState();
}

class _ConfirmPinLockScreenState extends State<ConfirmPinLockScreen> {
  final FocusNode _focus = FocusNode(); // 1) init _focus
  TextEditingController textController = TextEditingController();
  String code = '';

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
              'Confirm Pin',
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
                validator: (value) {
                  return value == widget.argus['devicePin']
                      ? null
                      : 'Pin and Confirm Pin are not matched';
                },
                onCompleted: (pin) {
                  Talker().info('onCompleted: ');
                  if (pin == widget.argus['devicePin']) {
                    setState(() {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                                scrollable: true,
                                elevation: 20,
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      size: 40,
                                    ),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    const Text(
                                      "Passcode Reset Successful!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    EssentialWidgetsCollection.autoScheduleTask(
                                      context,
                                      childWidget: Container(),
                                      taskWaitDuration:
                                          const Duration(seconds: 1),
                                      task: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          // initScreen = 1;
                                          if (kDebugMode) {
                                            Talker().info('init-={initScreen}');
                                          }
                                          Navigator.pushNamed(
                                              context, '/dashboard');
                                        });
                                      },
                                    )
                                  ],
                                ));
                          });
                      // showLoader = true;
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => DashBoardScreen(
                      //             title: '',
                      //             currentIndex: 0,
                      //             accountId: widget.accountId.toString(),
                      //             authToken: widget.authToken.toString(),
                      //             mPin: widget.mPin.toString())));
                    });
                  }
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
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const ConfirmPinLockScreen()),
      // );
    }

    if (kDebugMode) {
      Talker().info(textController.text);
    }
  }
}
