// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously, avoid_print, must_be_immutable

import 'dart:async';

import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';

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
    Talker().info("Called Splash");
  }

  redirectPage() async {
    if (sph.containsKey("userLoggedIn") == true) {
      if (sph.getBool("userLoggedIn") == true) {
        Talker().info("Arguments:- ${widget.argus.toString()}");
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
          Timer(Durations.medium2, () => redirectPage());
        }
        if (state == InternetState.internetLost) {
          Timer(Durations.short2, () {
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
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
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
        floatingActionButton: SizedBox(
          height: screenSize.height * 0.05,
          child: const Center(
              child: Text(
            'Made with ❤️ in India',
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
