// ignore_for_file: must_be_immutable

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dkapp/module/account/account_bloc/account_bloc.dart';
import 'package:dkapp/module/login/login_bloc/login_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dkapp/route_access_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'global_blocs/internet/internet_cubit.dart';
import 'global_blocs/locale/locale_cubit.dart';
import 'global_blocs/locale/locale_state.dart';
import 'utils/firebase_messaging_helper.dart';
import 'utils/notification_controller.dart';
import 'utils/shared_preferences_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the SharedPreferencesHelper
  await SharedPreferencesHelper().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessagingHelper().initialize();

  // Handle notification tap when app is terminated or in the background
  FirebaseMessaging.onBackgroundMessage(
      FirebaseMessagingHelper().firebaseMessagingBackgroundHandler);

  runApp(const MyApp(
    data: "default",
    key: Key('MyApp'),
  ));
}

class MyApp extends StatefulWidget {
  final String? data;
  const MyApp({super.key, this.data});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale? locale;

  @override
  void initState() {
    super.initState();
    _loadLangData();
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
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
          BlocProvider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(),
          ),
          BlocProvider<AccountBloc>(
            create: (BuildContext context) => AccountBloc(),
          ),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state2) {
            if (state2 is SelectedLocale) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                title: 'Digital Khata',
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                onGenerateRoute: RouteAccessGenerator.routerFunc,
              );
            }
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: 'Digital Khata',
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              onGenerateRoute: RouteAccessGenerator.routerFunc,
            );
          },
        ));
  }
}
