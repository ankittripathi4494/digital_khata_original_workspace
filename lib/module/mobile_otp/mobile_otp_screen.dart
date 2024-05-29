// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MobileOtpScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  MobileOtpScreen({super.key, required this.argus});

  @override
  State<MobileOtpScreen> createState() => _MobileOtpScreenState();
}

class _MobileOtpScreenState extends State<MobileOtpScreen> {
  TextEditingController otpController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 46,
    height: 46,
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0)),
  );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        // appBar: AppBar(backgroundColor: Colors.blue,),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                const Text(
                  'Check your mobile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                const Text(
                  'A 6-digit code was sent to your Phone Number. Enter it within 2 minutes.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    controller: otpController,
                    length: 6,
                    // focusNode: focusNode,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    defaultPinTheme: defaultPinTheme,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    hapticFeedbackType: HapticFeedbackType.vibrate,
                    focusedPinTheme: defaultPinTheme.copyDecorationWith(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0)),
                    submittedPinTheme: defaultPinTheme.copyDecorationWith(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(245, 12, 44, 104),
                        ),
                        borderRadius: BorderRadius.circular(8.0)),
                    onCompleted: (pin) {},
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                  ),
                ),
                SizedBox(
                  height: screenSize.height / 1.9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Need help?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    // SizedBox(
                    //   width: screenSize.width * 0.01,
                    // ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Click here',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   style: TextButton.styleFrom(),
                    //   child: Text(
                    //     'Click here',
                    //     style: TextStyle(color: Colors.grey, fontSize: 12),
                    //   ),
                    // )
                  ],
                )
                // Directionality(
                //   textDirection: TextDirection.ltr,
                //   child: Pinput(
                //     controller: otpController,
                //     length: 6,
                //     defaultPinTheme: PinTheme(
                //         textStyle: const TextStyle(
                //             color: Color.fromARGB(255, 31, 1, 102),
                //             fontSize: 20.0),
                //         height: 56,
                //         width: 56,
                //         // height: screenSize.height * 0.05,
                //         // width: screenSize.width * 0.7,
                //         // padding: const EdgeInsets.all(20.0),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8.0),
                //           border: Border.all(
                //             color: Colors.grey,
                //           ),
                //         )),
                //     focusedPinTheme: PinTheme(
                //         textStyle: const TextStyle(
                //             color: Color.fromARGB(255, 31, 1, 102),
                //             fontSize: 20.0),
                //         height: 56,
                //         width: 56,
                //         // height: screenSize.height * 0.05,
                //         // width: screenSize.width * 0.7,
                //         padding: const EdgeInsets.all(20.0),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8.0),
                //           border: Border.all(
                //             color: const Color.fromARGB(255, 31, 1, 102),
                //           ),
                //         )),
                //     submittedPinTheme: PinTheme(
                //         textStyle: const TextStyle(
                //             color: Color.fromARGB(255, 31, 1, 102),
                //             fontSize: 20.0),
                //         height: 56,
                //         width: 56,
                //         // height: screenSize.height * 0.05,
                //         // width: screenSize.width * 0.7,
                //         padding: const EdgeInsets.all(20.0),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8.0),
                //           border: Border.all(
                //             color: const Color.fromARGB(255, 31, 1, 102),
                //           ),
                //         )),
                //   ),
                // )
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.06,
              vertical: screenSize.height * 0.01),
          // width: screenSize.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(245, 12, 44, 104),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
            child: Container(
                height: 50.0,
                width: screenSize.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(245, 12, 44, 104),
                    borderRadius: BorderRadius.circular(8.0)),
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.001,
                    vertical: screenSize.height * 0.001),
                // padding: EdgeInsets.symmetric(
                //   horizontal: screenSize.width * 0.01,
                // ),
                child: const Center(
                  child: Text(
                    'Verify code',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
