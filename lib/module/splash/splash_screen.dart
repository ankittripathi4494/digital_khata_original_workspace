// ignore_for_file: unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_blocs/internet/internet_cubit.dart';
import '../../global_blocs/internet/internet_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? darkTheme;

  Connectivity connectivity = Connectivity();
  List<ConnectivityResult> connectivityResult = [ConnectivityResult.none];

  String connectivityCheck(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      return "You are now connected to wifi";
    } else if (connectivityResult == ConnectivityResult.mobile) {
      return "You are now connected to mobile data";
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      return "You are now connected to ethernet";
    } else if (connectivityResult == ConnectivityResult.bluetooth) {
      return "You are now connected to bluetooth";
    } else if (connectivityResult == ConnectivityResult.none) {
      return "No connection available";
    } else {
      return "No Connection!!";
    }
  }

  @override
  void initState() {
    super.initState();

    connectivityCheck(connectivityResult.first);
    connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      setState(() {
        connectivityResult = result;
        if (connectivityResult == ConnectivityResult.none) {
          if (kDebugMode) {
            print("No Internet Connected");
          }
        } else if (connectivityResult == ConnectivityResult.wifi) {
          if (kDebugMode) {
            print('Internet Connected');
          }
        }
        // print('connection--${connectivityResult}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      bottomNavigationBar: const SizedBox(),
      body: BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state == InternetState.internetAvailable) {
             Navigator.pushNamed(context, '/dashboard');
          } else if (state == InternetState.internetLost) {
            Navigator.pushNamed(context, '/no-internet');
          }
        },
        child: Container(
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
