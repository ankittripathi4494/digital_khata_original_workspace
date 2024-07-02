// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserGroupEvent {}

class UserGroupListFetchEvent extends UserGroupEvent {
  late final String userId;
  late final String businessId;
  UserGroupListFetchEvent({
    required this.userId,
    required this.businessId,
  });
}

class AddNewUserGroupTextChangedEvent extends UserGroupEvent {
  late String groupName;
  late String groupMobile;
  late String groupDescription;
  AddNewUserGroupTextChangedEvent({
    required this.groupName,
    required this.groupMobile,
    required this.groupDescription,
  });
}

class AddNewUserGroupEvent extends UserGroupEvent {
  late final String userId;
  late final String businessId;
  late String groupName;
  late String groupMobile;
  late String groupDescription;
  AddNewUserGroupEvent({
    required this.userId,
    required this.businessId,
    required this.groupName,
    required this.groupMobile,
    required this.groupDescription,
  });
}

class UpdateUserGroupEvent extends UserGroupEvent {
  late final String groupId;
  late final String userId;
  late final String businessId;
  late String groupName;
  late String groupMobile;
  late String groupDescription;
  UpdateUserGroupEvent({
    required this.groupId,
    required this.userId,
    required this.businessId,
    required this.groupName,
    required this.groupMobile,
    required this.groupDescription,
  });
}

class UserGroupDeleteEvent extends UserGroupEvent {
  late final String groupId;
  late final String userId;
  late final String businessId;
  UserGroupDeleteEvent({
    required this.groupId,
    required this.userId,
    required this.businessId,
  });
}
