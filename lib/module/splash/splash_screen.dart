// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously, avoid_print, must_be_immutable, unused_import

import 'dart:async';

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';


import '../../global_blocs/internet/internet_cubit.dart';
import '../../global_blocs/internet/internet_state.dart';

class SplashScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  SplashScreen({super.key, required this.argus});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? darkTheme;
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  @override
  void initState() {
    super.initState();
    LoggerUtil().infoData("Called Splash");
  }

  redirectPage() async {
    if (sph.containsKey("userLoggedIn") == true) {
      if (sph.getBool("userLoggedIn") == true) {
        LoggerUtil().infoData("Arguments:- ${widget.argus.toString()}");
        if (sph.containsKey("loginType") == true) {
          Navigator.pushReplacementNamed(context, '/add-new-business',
              arguments: {"fromLoginPage": true});
        } else {
          Navigator.pushReplacementNamed(
            context,
            '/dashboard',
          );
        }
      } else {
        Navigator.pushReplacementNamed(
          context,
          '/login',
        );
      }
    } else {
      Navigator.pushReplacementNamed(
        context,
        '/login',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetAvailable) {
          Timer(Durations.long4, () => redirectPage());
        }
        if (state == InternetState.internetLost) {
          Timer(Durations.long4, () {
            Navigator.pushReplacementNamed(
              context,
              '/no-internet',
            );
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        bottomNavigationBar: const SizedBox(),
        body: Container(
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.15,
              ),
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
                child: Icon(
                  Icons.note_alt,
                  color: Colors.cyan,
                  size: 100,
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.04,
              ),
              const Center(
                child: Text(
                  'DigitalKhata',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedImageLoader(indicatorType: Indicator.ballClipRotateMultiple,loaderType: LoaderType.splash,),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: screenSize.height * 0.05,
              child: const Center(
                  child: Text(
                'Made with ❤️ in India',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
