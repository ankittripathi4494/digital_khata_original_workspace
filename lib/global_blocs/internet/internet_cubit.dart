import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;
  InternetCubit() : super(InternetState.internetInitial) {
    _checkInternet();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event.contains(ConnectivityResult.mobile) ||
          event.contains(ConnectivityResult.wifi) ||
          event.contains(ConnectivityResult.vpn)) {
        emit(InternetState.internetAvailable);
      } else {
        emit(InternetState.internetLost);
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }

  _checkInternet() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.vpn)) {
      emit(InternetState.internetAvailable);
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(InternetState.internetLost);
    }
  }
}
