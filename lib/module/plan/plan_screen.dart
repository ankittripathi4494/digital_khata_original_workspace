// ignore_for_file: must_be_immutable

import 'package:dkapp/global_widget/animated_loading_placeholder_widget.dart';
import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/plan/model/plan_list_response_model.dart';
import 'package:dkapp/module/plan/plan_bloc/plan_bloc.dart';
import 'package:dkapp/module/plan/plan_bloc/plan_event.dart';
import 'package:dkapp/module/plan/plan_bloc/plan_state.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlanScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  PlanScreen({super.key, required this.argus});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RefreshController refreshController2 =
      RefreshController(initialRefresh: false);
  RefreshController refreshController3 =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Plans',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: BlocBuilder<PlanBloc, PlanState>(
          bloc: PlanBloc()
            ..add(PlanListFetchEvent(
                businessId: (widget.argus['selectedBusiness']
                        as BusinessListResponseData)
                    .id!,
                customerId: (widget.argus['customerData']
                        as SelectedCustomerResponseData)
                    .id!,
                userId: sph.getString("userid")!)),
          builder: (context, state) {
            if (state is PlanListLoadedState) {
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: const WaterDropHeader(
                  waterDropColor: Color.fromARGB(255, 31, 1, 102),
                  idleIcon: AnimatedImagePlaceholderLoader(),
                ),
                controller: refreshController3,
                onRefresh: (() async {
                  // monitor network fetch
                  await Future.delayed(const Duration(milliseconds: 1000));
                  // if failed,use refreshFailed()

                  Navigator.pushReplacementNamed(context, '/plan',
                      arguments: widget.argus);
                }),
                onLoading: (() async {
                  await Future.delayed(const Duration(milliseconds: 1000));
                  // if failed,use loadFailed(),if no data return,use LoadNodata()

                  if (mounted) setState(() {});
                  refreshController3.loadComplete();
                }),
                child: ListView.builder(
                  itemCount: state.successData!.length,
                  itemBuilder: (context, index) {
                    PlanListResponseData planData = state.successData![index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                          vertical: screenSize.height * 0.02),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 203, 202, 202),
                                blurRadius: 6.0,
                                offset: Offset(0.0, 0.1))
                          ]),
                      child: ListTile(
                        onTap: () {},
                        title: Text(planData.title!),
                        subtitle: Text(planData.amount!),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.black, size: 15),
                      ),
                    );
                  },
                ),
              );
            }
            if (state is PlanListFailedState) {
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: const WaterDropHeader(
                  waterDropColor: Color.fromARGB(255, 31, 1, 102),
                  idleIcon: AnimatedImagePlaceholderLoader(),
                ),
                controller: refreshController2,
                onRefresh: (() async {
                  // monitor network fetch
                  await Future.delayed(const Duration(milliseconds: 1000));
                  // if failed,use refreshFailed()

                  Navigator.pushReplacementNamed(context, '/plan',
                      arguments: widget.argus);
                }),
                onLoading: (() async {
                  await Future.delayed(const Duration(milliseconds: 1000));
                  // if failed,use loadFailed(),if no data return,use LoadNodata()

                  if (mounted) setState(() {});
                  refreshController2.loadComplete();
                }),
                child: Center(
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
                        "No Plans to Show",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 1.2,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      const Text(
                        "Add your transactions to see overdue amount and send remainders",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: const WaterDropHeader(
                waterDropColor: Color.fromARGB(255, 31, 1, 102),
                idleIcon: AnimatedImagePlaceholderLoader(),
              ),
              controller: refreshController3,
              onRefresh: (() async {
                // monitor network fetch
                await Future.delayed(const Duration(milliseconds: 1000));
                // if failed,use refreshFailed()

                Navigator.pushReplacementNamed(context, '/plan',
                    arguments: widget.argus);
              }),
              onLoading: (() async {
                await Future.delayed(const Duration(milliseconds: 1000));
                // if failed,use loadFailed(),if no data return,use LoadNodata()

                if (mounted) setState(() {});
                refreshController3.loadComplete();
              }),
              child: const Center(
                child: AnimatedImageLoader(),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 31, 1, 102),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        onPressed: () {
          Navigator.pushNamed(context, '/new-transaction-plan');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
