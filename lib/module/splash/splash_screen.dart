// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:duration_button/duration_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global_blocs/internet/internet_cubit.dart';
import '../../global_blocs/internet/internet_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? darkTheme;
  @override
  void initState() {
    super.initState();
    print("Called Splash");
    BlocProvider<InternetCubit>(
      create: (BuildContext context) => InternetCubit(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      bottomNavigationBar: const SizedBox(),
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state == InternetState.internetAvailable) {
                  return DurationButton(
                      width: 1,
                      height: 1,
                      hoverColor: Colors.transparent,
                      coverColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onComplete: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (prefs.getBool("userLoggedIn") == true) {
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        } else {
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      },
                      onPressed: () {},
                      duration: Durations.medium2,
                      child: Container());
                }
                if (state == InternetState.internetLost) {
                  return DurationButton(
                      width: 1,
                      height: 1,
                      hoverColor: Colors.transparent,
                      coverColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onComplete: () async {
                        Navigator.pushReplacementNamed(context, '/no-internet');
                      },
                      onPressed: () {},
                      duration: Durations.medium2,
                      child: Container());
                }
                return Container();
              },
            ),
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
            // DurationButton(
            //   backgroundColor: Colors.transparent,
            //   onPressed: () {},
            //   duration: Duration(seconds: 1),
            //   child: CircularProgressIndicator(
            //     backgroundColor: Colors.blue,
            //     color: Colors.white,
            //   ),
            // )
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
    );
  }
}
