// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously, avoid_print, must_be_immutable

import 'dart:async';

import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    print("Called Splash");
  }

  redirectPage() async {
    if (sph.containsKey("userLoggedIn") == true) {
      if (sph.getBool("userLoggedIn") == true) {
        print("Arguments:- ${widget.argus.toString()}");
        Navigator.pushReplacementNamed(
          context,
          '/dashboard',
        );
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
          Timer(Durations.short2, () => redirectPage());
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
