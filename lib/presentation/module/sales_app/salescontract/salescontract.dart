import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../data/api_service.dart';
import '../../../model/sales_contractmodel.dart';
import '../../../util/app_colors.dart';
import '../../../util/app_utils.dart';



// ---------------- Main Page ----------------



class Salescontract extends StatefulWidget {
  const Salescontract({super.key});

  @override
  State<Salescontract> createState() => _SalescontractState();
}

class _SalescontractState extends State<Salescontract> {
  bool loading = false;
  List<SalesList> salesList = [];

  @override
  void initState() {
    super.initState();
    getsales();
  }

  void getsales() async {
    setState(() => loading = true);
    try {
      final response = await Apiservice.getsalescontracts();
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'].toString() == "true") {
          SalescontractModel model = SalescontractModel.fromJson(jsonData);
          setState(() {
            salesList = model.data;
            loading = false;
          });
        } else {
          setState(() => loading = false);
          AppUtils.showSingleDialogPopup(
              context, jsonData['message'].toString(), "Ok", () {
            AppUtils.pop(context);
          });
        }
      } else {
        throw Exception('Failed to load contracts');
      }
    } catch (e) {
      setState(() => loading = false);
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", () {
        AppUtils.pop(context);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightCream,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          "Sales Contracts",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : salesList.isEmpty
              ? const Center(
                  child: Text("No contracts found",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: salesList.length,
                  itemBuilder: (context, index) {
                    final contract = salesList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ContractDetailPage(
                              contract: contract,
                              initialTab: 0,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                      
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              // Texts centered
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contract.customerName ?? 'No Name',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 6),
                                    _infoRow(
                                        "Contract ID", contract.contractId),
                                    const SizedBox(height: 4),
                                    _infoRow(
                                      "Date",
                                      contract.date != null
                                          ? "${contract.date!.day}/${contract.date!.month}/${contract.date!.year}"
                                          : "-",
                                    ),
                                  ],
                                ),
                              ),

                              // Stylish arrow button
                              Material(
                                color: AppColor.accentColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.all(
                                        Radius.circular(5))),
                                elevation: 1,
                                child: InkWell(
                                  customBorder: const RoundedRectangleBorder(),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ContractDetailPage(
                                          contract: contract,
                                          initialTab: 0,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.all(10), // circular size
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _infoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$title:",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value ?? '-',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Detail Page ----------------


class ContractDetailPage extends StatefulWidget {
  final SalesList contract;
  final int initialTab;

  const ContractDetailPage({
    super.key,
    required this.contract,
    this.initialTab = 0,
  });

  @override
  State<ContractDetailPage> createState() => _ContractDetailPageState();
}

class _ContractDetailPageState extends State<ContractDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = widget.initialTab;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

Widget _infoRow(String title, String? value, {Color valueColor = Colors.black}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "$title:",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            value ?? '-',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: valueColor, 
            ),
          ),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final contract = widget.contract;

    return Scaffold(
      backgroundColor: AppColor.lightCream,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          contract.customerName ?? "Contract Detail",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),

      // ❗ TabBar moved to BODY
      body: 
      Column(
        children: [
          // ------------------------
          //     CUSTOM TAB BAR
          // ------------------------
          Container(
            color: AppColor.lightCream,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: TabBar(
              isScrollable: false,
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColor.accentColor,
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: AppColor.white,
              unselectedLabelColor: AppColor.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicatorPadding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              labelPadding: EdgeInsets.zero,
              tabs: const [
                Tab(text: "Overview"),
                Tab(text: "Items"),
                Tab(text: "Pricing"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ------------------------
          //     TAB CONTENT
          // ------------------------
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // ------------------ Overview Tab ------------------
                ListView(
                  padding: const EdgeInsets.all(4),
                  children: [
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow("Contract ID", contract.contractId),
                            _infoRow("Property Name", contract.propertyName),
                            _infoRow("Unit Name", contract.unitName),
                            _infoRow("Unit Type", contract.unitType),
                            _infoRow("Billing Name", contract.buildingSegment),
                            _infoRow("Base Ref", contract.baseRef),
                            _infoRow("Segment", contract.unitSegment),
                            _infoRow(
                              "Date",
                              contract.date != null
                                  ? "${contract.date!.day}/${contract.date!.month}/${contract.date!.year}"
                                  : "-",
                            ),
                   _infoRow("Amount","AED ${(contract.total ?? 0.0).toStringAsFixed(2)}",valueColor: Colors.blue),

                            _infoRow("Status", contract.status),
                            // _infoRow("Created By",   contract.createdAt != null
                            //       ? "${contract.createdAt!.day}/${contract.createdAt!.month}/${contract.createdAt!.year}"
                            //       : "-",),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // ------------------ Items Tab ------------------
                contract.items == null || contract.items!.isEmpty
                    ? const Center(child: Text("No items available"))
                    : ListView(
                        padding: const EdgeInsets.all(4),
                        children: contract.items!
                            .map(
                              (item) => Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                    title: Text(
                                      item.unitName ?? '-',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 4,),
                                        // Property
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Property Name:",
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                item.propertyName ?? "-",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 6),

                                        // Amount
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Amount:",
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                "AED ${item.amount?.toStringAsFixed(2)} "?? "-",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            )
                            .toList(),
                      ),

                // ------------------ Pricing Tab ------------------
                contract.pricingSchedule == null ||
                        contract.pricingSchedule!.isEmpty
                    ? const Center(child: Text("No pricing schedule available"))
                    : ListView(
                        padding: const EdgeInsets.all(4),
                        children: contract.pricingSchedule!
                            .map(
                              (p) => Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  title: Text(
                                    p.installment ?? '-',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Amount
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Amount:",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              "AED ${p.amount?.toStringAsFixed(2)}" ?? "-",
                                              style: TextStyle(
                                              color: Colors.blue,
                                               fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 6),

                                      // Percent
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              "Percent:",
                                              style: TextStyle(
                                         
                                                color: Colors.grey,
               
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              "${p.pricingPercent ?? '-'}%",
                                              style: TextStyle(
                                                 fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    
                           

                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
