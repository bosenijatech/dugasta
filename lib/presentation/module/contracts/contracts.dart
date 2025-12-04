import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/presentation/model/contractmodel.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/pref.dart';
import '../sales_app/salescontract/salescontract.dart';

class Contractspage extends StatefulWidget {
  const Contractspage({super.key});

  @override
  State<Contractspage> createState() => _ContractspageState();
}

class _ContractspageState extends State<Contractspage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = [
    Tab(text: 'Contracts'),
    // Tab(text: 'Parking'),
  ];
  int count = 0;
  final _unselectedColor = Color(0xff5f6368);
  ContractModel contractModel = ContractModel();
  bool loading = false;
  double totalaccountsummary = 0.00;
  List<ContractModel> allContracts = [];
  List<ContractModel> activeContracts = [];
  List<ContractModel> closedContracts = [];
  List<ContractModel> expiredContracts = [];
  double totalActiveSecurityDeposit = 0;
   bool isLease = Prefs.getRole("customerType").toString() == "Lease";
  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
     isLease = Prefs.getRole("customerType").toString() == "Lease";

  // Only call getContracts if Lease
  if (isLease) {
    getContracts();
  }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          'Contracts',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: !loading
          ? Column(
              children: [
                contractsummary(size),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            activecontracts(),
                            closedcontract(),
                            expiredcontracts(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget summaryCard(String title, String subtitle, String trailing) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(trailing,
                style: const TextStyle(fontSize: 12, color: Colors.orange)),
          ],
        ),
      ),
    );
  }

  Widget contractsummary(size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                // Left colored box
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${allContracts.length}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Text Section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Contract Summary",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Total ${allContracts.length}",
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(width: 10),
          Expanded(
              child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                // Left colored box
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "AED",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Text Section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Security Deposit",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          totalActiveSecurityDeposit.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget activecontracts() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Container(
        margin: EdgeInsets.all(5),
        color: Colors.white,
        child: ExpansionTile(
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.home),
          ),
          title: AppUtils.buildNormalText(
              text: "Active Contracts  ${activeContracts.length}",
              fontSize: 14,
              fontWeight: FontWeight.w500),
          children: [
            activeContracts.isNotEmpty
                ? ListView.builder(
                    itemCount: activeContracts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Contract No # ${activeContracts[index].contractErajno ?? 0}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              activeContracts[index]
                                                  .contractTenantname
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text: "Building",
                                            color: Colors.grey,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text: "Unit",
                                            color: Colors.grey,
                                            fontSize: 12),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text: activeContracts[index]
                                                .contractBuilding
                                                .toString(),
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text: activeContracts[index]
                                                .contractUnitno
                                                .toString(),
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text: "Contract Duration",
                                            color: Colors.grey,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text: "Building Type",
                                            color: Colors.grey,
                                            fontSize: 12),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text: activeContracts[index]
                                                        .contractStartdate
                                                        .toString()
                                                        .isNotEmpty &&
                                                    activeContracts[index]
                                                        .contractEnddate!
                                                        .toString()
                                                        .isNotEmpty
                                                ? "${activeContracts[index].contractStartdate.toString()}-to-${activeContracts[index].contractEnddate!.toString()}"
                                                : "",
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text: activeContracts[index]
                                                    .buildingtype ??
                                                "",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 10,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return Flex(
                                              direction: Axis.horizontal,
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: List.generate(
                                                  (constraints.constrainWidth() /
                                                          10)
                                                      .floor(),
                                                  (index) => SizedBox(
                                                        height: 1,
                                                        width: 5,
                                                        child: DecoratedBox(
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                        ),
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 10,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(10)),
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Rental Amount",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                    RichText(
                                      text: TextSpan(
                                          text: "AED",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                          children: [
                                            WidgetSpan(
                                              child: SizedBox(width: 5),
                                            ),
                                            TextSpan(
                                                text: activeContracts[index]
                                                    .contractRentamount!
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: AppUtils.buildNormalText(
                        text: "No Data!", fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget closedcontract() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Container(
        margin: EdgeInsets.all(5),
        color: Colors.white,
        child: ExpansionTile(
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.home),
          ),
          title: AppUtils.buildNormalText(
              text: "Closed Contracts  ${closedContracts.length}",
              fontSize: 14,
              fontWeight: FontWeight.w500),
          children: [
            closedContracts.isNotEmpty
                ? ListView.builder(
                    itemCount: closedContracts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Contract No # ${closedContracts[index].contractErajno ?? ""}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              closedContracts[index]
                                                  .contractTenantname
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text: "Building",
                                            color: Colors.grey,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text: "Unit",
                                            color: Colors.grey,
                                            fontSize: 12),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text: closedContracts[index]
                                                .contractBuilding
                                                .toString(),
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text: closedContracts[index]
                                                .contractUnitno
                                                .toString(),
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text: "Contract Duration",
                                            color: Colors.grey,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text: "Building Type",
                                            color: Colors.grey,
                                            fontSize: 12),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text:
                                                "${closedContracts[index].contractStartdate.toString()}-to-${closedContracts[index].contractEnddate!.toString()}",
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text: closedContracts[index]
                                                    .buildingtype ??
                                                "",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 10,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return Flex(
                                              direction: Axis.horizontal,
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: List.generate(
                                                  (constraints.constrainWidth() /
                                                          10)
                                                      .floor(),
                                                  (index) => SizedBox(
                                                        height: 1,
                                                        width: 5,
                                                        child: DecoratedBox(
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                        ),
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 10,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(10)),
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Rental Amount",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                    RichText(
                                      text: TextSpan(
                                          text: "AED",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                          children: [
                                            WidgetSpan(
                                              child: SizedBox(width: 5),
                                            ),
                                            TextSpan(
                                                text: closedContracts[index]
                                                    .contractRentamount!
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: AppUtils.buildNormalText(
                        text: "No Data!", fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget expiredcontracts() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Container(
        margin: EdgeInsets.all(5),
        color: Colors.white,
        child: ExpansionTile(
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.home),
          ),
          title: AppUtils.buildNormalText(
              text: "Expired Contracts  ${expiredContracts.length}",
              fontSize: 14,
              fontWeight: FontWeight.w500),
          children: [
            expiredContracts.isNotEmpty
                ? ListView.builder(
                    itemCount: expiredContracts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Contract No # ${expiredContracts[index].contractErajno ?? "-"}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              expiredContracts[index]
                                                  .contractTenantname
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text: "Building",
                                            color: Colors.grey,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text: "Unit",
                                            color: Colors.grey,
                                            fontSize: 12),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text: expiredContracts[index]
                                                .contractBuilding
                                                .toString(),
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text: expiredContracts[index]
                                                .contractUnitno
                                                .toString(),
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text: "Contract Duration",
                                            color: Colors.grey,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text: "Building Type",
                                            color: Colors.grey,
                                            fontSize: 12),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppUtils.buildNormalText(
                                            text:
                                                "${expiredContracts[index].contractStartdate.toString()}-to-${expiredContracts[index].contractEnddate!.toString()}",
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: 12),
                                        AppUtils.buildNormalText(
                                            text:
                                                'AED ${expiredContracts[index].contractRentamount!.toString() == "null" ? "0" : expiredContracts[index].contractRentamount!.toString()}',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 10,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return Flex(
                                              direction: Axis.horizontal,
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: List.generate(
                                                  (constraints.constrainWidth() /
                                                          10)
                                                      .floor(),
                                                  (index) => SizedBox(
                                                        height: 1,
                                                        width: 5,
                                                        child: DecoratedBox(
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                        ),
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 10,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(10)),
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Rental Amount",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                    RichText(
                                      text: TextSpan(
                                          text: "AED",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                          children: [
                                            WidgetSpan(
                                              child: SizedBox(width: 5),
                                            ),
                                            TextSpan(
                                                text: expiredContracts[index]
                                                    .contractRentamount!
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: AppUtils.buildNormalText(
                        text: "No Data!", fontSize: 16)),
          ],
        ),
      ),
    );
  }

  convertdateformat(datetime) {
    //return DateFormat("dd-mm-yyyy").format(datetime);

    // String formattedDate = DateFormat('yyyy-MM-dd').format(datetime);

    return DateFormat("dd-MM-yyyy").format(DateTime.parse(datetime));
  }

  void getContracts() async {
    setState(() {
      loading = true;
    });

    try {
      final response = await Apiservice.getcontracts();

      setState(() {
        loading = false;
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'].toString() == "true") {
          List contractsJsonList = jsonData['message'] ?? [];

          allContracts =
              contractsJsonList.map((c) => ContractModel.fromJson(c)).toList();

          // Categorize contracts by status
          activeContracts =
              allContracts.where((c) => c.contractStatus == "ACTIVE").toList();

          closedContracts =
              allContracts.where((c) => c.contractStatus == "CLOSED").toList();

          expiredContracts = allContracts
              .where((c) =>
                  c.contractStatus == "EXPIRED" ||
                  c.contractStatus == "RENEWED")
              .toList();

          // Calculate total security deposit for active contracts
          totalActiveSecurityDeposit = activeContracts.fold(
              0,
              (prev, c) =>
                  prev +
                  (double.tryParse(
                          c.contractSecuritydeposit?.toString() ?? '0') ??
                      0));
        } else {
          // Handle false status response
          allContracts.clear();
          activeContracts.clear();
          closedContracts.clear();
          expiredContracts.clear();
          totalActiveSecurityDeposit = 0;

          AppUtils.showSingleDialogPopup(
              context, jsonData['message'].toString(), "Ok", exitpopup);
        }
      } else {
        throw Exception('Failed to load contracts: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        loading = false;
      });

      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
    }
  }

  void exitpopup() {
    AppUtils.pop(context);
  }

  foldqty() {
    totalActiveSecurityDeposit = activeContracts.fold(
        0,
        (prev, c) =>
            prev +
            (double.tryParse(c.contractSecuritydeposit?.toString() ?? '0') ??
                0));

    return '$totalActiveSecurityDeposit';
  }
}
