// ignore_for_file: avoid_print

import 'package:dkapp/module/login/model/login_response_model.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/exceptions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String platformVersion = "UnKnown";
  String? fcmToken;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  LoginBloc() : super(LoginInitialState()) {
    //! Phone Number Text Change Event
    on<LoginPhoneNumberTextChangedEvent>((event, emit) {
      if (event.phoneNumberValue.isEmpty) {
        emit(LoginPhoneNumberErrorState(
            errorMessage: "Please Enter Phone Number!!"));
      } else if (event.phoneNumberValue.length < 10) {
        emit(LoginPhoneNumberErrorState(
            errorMessage: "Please Enter Valid Phone Number!!"));
      } else {
        emit(LoginPhoneNumberValidState());
      }
    });

    //! Email Id Text Change Event
    on<LoginEmailTextChangedEvent>((event, emit) {
      if (event.emailValue.isEmpty) {
        emit(LoginEmailIDErrorState(errorMessage: "Please Enter email id!!"));
      } else if (!event.emailValue.isValidEmail()) {
        emit(LoginEmailIDErrorState(
            errorMessage: "Please Enter Valid email id!!"));
      } else {
        emit(LoginEmailIDValidState());
      }
    });

    //! Phone Number Form Submissions Event
    on<LoginPhoneNumberFormSubmissionEvent>((event, emit) async {
      emit(LoginPhoneNumberLoadingState());
      var map = {};
      fcmToken = await messaging.getToken();
      try {
        map['emailORmobile'] = event.phoneNumber.toString().trim();
        map['token'] = 'bnbuujn';
        map['fcm'] = fcmToken;
        map['type'] = '1';

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.userLogin),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        print(response.body);
        if (response.statusCode == 200) {
          LoginResponseModel jsonResponse =
              LoginResponseModel.fromJson(convert.jsonDecode(response.body));
          print(response.body);
          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              print(jsonResponse.response.toString());
            }

            if (kDebugMode) {
              print(jsonResponse.data!.otp.toString().trim());
              print(jsonResponse.data!.toString());
              print(fcmToken);
            }
            print(fcmToken!);
            emit(LoginPhoneNumberSuccessState(successData: jsonResponse.data!));
          } else {
            emit(LoginPhoneNumberFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(LoginPhoneNumberFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        platformVersion = 'Failed to get platform version.';
        emit(LoginPhoneNumberFailedState(
          failedMessage: platformVersion,
        ));
      }
    });

    //! Email ID Form Submissions Event
    on<LoginEmailFormSubmissionEvent>((event, emit) async {
      emit(LoginEmailIDLoadingState());
      var map = {};
      fcmToken = await messaging.getToken();
      try {
        map['emailORmobile'] = event.email.toString().trim();
        map['token'] = 'bnbuujn';
        map['fcm'] = fcmToken;
        map['type'] = '2';

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.userLogin),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });

        if (response.statusCode == 200) {
          LoginResponseModel jsonResponse =
              LoginResponseModel.fromJson(convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              print(jsonResponse.response.toString());
            }

            if (kDebugMode) {
              print(jsonResponse.data!.otp.toString());
              print(jsonResponse.data.toString());
              print(fcmToken);
            }
            emit(LoginEmailIDSuccessState(successData: jsonResponse.data!));
          } else {
            emit(LoginEmailIDFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(LoginEmailIDFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        platformVersion = 'Failed to get platform version.';
        emit(LoginEmailIDFailedState(
          failedMessage: platformVersion,
        ));
      }
    });
  }
}
