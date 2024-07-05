// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

class TransactionsEvent {}

class AddCashInTransactionEvent extends TransactionsEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String transactionType;
  late final String transactionAmount;
  late final String transactionNotes;
  late final XFile? transactionImages;
  AddCashInTransactionEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.transactionType,
    required this.transactionAmount,
    required this.transactionNotes,
    required this.transactionImages,
  });
}

class AddCashOutTransactionEvent extends TransactionsEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String transactionType;
  late final String transactionAmount;
  late final String transactionNotes;
  late final XFile? transactionImages;
  AddCashOutTransactionEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.transactionType,
    required this.transactionAmount,
    required this.transactionNotes,
    required this.transactionImages,
  });
}
