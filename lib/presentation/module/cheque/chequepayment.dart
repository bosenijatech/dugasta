import 'dart:convert';
import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/presentation/model/receiptmodel.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/calendarpopview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChequePaymentPage extends StatefulWidget {
  const ChequePaymentPage({super.key});

  @override
  State<ChequePaymentPage> createState() => _ChequePaymentPageState();
}

class _ChequePaymentPageState extends State<ChequePaymentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = [
    Tab(text: 'ALL'),
    Tab(text: 'PDC'),
  ];
  final _unselectedColor = Color(0xff5f6368);

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 2));
  //ChequeModel chequeModel = ChequeModel();
  List<Receipt> receipts = [];
  TextEditingController datecontroller = TextEditingController();
  bool loading = false;
  bool holddate = false;
  TextEditingController memocontroller = TextEditingController();
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    viewchequelist();
    super.initState();
  }

  @override
  void dispose() {
    memocontroller.dispose();
    datecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Payment Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: !loading
          ? Column(
              children: [
                // Container(
                //   margin: EdgeInsets.all(5),
                //   height: kToolbarHeight - 16.0,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(8.0),
                //   ),
                //   child: TabBar.secondary(
                //       labelColor: Colors.white,
                //       unselectedLabelColor: Colors.grey,
                //       controller: _tabController,
                //       indicatorColor: AppColor.primary,
                //       indicator: BoxDecoration(
                //         borderRadius: BorderRadius.circular(
                //           10.0,
                //         ),
                //         color: AppColor.primary,
                //       ),
                //       tabs: _tabs,
                //       onTap: (var index) {
                //         if (index == 0) {
                //           viewchequelist();
                //         } else {
                //           pdconly();
                //         }
                //       }),
                // ),

                Container(
  margin: const EdgeInsets.all(8),
  height: kToolbarHeight - 10.0,
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  child: TabBar(
    controller: _tabController,
    tabs: _tabs,
    onTap: (index) {
      if (index == 0) {
        viewchequelist();
      } else {
        pdconly();
      }
    },
    labelStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    labelColor: Colors.white,
    unselectedLabelColor: Colors.black54,
  
       dividerColor:  Colors.transparent,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        colors: [
          AppColor.primary,
          AppColor.primary.withOpacity(0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColor.primary.withOpacity(0.4),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    indicatorSize: TabBarIndicatorSize.tab,
  ),
)
,
SizedBox(height: 10,),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            //getTimeDateUI(),
                            receipts.isNotEmpty
                                ? getticketdetailsview()
                                : Center(
                                    child: Text('No DATA!'),
                                  ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            receipts.isNotEmpty
                                ? getticketdetailsview()
                                : Center(
                                    child: Text('No DATA!'),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget getTimeDateUI() {
    return ExpansionTile(
      shape: RoundedRectangleBorder(side: BorderSide.none),
      title: Text('Filters'),
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Row(
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.grey.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            // setState(() {
                            //   isDatePopupOpen = true;
                            // });
                            showDemoDialog(context: context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 4, bottom: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Choose date',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            foregroundColor: WidgetStateProperty.all<Color>(
                                AppColor.primaryColor),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        side: BorderSide(
                                            color: AppColor.primaryColor)))),
                        onPressed: () {},
                        child: Text("Clear".toUpperCase(),
                            style: TextStyle(fontSize: 14)))),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    print('save');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    backgroundColor: AppColor.primary,
                    // background
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text("Submit"),
                ))
              ],
            )
          ],
        )
      ],
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }

  Widget getticketdetailsview() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
        child: ListView.builder(
            itemCount: receipts.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                elevation: 1,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    showTrailingIcon: false,
                    dense: true,
                    title: Text(
                      'Receipt ID # ${receipts[index].receiptId.toString()}',
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        AppUtils.buildNormalText(
                            text:
                                'Contract No # ${receipts[index].contractId.toString()}'),
                        SizedBox(
                          height: 5,
                        ),
                        AppUtils.buildNormalText(
                            text:
                                'Contract Name # ${receipts[index].contractName.toString()}'),
                        SizedBox(
                          height: 5,
                        ),
                        AppUtils.buildNormalText(
                            text:
                                'Building Name # ${receipts[index].building.toString()}'),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppUtils.buildNormalText(
                                text:
                                    'Unit # ${receipts[index].unitNo.toString()}'),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColor.primary,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    children: [buildDataLayout(index)],
                  ),
                ),
              );
            }));
  }

  Widget buildDataLayout(indx) {
    return receipts[indx].details.isNotEmpty
        ? ListView.builder(
            itemCount: receipts[indx].details.length ?? 0,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppUtils.buildNormalText(
                                  text: "Cheque Date",
                                  fontSize: 12,
                                  color: Colors.grey.shade600),
                              const SizedBox(height: 5),
                              AppUtils.buildNormalText(
                                  text: receipts[indx]
                                      .details[index]
                                      .chequeDate
                                      .toString(),
                                  fontSize: 14,
                                  color: Colors.black),
                              const SizedBox(
                                height: 15,
                              ),
                              AppUtils.buildNormalText(
                                  text: "Cheque Type",
                                  fontSize: 12,
                                  color: Colors.grey.shade600),
                              const SizedBox(height: 5),
                              AppUtils.buildNormalText(
                                  text: receipts[indx]
                                      .details[index]
                                      .payMode
                                      .toString(),
                                  fontSize: 14,
                                  color: Colors.black),
                              const SizedBox(
                                height: 15,
                              ),
                              AppUtils.buildNormalText(
                                  text: "Ref No",
                                  fontSize: 12,
                                  color: Colors.grey.shade600),
                              const SizedBox(height: 5),
                              AppUtils.buildNormalText(
                                  text: receipts[indx]
                                      .details[index]
                                      .refNo
                                      .toString(),
                                  fontSize: 14,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppUtils.buildNormalText(
                                    text: "Receipt Date",
                                    fontSize: 12,
                                    color: Colors.grey.shade600),
                                const SizedBox(height: 5),
                                AppUtils.buildNormalText(
                                    text: receipts[indx]
                                        .details[index]
                                        .receiptDate
                                        .toString(),
                                    fontSize: 14,
                                    color: Colors.black),
                                const SizedBox(
                                  height: 15,
                                ),
                                AppUtils.buildNormalText(
                                    text: "Amount",
                                    fontSize: 12,
                                    color: Colors.grey.shade600),
                                const SizedBox(height: 5),
                                AppUtils.buildNormalText(
                                    text: receipts[indx]
                                                .details[index]
                                                .paymentAmount
                                                .toString() !=
                                            "null"
                                        ? receipts[indx]
                                            .details[index]
                                            .paymentAmount
                                            .toStringAsFixed(2)
                                        : "0.00",
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                const SizedBox(
                                  height: 15,
                                ),
                                AppUtils.buildNormalText(
                                    text: "Cheque Status",
                                    fontSize: 12,
                                    color: Colors.grey.shade600),
                                const SizedBox(height: 5),
                                AppUtils.buildNormalText(
                                    text: receipts[indx]
                                        .details[index]
                                        .chequeStatus
                                        .toString(),
                                    fontSize: 14,
                                    color: Colors.black),
                              ],
                            )),
                      ],
                    ),
                  ),
                 if (index != receipts[indx].details.length - 1)
                  const Divider(height: 1),
                ],
              );
            })
        : Container(
            child: Center(child: Text('No Data Found!!')),
          );
  }

  convertdateformat(datetime) {
    //return DateFormat("dd-mm-yyyy").format(datetime);

    // String formattedDate = DateFormat('yyyy-MM-dd').format(datetime);

    return DateFormat("dd-MM-yyyy").format(DateTime.parse(datetime));
  }

  pdconly() async {
    setState(() {
      loading = true;
    });
    Apiservice.getpdcchequelist().then((response) {
      setState(() {
        loading = false;
      });

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          receipts.clear();
          final data =
              jsonDecode(response.body); // response.body is your JSON string
          receipts = (data['message'] as List)
              .map((json) => Receipt.fromJson(json))
              .toList();
        } else {
          receipts.clear();
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", exitpopup);
        }
        //return response;
      } else {
        throw Exception(jsonDecode(response.body)['message'].toString());
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
    });
  }

  void viewchequelist() async {
    setState(() {
      loading = true;
    });
    Apiservice.getchequelist().then((response) {
      setState(() {
        loading = false;
      });

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          receipts.clear();
          final data =
              jsonDecode(response.body); // response.body is your JSON string
          receipts = (data['message'] as List)
              .map((json) => Receipt.fromJson(json))
              .toList();
        } else {
          receipts.clear();
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", exitpopup);
        }
        //return response;
      } else {
        throw Exception(jsonDecode(response.body)['message'].toString());
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
    });
  }

  void exitpopup() {
    AppUtils.pop(context);
  }
}
