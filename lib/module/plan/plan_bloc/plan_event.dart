// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

class PlanEvent {}

class AddPlanEvent extends PlanEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String planTitle;
  late final String planAmount;
  late final String planNotes;
  late final String planType;
  late final String noOfEmis;
  late final XFile? planImages;
  AddPlanEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.planTitle,
    required this.planAmount,
    required this.planNotes,
    required this.planType,
    required this.noOfEmis,
    this.planImages,
  });
}

class PlanListFetchEvent extends PlanEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  PlanListFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}

class PlanDetailFetchEvent extends PlanEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String loanPlanId;
  PlanDetailFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.loanPlanId,
  });
 
}
