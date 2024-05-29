import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dkapp/route_access_file.dart';
import 'global_blocs/internet/internet_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider<InternetCubit>(
          create: (BuildContext context) => InternetCubit(),
        ),
      ],
      child: const MaterialApp(
        title: 'Digital Khata',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: RouteAccessGenerator.routerFunc,
      ),
    );
  }
}
