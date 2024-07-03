// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:image_picker/image_picker.dart';

import '../../edit_profile/model/country_response_model.dart';
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

class UpdateBusinessTextChangedEvent extends BusinessEvent {
  late String businessName;
  late String businessContactNumber;
  late CountryResponseData? businessCountry;
  late String businessType;
  late String businessAddress;
  late String businessEmail;
  late String businessWebsite;
  late String businessTaxNumber;
  UpdateBusinessTextChangedEvent({
    required this.businessName,
    required this.businessContactNumber,
    required this.businessCountry,
    required this.businessType,
    required this.businessAddress,
    required this.businessEmail,
    required this.businessWebsite,
    required this.businessTaxNumber,
  });
}

class UpdateBusinessEvent extends BusinessEvent {
  late String userId;
  late String businessId;
  late String businessName;
  late String businessContactNumber;
  late CountryResponseData businessCountry;
  late XFile? businessImage;
  late String businessImageName;
  late String businessType;
  late String businessAddress;
  late String businessEmail;
  late String businessWebsite;
  late String businessTaxNumber;
  UpdateBusinessEvent({
    required this.userId,
    required this.businessId,
    required this.businessName,
    required this.businessContactNumber,
    required this.businessCountry,
    required this.businessImage,
    required this.businessImageName,
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

class FetchSelectedBusinessEvent extends BusinessEvent {
  late final String userId;
  FetchSelectedBusinessEvent({
    required this.userId,
  });
}

class SelectedBusinessDeleteEvent extends BusinessEvent {
  late final String userId;
  late final String businessId;
  SelectedBusinessDeleteEvent({
    required this.userId,
    required this.businessId,
  });
}
