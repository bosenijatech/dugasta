


import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../data/api_service.dart';
import '../../../model/sales_estimatemodel.dart';
import '../../../util/app_colors.dart';
import '../../../util/app_utils.dart';

class Salesestimate extends StatefulWidget {
  const Salesestimate({super.key});

  @override
  State<Salesestimate> createState() => _SalesestimateState();
}

class _SalesestimateState extends State<Salesestimate> {
  bool loading = false;
  List<SalesestimateList> estimateList = [];

  @override
  void initState() {
    super.initState();
    getsestimate();
  }

  void getsestimate() async {
    setState(() => loading = true);

    print("📌 API Call: getsalesestimate() called");

    try {
      final response = await Apiservice.getsalesestimate();

      print("📌 API Status Code: ${response.statusCode}");
      print("📌 Raw API Response: ${response.body}");

      final jsonData = jsonDecode(response.body);

      print("📌 Decoded JSON: $jsonData");

      if (response.statusCode == 200 &&
          jsonData['status'].toString() == "true") {
        
        SalesestimateModel model = SalesestimateModel.fromJson(jsonData);

        print("📌 Total Estimates Found: ${model.data.length}");

        for (var e in model.data) {
          print("➡️ Estimate Item: ${e.estimateId} | ${e.customerName}");
        }

        setState(() {
          estimateList = model.data;
          loading = false;
        });
      } else {
        setState(() => loading = false);
        print("❌ API Error Message: ${jsonData['message']}");

        AppUtils.showSingleDialogPopup(context, jsonData['message'], "Ok", () {
          AppUtils.pop(context);
        });
      }
    } catch (e) {
      setState(() => loading = false);

      print("❌ Exception: $e");

      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", () {
        AppUtils.pop(context);
      });
    }
  }

  Widget _infoRow(String title, String? value, {Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text("$title:",
                style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value ?? "-",
              style:  TextStyle(fontWeight: FontWeight.w600,  color: valueColor, ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("📌 estimateList Length in UI: ${estimateList.length}");

    return Scaffold(
      backgroundColor: AppColor.lightCream,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          "Sales Estimate",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : estimateList.isEmpty
              ? const Center(child: Text("No Estimate Found"))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: estimateList.length,
                  itemBuilder: (context, index) {
                    final est = estimateList[index];

                    print("➡️ Building Card for: ${est.customerName}");

                    return GestureDetector(
                      onTap: () {
                        print("➡️ Card Tapped → Opening Detail Page");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EstimateDetailPage(
                              estimate: est,
                              initialTab: 0,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      est.customerName ?? "No Name",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 6),
                                    _infoRow("Estimate ID", est.estimateId),
                                  ],
                                ),
                              ),
                              Material(
                                color: AppColor.accentColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5))),
                                elevation: 1,
                                child: InkWell(
                                  onTap: () {
                                    print("➡️ Arrow Tapped → Opening Details");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EstimateDetailPage(
                                          estimate: est,
                                          initialTab: 0,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
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
                  }),
    );
  }
}





class EstimateDetailPage extends StatefulWidget {
  final SalesestimateList estimate;
  final int initialTab;
  const EstimateDetailPage(
      {super.key, required this.estimate, this.initialTab = 0});

  @override
  State<EstimateDetailPage> createState() => _EstimateDetailPageState();
}

class _EstimateDetailPageState extends State<EstimateDetailPage>
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

  Widget _infoRow(String title, String? value,{Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$title:",
              style: const TextStyle( color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value ?? "-",
              style:  TextStyle(fontWeight: FontWeight.w600,  color: valueColor, ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final est = widget.estimate;

    return Scaffold(
      backgroundColor: AppColor.lightCream,
      appBar: AppBar(
        
        backgroundColor: AppColor.primary,
        title: Text(
          est.customerName ?? "Estimate",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),

      // -------------------------
      // TAB BAR INSIDE BODY
      // -------------------------
      body: Column(
        children: [
          // ---------- Rounded TabBar ----------
Container(
  padding: const EdgeInsets.symmetric(vertical: 6),
  color: AppColor.lightCream,
  child: TabBar(
    controller: _tabController,
    isScrollable: false,

    // Selected text color
    labelColor: AppColor.white,

    // Unselected text color
    unselectedLabelColor: Colors.black,

    // ❌ REMOVE default underline completely
    indicatorSize: TabBarIndicatorSize.tab,
dividerColor: Colors.transparent,
    // 🔥 FULL width rounded indicator
    indicator: BoxDecoration(
      color: AppColor.accentColor,
      borderRadius: BorderRadius.circular(12),
    ),

    // Better padding to make it look like big buttons
    indicatorPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    labelPadding: EdgeInsets.zero,

    tabs: const [
      Tab(text: "Overview"),
      Tab(text: "Items"),
      Tab(text: "Pricing"),
    ],
  ),
)
,

          // -----------------------------------
          // TAB VIEWS
          // -----------------------------------
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // -------------- OVERVIEW --------------
                ListView(
                  padding: const EdgeInsets.all(4),
                  children: [
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow("Estimate ID", est.estimateId),
                            _infoRow("Property Name", est.propertyName.toString().split('.').last),
                            _infoRow("Unit Name", est.unitName),
                            _infoRow("Unit Type", est.unitType),
                            _infoRow("Agent Name", est.agentName),
                      _infoRow("Estimate Amount", "AED ${est.total!.toStringAsFixed(2)}",valueColor: Colors.blue),
                            _infoRow("Status", est.approvalStatus),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // -------------- ITEMS --------------
                est.items == null || est.items!.isEmpty
                    ? const Center(child: Text("No items available"))
                    : ListView(
                        padding: const EdgeInsets.all(4),
                        children: est.items!.map((item) {
                          return Card(
                          color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(item.item ?? '-',style: TextStyle(fontWeight: FontWeight.w700 ),),
                              subtitle: 
                             

                            Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "Unit Name: ",
            style: TextStyle(
          
              color:Colors.grey,
            ),
          ),
        ),
        Expanded(
           flex: 5,
          child: Text(
            item.unitName ?? '-',
            style: TextStyle(
              
              fontWeight: FontWeight.w600,
           
            ),
          ),
        ),
      ],
    ),
    SizedBox(height: 6),

    Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "Property Name: ",
            style: TextStyle(
             
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            item.propertyName ?? '-',
            style: TextStyle(
            
              fontWeight: FontWeight.w600,
             
            ),
          ),
        ),
      ],
    ),
    SizedBox(height: 6),

    Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "Tax Percent: ",
            style: TextStyle(
              
              color: Colors.grey
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
     item.taxRate != null 
  ? '${item.taxRate}%' 
  : '-',

            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
           
            ),
          ),
        ),
      ],
    ),
    SizedBox(height: 6),

    Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "Amount: ",
            style: TextStyle(
                 
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            "AED ${item.amount!.toStringAsFixed(2) ?? 00}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blue
           
            ),
          ),
        ),
      ],
    ),
  ],
)

                            ),
                          );
                        }).toList(),
                      ),

                // -------------- PRICING --------------
                est.pricingSchedule == null || est.pricingSchedule!.isEmpty
                    ? const Center(
                        child: Text("No pricing schedule available"),
                      )
                    : ListView(
                        padding: const EdgeInsets.all(4),
                        children: est.pricingSchedule!.map((p) {
                          return Card(
color: Colors.white,
                 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(p.installmentNumber ?? '-',style: TextStyle(fontWeight: FontWeight.w700 ),),
                              subtitle: 
                              

                           Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "Percent: ",
            style: TextStyle(
              fontSize: 14,
             
                   color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            "${p.pricingPercent ?? 0}%",
            style: TextStyle(
            
              fontWeight: FontWeight.w600,
             
            ),
          ),
        ),
      ],
    ),
    SizedBox(height: 6),

    Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "Amount: ",
            style: TextStyle(
             
                color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            "AED ${p.amount!.toStringAsFixed(2) ?? 00}",
            style: TextStyle(
       
              fontWeight: FontWeight.w600,
           color: Colors.blue
            ),
          ),
        ),
      ],
    ),
    SizedBox(height: 6),

    // Row(
    //   children: [
    //     Expanded(
    //       flex: 3,
    //       child: Text(
    //         "Stage: ",
    //         style: TextStyle(
    //               color: Colors.grey,
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       flex: 5,
    //       child: Text(
    //      p.stageName.toString()?? "-",
    //         style: TextStyle(
            
    //           fontWeight: FontWeight.w600,
            
    //         ),
    //       ),
    //     ),
    //   ],
    // ),
  ],
)

                            ),
                            
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
