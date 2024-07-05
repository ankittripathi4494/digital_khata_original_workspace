// ignore_for_file: must_be_immutable, use_build_context_synchronously, avoid_print

import 'package:dkapp/global_blocs/internet/internet_cubit.dart';
import 'package:dkapp/global_blocs/internet/internet_state.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/login/model/login_response_model.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/exceptions.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'dart:convert' as convert;
import 'dart:async' as t1;

import 'model/mobile_response_model.dart';

class MobileOtpScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  MobileOtpScreen({super.key, required this.argus});

  @override
  State<MobileOtpScreen> createState() => _MobileOtpScreenState();
}

class _MobileOtpScreenState extends State<MobileOtpScreen> {
  TextEditingController otpController = TextEditingController();
  final CountdownController countdownController =
      CountdownController(autoStart: true);
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  int reloadCountdownSeconds = 0;
  bool showResendButton = false;
  String inputPinned = "";
  String intToTimeLeft(int value) {
    int m, s;

    m = ((value)) ~/ 60;

    s = value - (m * 60);

    String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();

    String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

    String result = "$minuteLeft:$secondsLeft";

    return result;
  }

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
     bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetLost) {
          t1.Timer(Durations.medium2, () {
            Navigator.pushReplacementNamed(
              context,
              '/no-internet',
            );
          });
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          // appBar: AppBar(backgroundColor: Colors.blue,),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.15),
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
                  Align(
                    alignment: Alignment.center,
                    child: Countdown(
                      controller: countdownController,
                      seconds: 120,
                      build: (_, double time) => Text(
                        intToTimeLeft(time.toInt()),
                        textAlign: TextAlign.end,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      interval: const Duration(milliseconds: 100),
                      onFinished: () {
                        setState(() {
                          showResendButton = true;
                        });
                      },
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
                      validator: (value) {
                        return value ==
                                (widget.argus['loginResponseData']
                                        as LoginResponseData)
                                    .otp
                            ? null
                            : 'OTP does not matched.';
                      },
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
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                        setState(() {
                          inputPinned = pin;
                        });
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height / 1.9,
                  ),
                 ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton:  keyboardIsOpened
            ? null
            :Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (showResendButton == true)
                  ? Row(
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
                          onPressed: () {
                            resendOTP(widget.argus);
                          },
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
                  : Container(),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.06,
                    vertical: screenSize.height * 0.01),
                // width: screenSize.width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(245, 12, 44, 104),
                ),
                child: InkWell(
                  onTap: () {
                    if (inputPinned ==
                        (widget.argus['loginResponseData'] as LoginResponseData)
                            .otp) {
                      sph.setBool("userLoggedIn", true);
                      sph.setString(
                          "userid",
                          (widget.argus['loginResponseData']
                                  as LoginResponseData)
                              .userId!);
                      sph.setString(
                          "emailORmobile",
                          (widget.argus['loginResponseData']
                                  as LoginResponseData)
                              .emailORmobile!);
                      Navigator.pushReplacementNamed(context, '/dashboard');
                      EssentialWidgetsCollection.showSuccessSnackbar(
                          context, title: null, description: "Login Successful!");
                    }
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
            ],
          ),
        ),
      ),
    );
  }

  resendOTP(Map<String, dynamic> argus) async {
    var map = {};
    try {
      map['emailORmobile'] =
          (widget.argus['loginResponseData'] as LoginResponseData)
              .emailORmobile;
      map['token'] = 'bnbuujn';

      map['type'] = ((widget.argus['loginResponseData'] as LoginResponseData)
              .emailORmobile!
              .isValidEmail())
          ? '2'
          : '1';

      http.Response response = await http.post(
          Uri.http(APIPathList.mainDomain, APIPathList.resendOTP),
          body: map,
          headers: {
            "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
          });
      print(response.body);
      if (response.statusCode == 200) {
        MobileOtpResponseModel jsonResponse =
            MobileOtpResponseModel.fromJson(convert.jsonDecode(response.body));
        print(response.body);
        if (jsonResponse.response != "failure") {
          if (kDebugMode) {
            print(jsonResponse.toString());
          }
          Navigator.pushReplacementNamed(context, '/mobile-otp', arguments: {
            "loginResponseData":
                (widget.argus['loginResponseData'] as LoginResponseData)
          });
          EssentialWidgetsCollection.showSuccessSnackbar(
              context, title: null, description: jsonResponse.message!);
        } else {
          EssentialWidgetsCollection.showErrorSnackbar(
              context, title: null, description: jsonResponse.message!);
        }
      } else {
        EssentialWidgetsCollection.showErrorSnackbar(
            context, title: null, description: 'Request failed with status: ${response.statusCode}.');
      }
    } on PlatformException {
      EssentialWidgetsCollection.showErrorSnackbar(
          context, title: null, description: 'Failed to get platform version.');
    }
  }

}
