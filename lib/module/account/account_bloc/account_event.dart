class AccountEvent {}

class UserAccountFetchEvent extends AccountEvent {
  late final String userId;

  UserAccountFetchEvent({required this.userId});
}
