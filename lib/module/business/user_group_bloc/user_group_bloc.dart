// ignore_for_file: avoid_print

import 'package:dkapp/module/business/model/add_new_user_group_response_model.dart';
import 'package:dkapp/module/business/model/delete_user_group_response_model.dart';
import 'package:dkapp/module/business/model/update_user_group_response_model.dart';
import 'package:dkapp/module/business/model/user_group_model.dart';
import 'package:dkapp/module/business/user_group_bloc/user_group_event.dart';
import 'package:dkapp/module/business/user_group_bloc/user_group_state.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class UserGroupBloc extends Bloc<UserGroupEvent, UserGroupState> {
  UserGroupBloc() : super(UserGroupInitial()) {
    on<UserGroupListFetchEvent>((event, emit) async {
      emit(UserGroupListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['business_id'] = event.businessId;
        print(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getUserGroupList),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        // print(response.body);
        if (response.statusCode == 200) {
          UserGroupResponseModel jsonResponse = UserGroupResponseModel.fromJson(
              convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            // if (kDebugMode) {
            //   print(jsonResponse.data!.toString());
            // }

            emit(UserGroupListLoadedState(
              successData: jsonResponse.data,
            ));
          } else {
            emit(UserGroupListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(UserGroupListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(UserGroupListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
    on<AddNewUserGroupTextChangedEvent>((event, emit) async {
      if (event.groupName.isEmpty) {
        emit(AddNewUserGroupTextChangedErrorState(
            groupNameError: "Please enter group name",
            groupMobileError: null,
            groupDescriptionError: null));
      } else if (event.groupMobile.isEmpty) {
        emit(AddNewUserGroupTextChangedErrorState(
            groupNameError: null,
            groupMobileError: "Please enter group contact number",
            groupDescriptionError: null));
      } else if (event.groupMobile.length<10) {
        emit(AddNewUserGroupTextChangedErrorState(
            groupNameError: null,
            groupMobileError: "Please enter contact number upto 10 digits",
            groupDescriptionError: null));
      }  else {
        emit(AddNewUserGroupValidState());
      }
    });

    on<AddNewUserGroupEvent>((event, emit) async {
      emit(UserGroupListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['business_id'] = event.businessId;
        map['name'] = event.groupName;
        map['mobile'] = event.groupMobile;
        map['description'] = event.groupDescription;
        print(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.createUserGroup),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        print(response.body);
        if (response.statusCode == 200) {
          AddNewUserGroupResponseModel jsonResponse =
              AddNewUserGroupResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              print(jsonResponse.message!.toString());
            }

            emit(AddNewUserGroupSuccessState(
              successMessage: jsonResponse.message!,
            ));
          } else {
            emit(AddNewUserGroupFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(AddNewUserGroupFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(AddNewUserGroupFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<UpdateUserGroupEvent>((event, emit) async {
      emit(UserGroupListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['group_id'] = event.groupId;
        map['business_id'] = event.businessId;
        map['name'] = event.groupName;
        map['mobile'] = event.groupMobile;
        map['description'] = event.groupDescription;
        print(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.updateUserGroup),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        print(response.body);
        if (response.statusCode == 200) {
          UpdateUserGroupResponseModel jsonResponse =
              UpdateUserGroupResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              print(jsonResponse.message!.toString());
            }

            emit(UpdateUserGroupSuccessState(
              successMessage: jsonResponse.message!,
            ));
          } else {
            emit(UpdateUserGroupFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(UpdateUserGroupFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(UpdateUserGroupFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
  
    on<UserGroupDeleteEvent>((event, emit) async {
      emit(UserGroupListLoadingState());

      var map = {};
      try {
        map['token'] = 'bnbuujn';
        map['user_id'] = event.userId;
        map['group_id'] = event.groupId;
        print(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.deleteUserGroup),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        print(response.body);
        if (response.statusCode == 200) {
          DeleteUserGroupResponseModel jsonResponse =
              DeleteUserGroupResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              print(jsonResponse.message!.toString());
            }

            emit(DeleteUserGroupSuccessState(
              successMessage: jsonResponse.message!,
            ));
          } else {
            emit(DeleteUserGroupFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(DeleteUserGroupFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(DeleteUserGroupFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });
  
  }
}
