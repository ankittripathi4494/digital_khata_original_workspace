// ignore_for_file: must_be_immutable, use_build_context_synchronously, avoid_print
import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/global_widget/essential_widgets_collection.dart';
import 'package:dkapp/module/business_type/business_type_bloc/business_type_bloc.dart';
import 'package:dkapp/module/business_type/business_type_bloc/business_type_event.dart';
import 'package:dkapp/module/business_type/business_type_bloc/business_type_state.dart';
import 'package:dkapp/module/business_type/model/business_type_list_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessTypeScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  BusinessTypeScreen({super.key, required this.argus});

  @override
  State<BusinessTypeScreen> createState() => _BusinessTypeScreenState();
}

class _BusinessTypeScreenState extends State<BusinessTypeScreen> {
  late String userId;
  List<String> choices = [];
  Map<int, bool> selectedItem = {};

  TextEditingController searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();

    fetchBusinessTypes();
  }

  fetchBusinessTypes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userid")!;
    });

// order
    if ((widget.argus.containsKey('selectedData')) &&
        (!widget.argus.containsKey('choices'))) {
      print(widget.argus['selectedData']);
      BlocProvider.of<BusinessTypeBloc>(context)
          .add(BusinessTypeListSelectedFilterEvent(
        userId: prefs.getString("userid")!,
        searchText: searchTextController.text,
        selectedDataList: List<BusinessTypeListResponseData>.from(
            widget.argus['selectedData']),
        choiceList: [],
      ));
    } else if ((!widget.argus.containsKey('selectedData')) &&
        (widget.argus.containsKey('choices'))) {
      print(widget.argus['choices']);
      BlocProvider.of<BusinessTypeBloc>(context)
          .add(BusinessTypeListSelectedFilterEvent(
        userId: prefs.getString("userid")!,
        searchText: searchTextController.text,
        selectedDataList: [],
        choiceList: List<String>.from(widget.argus['choices']),
      ));
    } else if ((widget.argus.containsKey('selectedData')) &&
        (widget.argus.containsKey('choices'))) {
      print(widget.argus['choices']);

      BlocProvider.of<BusinessTypeBloc>(context)
          .add(BusinessTypeListSelectedFilterEvent(
        userId: prefs.getString("userid")!,
        searchText: searchTextController.text,
        selectedDataList: List<BusinessTypeListResponseData>.from(
            widget.argus['selectedData']),
        choiceList: List<String>.from(widget.argus['choices']),
      ));
    } else {
      BlocProvider.of<BusinessTypeBloc>(context).add(BusinessTypeListEvent(
        userId: prefs.getString("userid")!,
        searchText: searchTextController.text,
        selectedDataList: [],
        choiceList: [],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Business Type',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        BlocProvider.of<BusinessTypeBloc>(context)
                            .add(BusinessTypeListSelectedFilterEvent(
                          userId: userId,
                          searchText: searchTextController.text,
                          selectedDataList: [],
                          choiceList: [],
                        ));
                      },
                      controller: searchTextController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 31, 1, 102),
                      ),
                      cursorColor: const Color.fromARGB(255, 31, 1, 102),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0.0),
                        hintText: 'Search or add new',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 35,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 31, 1, 102),
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 31, 1, 102),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      if (searchTextController.text.isNotEmpty) {
                        BlocProvider.of<BusinessTypeBloc>(context)
                            .add(BusinessTypeAddChoicesEvent(
                          choiceName: searchTextController.text,
                        ));
                        setState(() {
                          searchTextController.text = '';
                        });
                      } else {
                        EssentialWidgetsCollection.showErrorSnackbar(context,
                            "Please enter some data in search field to add data");
                      }
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 31, 1, 102),
                      // margin:
                      //     EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      // decoration: BoxDecoration(color: Colors.blue),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<BusinessTypeBloc, BusinessTypeState>(
              builder: (context, state) {
                if (state is BusinessTypeListLoadedState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: state.choicesList!
                            .map((chip) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Chip(
                                    label: Text(chip),
                                    onDeleted: () {
                                      BlocProvider.of<BusinessTypeBloc>(context)
                                          .add(BusinessTypeRemoveChoicesEvent(
                                        choiceName: chip,
                                      ));
                                    },
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            BlocBuilder<BusinessTypeBloc, BusinessTypeState>(
              builder: (context, state) {
                if (state is BusinessTypeListLoadedState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.businessTypeList?.length,
                    itemBuilder: (context, index) {
                      BusinessTypeListResponseData data =
                          state.businessTypeList![index];

                      return CheckboxListTile(
                        value: (data.isChecked == true) ? true : false,
                        onChanged: (value) {
                          BlocProvider.of<BusinessTypeBloc>(context)
                              .add(ToggleBusinessTypeSelection(index: index));
                        },
                        title: Text(
                          data.name!,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 18),
                        ),
                      );
                    },
                  );
                }
                if (state is BusinessTypeListFailedState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.no_accounts,
                        size: 60,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(state.failedMessage),
                    ],
                  );
                }
                if (state is BusinessTypeListLoadingState) {
                  return const Center(child: AnimatedImageLoader());
                }
                return const Center(
                  child: AnimatedImageLoader(),
                );
              },
            ),
            BlocBuilder<BusinessTypeBloc, BusinessTypeState>(
              builder: (context, state) {
                if (state is BusinessTypeListLoadedState) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 40.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minimumSize: const Size(380, 60),
                        backgroundColor: const Color.fromARGB(255, 31, 1, 102),
                      ),
                      onPressed: () {
                        Map<String, dynamic> selectedStringData = {};
                        selectedStringData['selectedData'] =
                            state.businessTypeList;
                        selectedStringData['choices'] = state.choicesList;
                        Navigator.pop(context, selectedStringData);
                      },
                      child: const Text(
                        'SAVE',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
