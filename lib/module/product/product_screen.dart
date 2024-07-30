// ignore_for_file: must_be_immutable

import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/product/model/product_list_response_model.dart';
import 'package:dkapp/module/product/product_bloc/product_bloc.dart';
import 'package:dkapp/module/product/product_bloc/product_event.dart';
import 'package:dkapp/module/product/product_bloc/product_state.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  ProductScreen({super.key, required this.argus});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late SharedPreferencesHelper sph;
  late ProductBloc productBloc;
  RefreshController refreshForProductController =
      RefreshController(initialRefresh: false);
  RefreshController refreshForProductController2 =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    sph = SharedPreferencesHelper();

    // productBloc = ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Products',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 23),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  query: '',
                  delegate: SearchBarDelegate(),
                );
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ))
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: ProductBloc()
          ..add(
            ProductListFetchEvent(
              customerId:
                  (widget.argus['customerData'] as SelectedCustomerResponseData)
                      .id!,
              userId: sph.getString("userid")!,
              businessId:
                  (widget.argus['selectedBusiness'] as BusinessListResponseData)
                      .id!,
            ),
          ),
        builder: (context, state) {
          if (state is ProductListLoadedState) {
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropHeader(
                waterDropColor: const Color.fromARGB(255, 31, 1, 102),
                idleIcon: AnimatedImageLoader(
                  indicatorType: Indicator.ballClipRotate,
                  loaderType: LoaderType.refresher,
                ),
              ),
              controller: refreshForProductController,
              onRefresh: (() async {
                // monitor network fetch
                await Future.delayed(const Duration(milliseconds: 1000));
                // if failed,use refreshFailed()

                Navigator.pushReplacementNamed(context, '/product',
                    arguments: widget.argus);
              }),
              onLoading: (() async {
                await Future.delayed(const Duration(milliseconds: 1000));
                // if failed,use loadFailed(),if no data return,use LoadNodata()

                if (mounted) setState(() {});
                refreshForProductController.loadComplete();
              }),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.successData!.length,
                itemBuilder: (context, index) {
                  ProductListResponseData plrd = state.successData![index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01,
                        horizontal: screenSize.width * 0.02),
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 203, 202, 202),
                              blurRadius: 6.0,
                              offset: Offset(0.0, 0.1))
                        ],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/product-detail');
                      },
                      child: ListTile(
                        leading: Container(
                          // margin: EdgeInsets.symmetric(
                          //     vertical: screenSize.height * 0.001,
                          //     horizontal: screenSize.width * 0.01),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            plrd.productName![0],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                        ),
                        title: Text(
                          plrd.productName!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Text(
                          '${plrd.itemCount ?? 0} Prices',
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          if (state is ProductListLoadingState) {
            return Center(
              child: AnimatedImageLoader(),
            );
          }
          if (state is ProductListFailedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                "resources/images/empty-folder.png"))),
                  ),
                  const Text(
                    "No Products to Show",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 1.2,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: AnimatedImageLoader(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          backgroundColor: const Color.fromARGB(255, 31, 1, 102),
          onPressed: () {
            Navigator.pushNamed(context, '/create-product', arguments: {
              'customerData': (widget.argus['customerData']
                  as SelectedCustomerResponseData),
              'selectedBusiness': (widget.argus['selectedBusiness']
                  as BusinessListResponseData),
              "updatePlan": true,
              'fromCustomerScreen':
                  (widget.argus.containsKey('fromCustomerScreen'))
                      ? true
                      : false
            });
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          )),
    );
  }
}

class SearchBarDelegate extends SearchDelegate {
  final TextEditingController searchController;

  SearchBarDelegate() : searchController = TextEditingController();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          searchController.clear();

          query = 'Search';
        },
      ),
    ];
  }

// actionsIconTheme: theme.actionIconTheme.copyWith()
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      primaryColor: Colors.white,
      appBarTheme: theme.appBarTheme.copyWith(
          color: Colors.blue,
          elevation: 5,
          titleTextStyle: const TextStyle(color: Colors.white)),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white, selectionColor: Colors.white),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      ),
      // textTheme: theme.textTheme
      //     .copyWith(bodyLarge: const TextStyle(color: Colors.white)
      // )
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
