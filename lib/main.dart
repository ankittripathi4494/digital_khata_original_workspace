// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dkapp/route_access_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'global_blocs/internet/internet_cubit.dart';
import 'global_blocs/locale/locale_cubit.dart';
import 'global_blocs/locale/locale_state.dart';
import 'utils/firebase_messaging_helper.dart';
import 'utils/shared_preferences_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the SharedPreferencesHelper
  await SharedPreferencesHelper().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessagingHelper();
  runApp(MyApp(
    key: const Key('MyApp'),
  ));
}

class MyApp extends StatelessWidget {
  late Locale? locale;
  final String? data;
  MyApp({super.key, this.data}) {
    _loadLangData();
  }

  _loadLangData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locale = Locale(prefs.getString("lang")!);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (BuildContext context) => InternetCubit(),
          ),
          BlocProvider<LocaleCubit>(
            create: (BuildContext context) => LocaleCubit(),
          ),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state2) {
            if (state2 is SelectedLocale) {
              return const MaterialApp(
                title: 'Digital Khata',
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                onGenerateRoute: RouteAccessGenerator.routerFunc,
              );
            }
            return const MaterialApp(
              title: 'Digital Khata',
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              onGenerateRoute: RouteAccessGenerator.routerFunc,
            );
          },
        ));
  }
}
