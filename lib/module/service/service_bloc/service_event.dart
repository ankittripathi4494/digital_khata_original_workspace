// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServiceEvent {}

class ServiceCategoryListFetchEvent extends ServiceEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  ServiceCategoryListFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}

class AddServiceCategoryEvent extends ServiceEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String serviceCategoryName;
  AddServiceCategoryEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.serviceCategoryName,
  });
}
