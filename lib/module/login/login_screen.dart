// ignore_for_file: must_be_immutable, avoid_print, duplicate_ignore, use_build_context_synchronously

import 'dart:async';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:dkapp/global_blocs/internet/internet_cubit.dart';
import 'package:dkapp/global_blocs/internet/internet_state.dart';
import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/login/login_bloc/login_event.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc/login_bloc.dart';
import 'login_bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  LoginScreen({super.key, required this.argus});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailIdController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  @override
  void initState() {
    super.initState();
  }

  redirectPage() async {
    if (sph.containsKey("userLoggedIn") == true) {
      if (sph.getBool("userLoggedIn") == true) {
        Navigator.pushReplacementNamed(context, '/dashboard',
            arguments: widget.argus);
      } else {
        Navigator.pushReplacementNamed(context, '/login',
            arguments: widget.argus);
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login',
          arguments: widget.argus);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetLost) {
          Timer(Durations.medium2, () {
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
      backgroundColor: Colors.grey[100],
          body: Container(
             decoration: BoxDecoration(color: Colors.grey[100]),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20.0)),
                      // margin:
                      //     EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
                      padding: const EdgeInsets.all(15.0),
                      child: const Icon(
                        Icons.note_alt_sharp,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.05,
                    ),
                    const Text(
                      'Welcome to Digital Khata',
                      style: TextStyle(
                          color: Color.fromARGB(255, 31, 1, 102),
                          fontSize: 28,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: screenSize.height / 2,
                      child: ContainedTabBarView(
                        tabBarProperties: TabBarProperties(
                            labelPadding: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.01),
                            labelColor: const Color.fromARGB(255, 31, 1, 102),
                            indicatorColor: const Color.fromARGB(255, 31, 1, 102),
                            labelStyle: const TextStyle(fontSize: 18.0),
                            isScrollable: false,
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.02)),
                        tabs: const [
                          Text('Phone Number'),
                          Text('Email Address'),
                        ],
                        views: [
                          //tab 1: phone numbers
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  (state is LoginPhoneNumberSuccessState)
                                      ? EssentialWidgetsCollection
                                          .autoScheduleTask(
                                          context,
                                          childWidget: Container(
                                            height: 50,
                                            margin: const EdgeInsets.all(10.0),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.green.withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const ListTile(
                                              tileColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              leading: Icon(
                                                Icons.check_circle,
                                                size: 25,
                                                color: Colors.white,
                                              ),
                                              title: Text(
                                                "OTP Sent successfully",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    height: 1.5),
                                              ),
                                            ),
                                          ),
                                          taskWaitDuration: Durations.long3,
                                          task: () {
                                            Navigator.pushNamed(
                                                context, '/mobile-otp',
                                                arguments: {
                                                  "loginResponseModel":
                                                      state.successData
                                                });
                                          },
                                        )
                                      : Container(),
                                  (state is LoginPhoneNumberFailedState)
                                      ? EssentialWidgetsCollection
                                          .autoScheduleTask(
                                          context,
                                          childWidget: Container(
                                            height: 50,
                                            margin: const EdgeInsets.all(10.0),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.red.withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: ListTile(
                                              tileColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              leading: const Icon(
                                                Icons.cancel_rounded,
                                                size: 25,
                                                color: Colors.white,
                                              ),
                                              title: Text(
                                                state.failedMessage,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    height: 1.5),
                                              ),
                                            ),
                                          ),
                                          taskWaitDuration: Durations.long3,
                                          task: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              '/login',
                                            );
                                          },
                                        )
                                      : Container(),
                                  TextFormField(
                                    controller: phoneNumberController,
                                    cursorColor:
                                        const Color.fromARGB(255, 31, 1, 102),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                    ),
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      FilteringTextInputFormatter.deny('\\s')
                                    ],
                                    onChanged: (value) {
                                      BlocProvider.of<LoginBloc>(context).add(
                                          LoginPhoneNumberTextChangedEvent(
                                              phoneNumberValue:
                                                  phoneNumberController.text));
                                    },
                                    decoration: InputDecoration(
                                      errorText:
                                          (state is LoginPhoneNumberErrorState)
                                              ? state.errorMessage
                                              : null,
                                      counterText: "",
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          "resources/images/flag-removebg-preview.png",
                                          height: screenSize.height * 0.008,
                                          width: screenSize.width * 0.008,
                                        ),
                                      ),
                                      hintText: 'Phone Number',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                  ),
                                  (state is LoginPhoneNumberLoadingState)
                                      ?  AnimatedImageLoader()
                                      : InkWell(
                                          onTap: (state
                                                  is LoginPhoneNumberValidState)
                                              ? () {
                                                  BlocProvider.of<LoginBloc>(
                                                          context)
                                                      .add(LoginPhoneNumberFormSubmissionEvent(
                                                          phoneNumber:
                                                              phoneNumberController
                                                                  .text));
                                                }
                                              : null,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical:
                                                    screenSize.height * 0.03),
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    screenSize.height * 0.013),
                                            decoration: BoxDecoration(
                                                color: ((phoneNumberController
                                                            .text.isEmpty) ||
                                                        (phoneNumberController
                                                                .text.length <
                                                            10))
                                                    ? Colors.grey
                                                    : const Color.fromARGB(
                                                        255, 31, 1, 102),
                                                borderRadius:
                                                    BorderRadius.circular(10.0)),
                                            width: screenSize.width,
                                            child: const Center(
                                              child: Text(
                                                'Next',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        )
                                ],
                              );
                            },
                          ),
                          //tab 2: email address
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  (state is LoginEmailIDSuccessState)
                                      ? EssentialWidgetsCollection
                                          .autoScheduleTask(
                                          context,
                                          childWidget: Container(
                                            height: 50,
                                            margin: const EdgeInsets.all(10.0),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.green.withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const ListTile(
                                              tileColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              leading: Icon(
                                                Icons.check_circle,
                                                size: 25,
                                                color: Colors.white,
                                              ),
                                              title: Text(
                                                "OTP Sent successfully",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    height: 1.5),
                                              ),
                                            ),
                                          ),
                                          taskWaitDuration: Durations.long3,
                                          task: () {
                                             Navigator.pushNamed(
                                                context, '/mobile-otp',
                                                arguments: {
                                                  "loginResponseModel":
                                                      state.successData
                                                });
                                          },
                                        )
                                      : Container(),
                                  (state is LoginEmailIDFailedState)
                                      ? EssentialWidgetsCollection
                                          .autoScheduleTask(
                                          context,
                                          childWidget: Container(
                                            height: 50,
                                            margin: const EdgeInsets.all(10.0),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.red.withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: ListTile(
                                              tileColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              leading: const Icon(
                                                Icons.cancel_rounded,
                                                size: 25,
                                                color: Colors.white,
                                              ),
                                              title: Text(
                                                state.failedMessage,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    height: 1.5),
                                              ),
                                            ),
                                          ),
                                          taskWaitDuration: Durations.long3,
                                          task: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              '/login',
                                            );
                                          },
                                        )
                                      : Container(),
                                  TextFormField(
                                    controller: emailIdController,
                                    cursorColor:
                                        const Color.fromARGB(255, 31, 1, 102),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 31, 1, 102),
                                    ),
                                    keyboardType: TextInputType.name,
                                    onChanged: (value) {
                                      BlocProvider.of<LoginBloc>(context).add(
                                          LoginEmailTextChangedEvent(
                                              emailValue:
                                                  emailIdController.text));
                                    },
                                    decoration: InputDecoration(
                                      errorText: (state is LoginEmailIDErrorState)
                                          ? state.errorMessage
                                          : null,
                                      hintText: 'Email Address',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 31, 1, 102),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                  ),
                                  (state is LoginEmailIDLoadingState)
                                      ?  AnimatedImageLoader()
                                      : InkWell(
                                          onTap: (state is LoginEmailIDValidState)
                                              ? () {
                                                  // Navigator.pushNamed(
                                                  //     context, '/mobile-otp');
                                                  BlocProvider.of<LoginBloc>(
                                                          context)
                                                      .add(LoginEmailFormSubmissionEvent(
                                                          email: emailIdController
                                                              .text));
                                                }
                                              : null,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical:
                                                    screenSize.height * 0.03),
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    screenSize.height * 0.013),
                                            decoration: BoxDecoration(
                                                color: ((emailIdController
                                                            .text.isEmpty) ||
                                                        (emailIdController
                                                                .text.length <
                                                            10))
                                                    ? Colors.grey
                                                    : const Color.fromARGB(
                                                        255, 31, 1, 102),
                                                borderRadius:
                                                    BorderRadius.circular(10.0)),
                                            width: screenSize.width,
                                            child: const Center(
                                              child: Text(
                                                'Next',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),
                                        )
                                ],
                              );
                            },
                          ),
                        ],
                        // ignore: avoid_print
                        onChange: (index) {
                          // Talker().error(index);
                          if (index == 0) {
                            setState(() {
                              emailIdController.text = "";
                            });
                          } else {
                            setState(() {
                              phoneNumberController.text = "";
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: keyboardIsOpened
              ? null
              : Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.06,
                      vertical: screenSize.height * 0.01),
                  // width: screenSize.width,
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 46.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0.0)),
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.001,
                            vertical: screenSize.height * 0.001),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.01,
                        ),
                        child: Image.asset(
                          "resources/images/google-removebg-preview.png",
                          height: screenSize.height * 0.1,
                          width: screenSize.width * 0.1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenSize.width * 0.2),
                        child: const Text(
                          'Sign with Google',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
