
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  // Passing an initial value (state) with a default 'Locale' to the super class.
  LocaleCubit() : super(SelectedLocale(const Locale('en')));

  // Once we call this method, the BlocBuilder<LocaleCubit>
  // in the 'main.dart' will rebuild the entire app with
  // the new emitted state that holds the 'ar' locale.
  Future<void> toHindi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', 'hi');
    emit(SelectedLocale(const Locale('hi')));
  }

  // Same as the previous method, but with the 'en' locale.
  Future<void> toEnglish() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', 'en');
    emit(SelectedLocale(const Locale('en')));
  }
}
