// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

class TransactionsEvent {}

class AddCashTransactionEvent extends TransactionsEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String transactionType;
  late final String transactionAmount;
  late final String transactionNotes;
  late final XFile? transactionImages;
  late final bool samePageRedirection;
  AddCashTransactionEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.transactionType,
    required this.transactionAmount,
    required this.transactionNotes,
    required this.transactionImages,
    required this.samePageRedirection,
  });
}

class UpdateCashTransactionEvent extends TransactionsEvent {
  late final String transactionId;
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String transactionNotes;
  late final XFile? transactionImages;
  UpdateCashTransactionEvent({
    required this.transactionId,
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.transactionNotes,
    this.transactionImages,
  });
}

class TransactionListFetchEvent extends TransactionsEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  TransactionListFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}
