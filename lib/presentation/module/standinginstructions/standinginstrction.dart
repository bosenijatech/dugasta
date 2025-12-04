import 'package:dugasta/presentation/module/servicerequest/servicerequest.dart';
import 'package:dugasta/presentation/module/servicerequest/ticketdetailsview.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/calendarpopview.dart';
import 'package:dugasta/presentation/util/customtwobutton.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StandingInstructionPage extends StatefulWidget {
  const StandingInstructionPage({super.key});

  @override
  State<StandingInstructionPage> createState() =>
      _StandingInstructionPageState();
}

class _StandingInstructionPageState extends State<StandingInstructionPage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text('Standing Instructions',
            style: TextStyle(color: Colors.white)),
      ),
      body: !loading
          ? SingleChildScrollView(
              child: Column(
                children: [getTimeDateUI(), getticketdetailsview()],
              ),
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
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
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
                              children: [
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
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 4, bottom: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Filter',
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: DropdownSearch())
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    callme();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
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

  callme() async {
    setState(() {
      loading = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
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
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {},
                child: Container(
                    margin: EdgeInsets.only(top: 24),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.greyShade3, width: 1),
                    ),
                    child: Column(
                      children: [
                        // Header
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColor.greyShade1,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          // Content
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text('Contract # 00000008930',
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Icon(CupertinoIcons.pencil_circle_fill),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppUtils.buildNormalText(text: "Sub ID"),
                                  AppUtils.buildNormalText(text: "991009292329")
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  AppUtils.buildNormalText(
                                      text: "CC Ending with : 2524"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppUtils.buildNormalText(
                                      text: "Status Schedule"),
                                  AppUtils.buildNormalText(text: "25/02/2024")
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppUtils.buildNormalText(
                                      text: "Installment #10"),
                                  AppUtils.buildNormalText(text: "3666.00"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(),

                        Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppUtils.buildNormalText(
                                      text: "Status Schedule"),
                                  AppUtils.buildNormalText(text: "25/02/2024")
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppUtils.buildNormalText(
                                      text: "Installment #11"),
                                  AppUtils.buildNormalText(text: "3666.00"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )));
          }),
    );
  }
}
