// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:dkapp/global_widget/animated_loading_widget.dart';
import 'package:dkapp/module/business/model/business_list_response_model.dart';
import 'package:dkapp/module/customers/model/selected_customer_response_model.dart';
import 'package:dkapp/module/recurring/model/loan_recurring_emi_details_response_model.dart';
import 'package:dkapp/module/recurring/model/loan_recurring_emi_list_response_model.dart';
import 'package:dkapp/module/recurring/recurring_bloc/recurring_bloc.dart';
import 'package:dkapp/module/recurring/recurring_bloc/recurring_event.dart';
import 'package:dkapp/module/recurring/recurring_bloc/recurring_state.dart';
import 'package:dkapp/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecurringTransactionDetailsScreen extends StatefulWidget {
  late Map<String, dynamic> argus;
  RecurringTransactionDetailsScreen({
    super.key,
    required this.argus,
  });

  @override
  State<RecurringTransactionDetailsScreen> createState() =>
      _RecurringTransactionDetailsScreenState();
}

class _RecurringTransactionDetailsScreenState
    extends State<RecurringTransactionDetailsScreen> {
  late LoanRecurringEmiListResponseData loanRecurringEmiListResponseData;
  SharedPreferencesHelper sph = SharedPreferencesHelper();
  RefreshController refreshForRecurTransController =
      RefreshController(initialRefresh: false);
  RefreshController refreshForRecurTransController2 =
      RefreshController(initialRefresh: false);
  RefreshController refreshForRecurTransController3 =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    fetchLoanRecurringEmiListResponseData();
    super.initState();
  }

  fetchLoanRecurringEmiListResponseData() {
    setState(() {
      loanRecurringEmiListResponseData =
          (widget.argus['recurEmiData'] as LoanRecurringEmiListResponseData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: ListTile(
          contentPadding: const EdgeInsets.all(0),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            loanRecurringEmiListResponseData.title!,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          subtitle: Text(
            '\u{20B9} ${loanRecurringEmiListResponseData.amount ?? 0}',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
      body: BlocBuilder<RecurringBloc, RecurringState>(
        bloc: RecurringBloc()
          ..add(RecurringTransactionDetailFetchEvent(
              businessId:
                  (widget.argus['selectedBusiness'] as BusinessListResponseData)
                      .id!,
              customerId:
                  (widget.argus['customerData'] as SelectedCustomerResponseData)
                      .id!,
              userId: sph.getString("userid")!,
              recurringEmiId: loanRecurringEmiListResponseData.id!)),
        builder: (context, state) {
          if (state is RecurringTransactionDetailLoadedState) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          child: ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ignore: prefer_const_constructors
                                Text(
                                  "Title",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  state.successData!.title!,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          child: ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ignore: prefer_const_constructors
                                Text(
                                  "Emi Amount",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  state.successData!.amount!,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          child: ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ignore: prefer_const_constructors
                                Text(
                                  "Emi Type",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  state.successData!.emiType!,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          child: ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ignore: prefer_const_constructors
                                Text(
                                  "Total EMIs",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  loanRecurringEmiListResponseData.noOfEmi!,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          child: ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ignore: prefer_const_constructors
                                Text(
                                  "Emi Start Date",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy').format(
                                      DateFormat("dd-MM-yyyy hh:mm:ss").parse(
                                          state.successData!.startDate!)),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          child: ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ignore: prefer_const_constructors
                                Text(
                                  "Emi End Date",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy').format(
                                      DateFormat("dd-MM-yyyy hh:mm:ss")
                                          .parse(state.successData!.endDate!)),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          child: ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ignore: prefer_const_constructors
                                Text(
                                  "Description",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Flexible(
                                  child: Text(
                                    state.successData!.notes!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      child: ListView.builder(
                    itemCount: state.successData!.emiList!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      LoanRecurringEmiDetailResponseEmiList recurEmiData =
                          state.successData!.emiList![index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 203, 202, 202),
                              offset: Offset(0.0, 1.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 0),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: DateFormat('dd-MM-yyyy').format(
                                            DateFormat("dd-MM-yyyy hh:mm:ss")
                                                .parse(recurEmiData.emiDate
                                                    .toString())),
                                        style: const TextStyle(
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500))),
                                RichText(
                                    text: TextSpan(
                                        text: "Month : \t",
                                        children: [
                                          TextSpan(
                                              text: "${recurEmiData.emiMonth}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400))
                                        ],
                                        style: const TextStyle(
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700)))
                              ],
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 50,
                                  padding: const EdgeInsets.all(0),
                                  child: Text(
                                      (int.parse(recurEmiData.status!) <= 0)
                                          ? "Unpaid"
                                          : "Paid",
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                          color: (int.parse(
                                                      recurEmiData.status!) <=
                                                  0)
                                              ? Colors.red
                                              : Colors.green,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold)),
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: "Amount : \t",
                                        children: [
                                          TextSpan(
                                              text: "${recurEmiData.emiAmount}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400))
                                        ],
                                        style: const TextStyle(
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700))),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              ),
            );
          }
          if (state is RecurringTransactionDetailFailedState) {
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
              controller: refreshForRecurTransController2,
              onRefresh: (() async {
                // monitor network fetch
                await Future.delayed(const Duration(milliseconds: 1000));
                // if failed,use refreshFailed()

                Navigator.pushReplacementNamed(
                    context, '/customer-screen-details',
                    arguments: widget.argus);
              }),
              onLoading: (() async {
                await Future.delayed(const Duration(milliseconds: 1000));
                // if failed,use loadFailed(),if no data return,use LoadNodata()

                if (mounted) setState(() {});
                refreshForRecurTransController2.loadComplete();
              }),
              child: Container(
                color: Colors.white,
                height: screenSize.height,
                // width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      // color: Colors.grey,
                      child: Icon(
                        Icons.receipt_long_sharp,
                        size: 100,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                        // color: Colors.grey,
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.1),
                      child: const Text(
                        'You can now automatically enter monthly        or weekly repeating transactions',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                ),
              ),
            );
          }

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
            controller: refreshForRecurTransController3,
            onRefresh: (() async {
              // monitor network fetch
              await Future.delayed(const Duration(milliseconds: 1000));
              // if failed,use refreshFailed()

              Navigator.pushReplacementNamed(
                  context, '/customer-screen-details',
                  arguments: widget.argus);
            }),
            onLoading: (() async {
              await Future.delayed(const Duration(milliseconds: 1000));
              // if failed,use loadFailed(),if no data return,use LoadNodata()

              if (mounted) setState(() {});
              refreshForRecurTransController3.loadComplete();
            }),
            child: Center(
              child: AnimatedImageLoader(),
            ),
          );
        },
      ),
    );
  }
}
