// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../model/business_list_response_model.dart';

class BusinessEvent {}

class BusinessListFetchEvent extends BusinessEvent {
  late final String userId;

  BusinessListFetchEvent({required this.userId});
}

class AddNewBusinessTextChangedEvent extends BusinessEvent {

  late String businessName;
  late String businessType;
  late String businessAddress;
  late String businessEmail;
  late String businessWebsite;
  late String businessTaxNumber;
  AddNewBusinessTextChangedEvent({
    required this.businessName,
    required this.businessType,
    required this.businessAddress,
    required this.businessEmail,
    required this.businessWebsite,
    required this.businessTaxNumber,
  });
}

class AddNewBusinessEvent extends BusinessEvent {
  late String userId;
  late String businessName;
  late String businessType;
  late String businessAddress;
  late String businessEmail;
  late String businessWebsite;
  late String businessTaxNumber;
  AddNewBusinessEvent({
    required this.userId,
    required this.businessName,
    required this.businessType,
    required this.businessAddress,
    required this.businessEmail,
    required this.businessWebsite,
    required this.businessTaxNumber,
  });
}

class SelectBusinessEvent extends BusinessEvent {
  late BusinessListResponseData businessData;
  late final String userId;
  SelectBusinessEvent({
    required this.businessData,
    required this.userId,
  });
}

class FetchSelectedBusinessEvent extends BusinessEvent {}


class SelectedBusinessDeleteEvent extends BusinessEvent {
 
  late final String userId;
  late final String businessId;
  SelectedBusinessDeleteEvent({

    required this.userId,
    required this.businessId,
  });
}