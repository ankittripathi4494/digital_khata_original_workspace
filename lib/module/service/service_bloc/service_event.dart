// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

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

//! Service Events
class ServiceListFetchEvent extends ServiceEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  ServiceListFetchEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
  });
}

class AddServiceEvent extends ServiceEvent {
  late final String customerId;
  late final String userId;
  late final String businessId;
  late final String productName;
  late final String productModifiersIds;
  late final String productDiscountIds;
  late final String productTaxIds;
  late final String productDescription;
  late final List<String> productArray;
  late final List<XFile>? productImages;
  AddServiceEvent({
    required this.customerId,
    required this.userId,
    required this.businessId,
    required this.productName,
    required this.productModifiersIds,
    required this.productDiscountIds,
    required this.productTaxIds,
    required this.productDescription,
    required this.productArray,
    this.productImages,
  });
}
