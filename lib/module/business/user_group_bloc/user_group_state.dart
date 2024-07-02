// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dkapp/module/business/model/user_group_model.dart';

class UserGroupState {}

final class UserGroupInitial extends UserGroupState {}

//! States for Group List Fetch Event

class UserGroupListLoadingState extends UserGroupState {}

class UserGroupListLoadedState extends UserGroupState {
  late final List<UserGroupResponseData>? successData;
  UserGroupListLoadedState({
    this.successData,
  });
}

class UserGroupListFailedState extends UserGroupState {
  late final String failedMessage;
  UserGroupListFailedState({required this.failedMessage});
}

//! States for Add New User Group Text Change Event

class AddNewUserGroupValidState extends UserGroupState {}

class AddNewUserGroupTextChangedErrorState extends UserGroupState {
  late String? groupNameError;
  late String? groupMobileError;
  late String? groupDescriptionError;
  AddNewUserGroupTextChangedErrorState({
    this.groupNameError,
    this.groupMobileError,
    this.groupDescriptionError,
  });
}

//! States for Add New User Group Event

class AddNewUserGroupSuccessState extends UserGroupState {
  late final String successMessage;
  AddNewUserGroupSuccessState({
    required this.successMessage,
  });
}

class AddNewUserGroupFailedState extends UserGroupState {
  late final String failedMessage;
  AddNewUserGroupFailedState({
    required this.failedMessage,
  });
}

//! States for Update User Group Event

class UpdateUserGroupSuccessState extends UserGroupState {
  late final String successMessage;
  UpdateUserGroupSuccessState({
    required this.successMessage,
  });
}

class UpdateUserGroupFailedState extends UserGroupState {
  late final String failedMessage;
  UpdateUserGroupFailedState({
    required this.failedMessage,
  });
}

//! States for Delete User Group Event

class DeleteUserGroupSuccessState extends UserGroupState {
  late final String successMessage;
  DeleteUserGroupSuccessState({
    required this.successMessage,
  });
}

class DeleteUserGroupFailedState extends UserGroupState {
  late final String failedMessage;
  DeleteUserGroupFailedState({
    required this.failedMessage,
  });
}
