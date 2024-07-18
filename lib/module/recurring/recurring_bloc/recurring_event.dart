// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

class RecurringEvent {}

class AddRecurringTransactionEvent extends RecurringEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String planTitle;
  late final String planAmount;
  late final String planNotes;
  late final String planType;
  late final String noOfEmis;
  late final String planStartDate;
  late final String planEndDate;
  late final XFile? recurringTransactionImages;
  AddRecurringTransactionEvent(
      {required this.customerId,
      required this.userId,
      required this.businessId,
      required this.planTitle,
      required this.planAmount,
      required this.planNotes,
      required this.planType,
      required this.noOfEmis,
      required this.planStartDate,
      required this.planEndDate,
      this.recurringTransactionImages});
}

class RecurringTransactionListFetchEvent extends RecurringEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  RecurringTransactionListFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}

class RecurringTransactionDetailFetchEvent extends RecurringEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String recurringEmiId;
  RecurringTransactionDetailFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.recurringEmiId,
  });
}
