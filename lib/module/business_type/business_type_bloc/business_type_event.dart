// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dkapp/module/business_type/model/business_type_list_response_model.dart';

class BusinessTypeEvent {}

//! Business Type List Selected Filter Event

class BusinessTypeListSelectedFilterEvent extends BusinessTypeEvent {
  late final String userId;
  late final String searchText;
  late final List<BusinessTypeListResponseData> selectedDataList;
  late final List<String> choiceList;
  BusinessTypeListSelectedFilterEvent({
    required this.userId,
    required this.searchText,
    required this.selectedDataList,
    required this.choiceList,
  });
}

class BusinessTypeListEvent extends BusinessTypeEvent {
  late final String userId;
  late final String searchText;
  late final List<BusinessTypeListResponseData> selectedDataList;
  late final List<String> choiceList;
  BusinessTypeListEvent({
    required this.userId,
    required this.searchText,
    required this.selectedDataList,
    required this.choiceList,
  });
}

class BusinessTypeAddChoicesEvent extends BusinessTypeEvent {
  late final String choiceName;
  BusinessTypeAddChoicesEvent({
    required this.choiceName,
  });
}

class BusinessTypeRemoveChoicesEvent extends BusinessTypeEvent {
  late final String choiceName;
  BusinessTypeRemoveChoicesEvent({
    required this.choiceName,
  });
}

class ToggleBusinessTypeSelection extends BusinessTypeEvent {
  late final int index;
  ToggleBusinessTypeSelection({
    required this.index,
  });
}
