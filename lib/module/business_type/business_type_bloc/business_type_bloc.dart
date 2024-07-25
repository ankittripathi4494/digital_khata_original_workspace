// ignore_for_file: avoid_print

import 'package:dkapp/module/business_type/business_type_bloc/business_type_event.dart';
import 'package:dkapp/module/business_type/business_type_bloc/business_type_state.dart';
import 'package:dkapp/module/business_type/model/business_type_list_response_model.dart';
import 'package:dkapp/utils/api_list.dart';
import 'package:dkapp/utils/logger_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class BusinessTypeBloc extends Bloc<BusinessTypeEvent, BusinessTypeState> {
  List<BusinessTypeListResponseData> businessTypeList = [];
  List<BusinessTypeListResponseData> businessTypeListTemp = [];
  List<String> choicesList = [];
  List<String> choicesListTemp = [];
  BusinessTypeBloc() : super(BusinessTypeInitial()) {
    on<BusinessTypeListEvent>((event, emit) async {
      // emit(BusinessTypeListLoadingState());
      var map = {};

      try {
        map['token'] = 'bnbuujn';
        map['search'] = event.searchText;
        LoggerUtil().infoData(map.toString());

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getBusinessType),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          BusinessTypeListResponseModel jsonResponse =
              BusinessTypeListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.response.toString());
            }
            businessTypeList = jsonResponse.data!;
            emit(BusinessTypeListLoadedState(
                businessTypeList: businessTypeList, choicesList: choicesList));
          } else {
            emit(BusinessTypeListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(BusinessTypeListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(BusinessTypeListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<BusinessTypeListSelectedFilterEvent>((event, emit) async {
      businessTypeListTemp.clear();
      // emit(BusinessTypeListLoadingState());
      var map = {};

      try {
        map['token'] = 'bnbuujn';
        map['search'] = event.searchText;
        LoggerUtil().infoData(map);

        http.Response response = await http.post(
            Uri.http(APIPathList.mainDomain, APIPathList.getBusinessType),
            body: map,
            headers: {
              "HTTP_AUTHORIZATION": '${DateTime.now().millisecondsSinceEpoch}',
            });
        LoggerUtil().infoData(response.body);
        if (response.statusCode == 200) {
          BusinessTypeListResponseModel jsonResponse =
              BusinessTypeListResponseModel.fromJson(
                  convert.jsonDecode(response.body));

          if (jsonResponse.response != "failure") {
            if (kDebugMode) {
              LoggerUtil().infoData(jsonResponse.response.toString());
            }
            businessTypeList = jsonResponse.data!;

            if (event.choiceAndType.isNotEmpty) {
              LoggerUtil().infoData(
                  "Choices and Types Combo:= ${event.choiceAndType.toString()}");

              List<String> splitListdata = event.choiceAndType.split(',');
              List<BusinessTypeListResponseData> typeListData = businessTypeList
                  .map((c) => BusinessTypeListResponseData(
                      id: c.id, name: c.name, isChecked: true))
                  .toList();
              LoggerUtil().infoData("List Data:- ${splitListdata.toString()}");
              LoggerUtil().infoData("Type List :- ${typeListData.toString()}");
              for (String spl in splitListdata) {
                if ((typeListData
                        .map((d) => d.name!.toLowerCase().trim())
                        .toList())
                    .contains(spl.toLowerCase().trim())) {
                  LoggerUtil().infoData("spl exist in type List");
                  for (BusinessTypeListResponseData tld in typeListData) {
                    if (tld.name!.toLowerCase().trim() ==
                        spl.toLowerCase().trim()) {
                      LoggerUtil().infoData("added");
                      businessTypeListTemp.add(BusinessTypeListResponseData(
                          id: tld.id, name: tld.name, isChecked: true));
                    } else {
                      LoggerUtil().infoData("skip");
                    }
                  }
                } else {
                  LoggerUtil().infoData("spl exist in choice  List");
                  choicesListTemp.add(spl);
                }
              }
              emit(BusinessTypeListLoadedState(
                  businessTypeList: businessTypeListTemp,
                  choicesList: choicesListTemp));
            } else {
              for (var cl in event.choiceList) {
                LoggerUtil().infoData("Choice:- $cl");
              }
              for (var sdl in event.selectedDataList) {
                LoggerUtil().infoData("Selected Data List:- ${sdl.toJson().toString()}");
              }
              choicesListTemp.addAll(event.choiceList.toSet().toList());
              businessTypeListTemp.addAll(event.selectedDataList);
              emit(BusinessTypeListLoadedState(
                  businessTypeList: businessTypeListTemp,
                  choicesList: choicesListTemp));
            }
          } else {
            emit(BusinessTypeListFailedState(
              failedMessage: jsonResponse.message!,
            ));
          }
        } else {
          emit(BusinessTypeListFailedState(
            failedMessage:
                'Request failed with status: ${response.statusCode}.',
          ));
        }
      } on PlatformException {
        emit(BusinessTypeListFailedState(
          failedMessage: 'Failed to get platform version.',
        ));
      }
    });

    on<BusinessTypeAddChoicesEvent>((event, emit) async {
      // emit(BusinessTypeListLoadingState());
      choicesList.add(event.choiceName);
      emit(BusinessTypeListLoadedState(
          businessTypeList: businessTypeList, choicesList: choicesList));
    });

    on<BusinessTypeRemoveChoicesEvent>((event, emit) async {
      // emit(BusinessTypeListLoadingState());
      choicesList.remove(event.choiceName);
      emit(BusinessTypeListLoadedState(
          businessTypeList: businessTypeList, choicesList: choicesList));
    });

    on<ToggleBusinessTypeSelection>(_onToggleItem);
  }
  void _onToggleItem(
      ToggleBusinessTypeSelection event, Emitter<BusinessTypeState> emit) {
    final currentState = state;
    if (currentState is BusinessTypeListLoadedState) {
      final updatedItems = List<BusinessTypeListResponseData>.from(
          currentState.businessTypeList!.toList());
      updatedItems[event.index].isChecked =
          !updatedItems[event.index].isChecked;
      emit(BusinessTypeListLoadedState(
          businessTypeList: updatedItems,
          choicesList: currentState.choicesList!.toList()));
    }
  }
}
