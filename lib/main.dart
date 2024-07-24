// ignore_for_file: must_be_immutable

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dkapp/module/discount/discount_bloc/discount_bloc.dart';
import 'package:dkapp/module/tax/tax_bloc/tax_bloc.dart';
import 'module/plan/plan_bloc/plan_bloc.dart';
import 'module/product/product_bloc/product_bloc.dart';
import 'module/profile/transactions/transactions_bloc.dart';
import 'module/recurring/recurring_bloc/recurring_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global_widget/animated_loading_widget.dart';
import 'Localization/app_localizations_setup.dart';
import 'firebase_options.dart';
import 'global_blocs/internet/internet_cubit.dart';
import 'global_blocs/locale/locale_cubit.dart';
import 'global_blocs/locale/locale_state.dart';
import 'module/account/account_bloc/account_bloc.dart';
import 'module/business/business_bloc/business_bloc.dart';
import 'module/business/user_group_bloc/user_group_bloc.dart';
import 'module/business_type/business_type_bloc/business_type_bloc.dart';
import 'module/customers/customer_bloc/customer_bloc.dart';
import 'module/login/login_bloc/login_bloc.dart';
import 'module/service/service_bloc/service_bloc.dart';
import 'route_access_file.dart';
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
    return FutureBuilder<void>(
        future: _loadLangData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
                BlocProvider<CustomerBloc>(
                  create: (BuildContext context) => CustomerBloc(),
                ),
                BlocProvider<BusinessTypeBloc>(
                  create: (BuildContext context) => BusinessTypeBloc(),
                ),
                BlocProvider<BusinessBloc>(
                  create: (BuildContext context) => BusinessBloc(),
                ),
                BlocProvider<UserGroupBloc>(
                  create: (BuildContext context) => UserGroupBloc(),
                ),
                BlocProvider<TransactionsBloc>(
                  create: (BuildContext context) => TransactionsBloc(),
                ),
                BlocProvider<PlanBloc>(
                  create: (BuildContext context) => PlanBloc(),
                ),
                BlocProvider<RecurringBloc>(
                  create: (BuildContext context) => RecurringBloc(),
                ),
                BlocProvider<ProductBloc>(
                  create: (BuildContext context) => ProductBloc(),
                ),
                BlocProvider<ServiceBloc>(
                  create: (BuildContext context) => ServiceBloc(),
                ),
                 BlocProvider<DiscountBloc>(
                  create: (BuildContext context) => DiscountBloc(),
                ),
                 BlocProvider<TaxBloc>(
                  create: (BuildContext context) => TaxBloc(),
                ),
              ],
              child: BlocBuilder<LocaleCubit, LocaleState>(
                builder: (context, localeState) {
                  Locale? appLocale = localeState is SelectedLocale
                      ? localeState.locale
                      : locale;
                  return MaterialApp(
                    navigatorKey: navigatorKey,
                    supportedLocales: AppLocalizationsSetup.supportedLocales,
                    localizationsDelegates:
                        AppLocalizationsSetup.localizationsDelegates,
                    localeResolutionCallback:
                        AppLocalizationsSetup.localeResolutionCallback,
                    locale: appLocale,
                    title: 'Digital Khata',
                    debugShowCheckedModeBanner: false,
                    initialRoute: '/',
                    onGenerateRoute: RouteAccessGenerator.routerFunc,
                  );
                },
              ),
            );
          }
          return Center(child: AnimatedImageLoader());
        });
  }
}
