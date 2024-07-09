// ignore_for_file: must_be_immutable
import 'package:dkapp/global_blocs/internet/internet_cubit.dart';
import 'package:dkapp/global_blocs/internet/internet_state.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/utils/exceptions.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async' as t1;

import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ContactVerificationScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ContactVerificationScreen({super.key, required this.argus});

  @override
  State<ContactVerificationScreen> createState() =>
      _ContactVerificationScreenState();
}

class _ContactVerificationScreenState extends State<ContactVerificationScreen> {
  TextEditingController otpController = TextEditingController();
  final CountdownController countdownController =
      CountdownController(autoStart: true);
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  int reloadCountdownSeconds = 0;
  bool otpSent = false;
  bool showResendButton = false;
  TextEditingController businessContactController = TextEditingController();
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

  @override
  void initState() {
    fetchContact();
    super.initState();
  }

  fetchContact() {
    if (widget.argus.containsKey('contactData')) {
      businessContactController.text = widget.argus['contactData'];
    }
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
  resendOTP(Map<String, dynamic> argus) async {
    // var map = {};
    // try {
    //   map['emailORmobile'] =
    //       (widget.argus['loginResponseData'] as LoginResponseData)
    //           .emailORmobile;
    //   map['token'] = 'bnbuujn';

    //   map['type'] = ((widget.argus['loginResponseData'] as LoginResponseData)
    //           .emailORmobile!
    //           .isValidEmail())
    //       ? '2'
    //       : '1';

    //   http.Response response = await http.post(
    //       Uri.http(APIPathList.mainDomain, APIPathList.resendOTP),
    //       body: map,
    //       headers: {
    //         "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
    //       });
    //   print(response.body);
    //   if (response.statusCode == 200) {
    //     MobileOtpResponseModel jsonResponse =
    //         MobileOtpResponseModel.fromJson(convert.jsonDecode(response.body));
    //     print(response.body);
    //     if (jsonResponse.response != "failure") {
    //       if (kDebugMode) {
    //         print(jsonResponse.toString());
    //       }
    //       Navigator.pushReplacementNamed(context, '/mobile-otp', arguments: {
    //         "loginResponseData":
    //             (widget.argus['loginResponseData'] as LoginResponseData)
    //       });
    //       EssentialWidgetsCollection.showSuccessSnackbar(
    //           context, jsonResponse.message!);
    //     } else {
    //       EssentialWidgetsCollection.showErrorSnackbar(
    //           context, jsonResponse.message!);
    //     }
    //   } else {
    //     EssentialWidgetsCollection.showErrorSnackbar(
    //         context, 'Request failed with status: ${response.statusCode}.');
    //   }
    // } on PlatformException {
    //   EssentialWidgetsCollection.showErrorSnackbar(
    //       context, 'Failed to get platform version.');
    // }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
      child: Scaffold(
        body: Container(
           decoration: BoxDecoration(color: Colors.grey[100]),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                iconTheme: const IconThemeData(color: Colors.white),
                systemOverlayStyle: SystemUiOverlayStyle.light,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background image or color
                      Container(
                        color: Colors.blue,
                      ),
                      // Profile picture
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "resources/images/house-icon-removebg-preview.png",
                            height: screenSize.height * 0.09,
                            width: screenSize.width * 0.09,
                          ),
                          const Text(
                            "Mobile Verification",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Flexible(
                            child: Text(
                              "We will send an OTP to this mobile number to verify",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                      // Camera icon
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: businessContactController,
                          textCapitalization: TextCapitalization.words,
                          enabled: (otpSent == true) ? false : true,
                          maxLength: 10,
                          style: const TextStyle(color: Colors.black),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            counterText: '',
                            labelText: 'Enter Contact Number',
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 31, 1, 102)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 1, 102)),
                                borderRadius: BorderRadius.circular(8.0)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                borderRadius: BorderRadius.circular(8.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 31, 1, 102),
                                ),
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (otpSent == true)
                            ? Column(
                                children: [
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Pinput(
                                      controller: otpController,
                                      length: 6,
                                      // focusNode: focusNode,
                                      pinputAutovalidateMode:
                                          PinputAutovalidateMode.onSubmit,
                                      showCursor: true,
                                      defaultPinTheme: defaultPinTheme,
                                      autofocus: true,
                                      validator: (value) {
                                        // return value ==
                                        //         (widget.argus['loginResponseData']
                                        //                 as LoginResponseData)
                                        //             .otp
                                        //     ? null
                                        //     : 'OTP does not matched.';
                                        return (value!.compareTo("123456") == 0)
                                            ? null
                                            : 'OTP does not matched.';
                                      },
          
                                      keyboardType: TextInputType.number,
                                      hapticFeedbackType:
                                          HapticFeedbackType.vibrate,
                                      focusedPinTheme:
                                          defaultPinTheme.copyDecorationWith(
                                              color: Colors.white,
                                              border:
                                                  Border.all(color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                      submittedPinTheme:
                                          defaultPinTheme.copyDecorationWith(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    245, 12, 44, 104),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                      onCompleted: (pin) {
                                        debugPrint('onCompleted: $pin');
                                        setState(() {
                                          inputPinned = pin;
                                        });
                                        if ((pin.compareTo("123456") == 0)) {
                                          Map<String, dynamic>
                                              selectedStringData = {};
                                          selectedStringData['contactDataPass'] =
                                              businessContactController.text;
                                          Navigator.pop(
                                              context, selectedStringData);
                                        }
                                      },
                                      onChanged: (value) {
                                        debugPrint('onChanged: $value');
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blueGrey,
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
                                ],
                              )
                            : OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  if (businessContactController.text
                                      .isValidContact()) {
                                    setState(() {
                                      otpSent = true;
                                    });
                                  } else {
                                    EssentialWidgetsCollection.showErrorSnackbar(
                                        context,
                                        title: null,description: "Please Enter Valid Contact Number");
                                  }
                                },
                                child: const Text("Send OTP")),
                        const SizedBox(
                          height: 10,
                        ),
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
                                ],
                              )
                            : Container()
                      ],
                    )),
                  ),
                  childCount: 1, // Replace with your item count
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
